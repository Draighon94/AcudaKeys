import 'dart:io';

import 'package:acuda_keys/l10n/app_localizations.dart';
import 'package:acuda_keys/providers/lista_partes_controller.dart';
import 'package:acuda_keys/widgets/filtro_partes.dart';
import 'package:acuda_keys/widgets/lista_partes_item.dart';
import 'package:acuda_keys/widgets/widgets_windows/filtro_partes_windows.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ConsultarPartesView extends ConsumerStatefulWidget {
  const ConsultarPartesView({super.key});

  @override
  ConsumerState<ConsultarPartesView> createState() {
    return _ConsultarPartesViewState();
  }
}

class _ConsultarPartesViewState extends ConsumerState<ConsultarPartesView> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    var listaPartes =
        ref.watch(listaPartesControllerProvider).reversed.toList();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          l10n.consultarPartes,
          style: GoogleFonts.manrope(
            color: Theme.of(context).dialogTheme.backgroundColor,
            fontSize: MediaQuery.sizeOf(context).width > 400 ? 25 : 22,
            fontWeight: FontWeight.bold,
            shadows: [
              const Shadow(
                offset: Offset(1, 1),
                color: Colors.black,
                blurRadius: 20,
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Theme.of(context).dialogTheme.backgroundColor,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                l10n.volver,
                style: GoogleFonts.manrope(
                  color: Theme.of(context).dialogTheme.backgroundColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(200, 255, 255, 255),
        child: Center(
          child:
              Platform.isAndroid
                  ? const FiltroPartes()
                  : const FiltroPartesWindows(),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).secondaryHeaderColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child:
            listaPartes.isNotEmpty
                ? Padding(
                  padding: const EdgeInsets.only(top: 110, left: 10, right: 10),
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 0),
                    itemCount: listaPartes.length,
                    itemBuilder: (context, index) {
                      return ListaPartesItem(item: listaPartes[index]);
                    },
                  ),
                )
                : Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).dialogTheme.backgroundColor,
                  ),
                ),
      ),
    );
  }
}

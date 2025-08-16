import 'dart:io';

import 'package:acuda_keys/l10n/app_localizations.dart';
import 'package:acuda_keys/providers/llave_controller.dart';
import 'package:acuda_keys/widgets/filtro.dart';
import 'package:acuda_keys/widgets/lista_llaves.dart';
import 'package:acuda_keys/widgets/widgets_windows/filtro_clientes_windows.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ConsultarLlaveView extends ConsumerStatefulWidget {
  const ConsultarLlaveView({super.key});

  @override
  ConsumerState<ConsultarLlaveView> createState() {
    return _ConsultarLlaveViewState();
  }
}

class _ConsultarLlaveViewState extends ConsumerState<ConsultarLlaveView> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    var listaClientes = ref.watch(llaveControllerProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          l10n.consultarLlaves,
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
      extendBodyBehindAppBar: true,
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(200, 255, 255, 255),
        child: Center(
          child:
              Platform.isAndroid
                  ? const Filtro()
                  : const FiltroClientesWindows(),
        ),
      ),
      body:
          listaClientes.isNotEmpty
              ? Container(
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
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 40,
                      top: Platform.isAndroid ? 110 : 60,
                      right: 40,
                      bottom: Platform.isAndroid ? 0 : 25,
                    ),
                    child: ListaLlaves(listaClientes: listaClientes),
                  ),
                ),
              )
              : Container(
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
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 40,
                      top: 100,
                      right: 40,
                      bottom: MediaQuery.sizeOf(context).width > 400 ? 25 : 100,
                    ),
                    child: CircularProgressIndicator(
                      color: Theme.of(context).dialogTheme.backgroundColor,
                    ),
                  ),
                ),
              ),
    );
  }
}

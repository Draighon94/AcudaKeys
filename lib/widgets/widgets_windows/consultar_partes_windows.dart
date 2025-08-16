import 'package:acuda_keys/l10n/app_localizations.dart';
import 'package:acuda_keys/providers/lista_partes_controller.dart';
import 'package:acuda_keys/widgets/lista_partes_item.dart';
import 'package:acuda_keys/widgets/widgets_windows/filtro_partes_windows.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ConsultarPartesWindowsView extends ConsumerStatefulWidget {
  const ConsultarPartesWindowsView({super.key});

  @override
  ConsumerState<ConsultarPartesWindowsView> createState() {
    return _ConsultarPartesViewState();
  }
}

class _ConsultarPartesViewState
    extends ConsumerState<ConsultarPartesWindowsView> {
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
        iconTheme: const IconThemeData(color: Colors.white),
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
      drawer: const Drawer(
        backgroundColor: Color.fromARGB(200, 255, 255, 255),
        child: Center(child: FiltroPartesWindows()),
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
                  padding: const EdgeInsets.only(
                    top: 60,
                    left: 25,
                    right: 25,
                    bottom: 25,
                  ),
                  child: GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                    childAspectRatio: 260 / 100,
                    children: [
                      for (var i = 0; i < listaPartes.length; i++)
                        ListaPartesItem(item: listaPartes[i]),
                    ],
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

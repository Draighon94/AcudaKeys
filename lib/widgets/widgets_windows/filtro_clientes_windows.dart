import 'package:acuda_keys/l10n/app_localizations.dart';
import 'package:acuda_keys/providers/llave_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class FiltroClientesWindows extends ConsumerWidget {
  const FiltroClientesWindows({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nombreClienteController = TextEditingController();
    final nombreCraController = TextEditingController();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Container(
            height: 180,
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
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 10),
                    child: Image.asset('assets/icon/icon.png', scale: 10),
                  ),
                ),
                Text(
                  'Acuda Keys',
                  style: GoogleFonts.manrope(
                    color: Theme.of(context).dialogTheme.backgroundColor,
                    fontSize: 20,
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
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).drawerTheme.backgroundColor,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
                child: Column(
                  children: [
                    Text(
                      l10n.filtrosDeBusqueda,
                      style: GoogleFonts.manrope(
                        color:
                            Theme.of(context).brightness == Brightness.light
                                ? const Color.fromARGB(200, 2, 28, 114)
                                : const Color.fromARGB(185, 2, 255, 200),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(
                      thickness: 1.5,
                      color:
                          Theme.of(context).brightness == Brightness.light
                              ? const Color.fromARGB(200, 2, 28, 114)
                              : const Color.fromARGB(185, 2, 255, 200),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          l10n.cliente,
                          style: GoogleFonts.manrope(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? const Color.fromARGB(200, 2, 28, 114)
                                    : const Color.fromARGB(185, 2, 255, 200),
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 180,
                          child: TextField(
                            cursorColor: const Color.fromARGB(200, 2, 28, 114),
                            controller: nombreClienteController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              fillColor:
                                  Theme.of(context).dialogTheme.backgroundColor,
                              filled: true,
                            ),
                            style: GoogleFonts.manrope(
                              color: const Color.fromARGB(200, 2, 28, 114),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        FloatingActionButton(
                          onPressed: () {
                            //llamamos al metodo de filtrado por cliente
                            ref
                                .read(llaveControllerProvider.notifier)
                                .filtrarPorCliente(
                                  nombreClienteController.text.trim(),
                                );

                            //cerramos el drawer
                            Navigator.of(context).pop();
                          },
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? const Color.fromARGB(200, 2, 28, 114)
                                  : const Color.fromARGB(185, 2, 255, 200),
                          child: Icon(
                            Icons.search_rounded,
                            color:
                                Theme.of(context).dialogTheme.backgroundColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          l10n.cra,
                          style: GoogleFonts.manrope(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? const Color.fromARGB(200, 2, 28, 114)
                                    : const Color.fromARGB(185, 2, 255, 200),
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 180,
                          child: TextField(
                            cursorColor: const Color.fromARGB(200, 2, 28, 114),
                            controller: nombreCraController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              fillColor:
                                  Theme.of(context).dialogTheme.backgroundColor,
                              filled: true,
                            ),
                            style: GoogleFonts.manrope(
                              color: const Color.fromARGB(200, 2, 28, 114),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        FloatingActionButton(
                          onPressed: () {
                            //llamamos al metodo de filtrado por CRA
                            ref
                                .read(llaveControllerProvider.notifier)
                                .filtrarPorCra(nombreCraController.text.trim());

                            //cerramos el drawer
                            Navigator.of(context).pop();
                          },
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? const Color.fromARGB(200, 2, 28, 114)
                                  : const Color.fromARGB(185, 2, 255, 200),
                          child: Icon(
                            Icons.search_rounded,
                            color:
                                Theme.of(context).dialogTheme.backgroundColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FloatingActionButton.extended(
                          onPressed: () {
                            //Reiniciamos el filtro obteniendo todos los clientes
                            ref
                                .read(llaveControllerProvider.notifier)
                                .obtenerClientes();
                            //cerramos el drawer
                            Navigator.of(context).pop();
                          },
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? const Color.fromARGB(200, 2, 28, 114)
                                  : const Color.fromARGB(185, 2, 255, 200),
                          label: Text(
                            l10n.reiniciar,
                            style: GoogleFonts.manrope(
                              color:
                                  Theme.of(context).dialogTheme.backgroundColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          icon: Icon(
                            Icons.restart_alt_rounded,
                            color:
                                Theme.of(context).dialogTheme.backgroundColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

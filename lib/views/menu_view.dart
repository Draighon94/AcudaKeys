import 'dart:io';

import 'package:acuda_keys/l10n/app_localizations.dart';
import 'package:acuda_keys/providers/auth_controller.dart';
import 'package:acuda_keys/views/agregar_llave_view.dart';
import 'package:acuda_keys/views/consultar_llave_view.dart';
import 'package:acuda_keys/views/consultar_partes_view.dart';
import 'package:acuda_keys/views/generar_informe_preview.dart';
import 'package:acuda_keys/views/realizar_parte_view.dart';
import 'package:acuda_keys/views/enviar_parte_view.dart';
import 'package:acuda_keys/widgets/boton_acerdade.dart';
import 'package:acuda_keys/widgets/boton_ajustes.dart';
import 'package:acuda_keys/widgets/widgets_windows/agregar_llave_windows.dart';
import 'package:acuda_keys/widgets/widgets_windows/consultar_llave_windows.dart';
import 'package:acuda_keys/widgets/widgets_windows/consultar_partes_windows.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuView extends ConsumerStatefulWidget {
  const MenuView({super.key});

  @override
  ConsumerState<MenuView> createState() {
    return _MenuViewState();
  }
}

class _MenuViewState extends ConsumerState<MenuView> {
  @override
  Widget build(BuildContext context) {
    User? user = ref.watch(authControllerProvider);
    final l10n = AppLocalizations.of(context)!;
    String userMode =
        user!.email!.contains('admin') ? l10n.admin : l10n.vigilante;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Acuda Keys',
          style: GoogleFonts.manrope(
            color: Theme.of(context).dialogTheme.backgroundColor,
            fontSize: 25,
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
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: Text(
                        l10n.cerrarSesion,
                        style: GoogleFonts.manrope(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? const Color.fromARGB(200, 2, 28, 114)
                                  : const Color.fromARGB(185, 2, 255, 200),
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      content: Text(
                        l10n.confirmacionCerrarSesion,
                        style: GoogleFonts.manrope(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? const Color.fromARGB(200, 2, 28, 114)
                                  : const Color.fromARGB(185, 2, 255, 200),
                          fontSize: 17,
                        ),
                      ),
                      backgroundColor:
                          Theme.of(context).drawerTheme.backgroundColor,
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, l10n.no),
                          child: Text(
                            l10n.no,
                            style: GoogleFonts.manrope(
                              color:
                                  Theme.of(context).brightness ==
                                          Brightness.light
                                      ? const Color.fromARGB(200, 2, 28, 114)
                                      : const Color.fromARGB(185, 2, 255, 200),
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, l10n.si);
                            ref
                                .read(authControllerProvider.notifier)
                                .cerrarSesion();
                          },
                          child: Text(
                            l10n.si,
                            style: GoogleFonts.manrope(
                              color:
                                  Theme.of(context).brightness ==
                                          Brightness.light
                                      ? const Color.fromARGB(200, 2, 28, 114)
                                      : const Color.fromARGB(185, 2, 255, 200),
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
              );
            },
            style: ElevatedButton.styleFrom(
              iconColor: Theme.of(context).dialogTheme.backgroundColor,
              shadowColor: Colors.black,
            ),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      extendBody: true,
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
        width: double.infinity,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    top: MediaQuery.sizeOf(context).width < 400 ? 40 : 0,
                  ),
                  child: Row(
                    children: [
                      Text(
                        '${l10n.usuario}: $userMode',
                        style: GoogleFonts.manrope(
                          color: Theme.of(context).dialogTheme.backgroundColor,
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
                SizedBox(
                  height: MediaQuery.sizeOf(context).width < 400 ? 40 : 100,
                ),
                SizedBox(
                  width: 264.9,
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            if (Platform.isAndroid) {
                              return const ConsultarLlaveView();
                            } else {
                              return const ConsultarLlaveViewWindows();
                            }
                          },
                        ),
                      );
                    },
                    backgroundColor: const Color.fromARGB(185, 2, 28, 114),
                    label: Text(
                      l10n.consultarLlaves,
                      style: GoogleFonts.manrope(
                        color: Theme.of(context).dialogTheme.backgroundColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    icon: Icon(
                      Icons.key_rounded,
                      color: Theme.of(context).dialogTheme.backgroundColor,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                //si estamos conectados con un usuario distinto al del admin, el menú cambia
                if (user.email != 'admin@acudakeys.com')
                  Column(
                    children: [
                      SizedBox(
                        width: 264.9,
                        child: FloatingActionButton.extended(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const RealizarParteView(),
                              ),
                            );
                          },
                          backgroundColor: const Color.fromARGB(
                            186,
                            2,
                            28,
                            114,
                          ),
                          label: Text(
                            l10n.realizarParte,
                            style: GoogleFonts.manrope(
                              color:
                                  Theme.of(context).dialogTheme.backgroundColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          icon: Icon(
                            Icons.edit_document,
                            color:
                                Theme.of(context).dialogTheme.backgroundColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      SizedBox(
                        width: 264.9,
                        child: FloatingActionButton.extended(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const EnviarParteView(),
                              ),
                            );
                          },
                          backgroundColor: const Color.fromARGB(
                            186,
                            2,
                            28,
                            114,
                          ),
                          label: Text(
                            l10n.enviarParte,
                            style: GoogleFonts.manrope(
                              color:
                                  Theme.of(context).dialogTheme.backgroundColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          icon: Icon(
                            Icons.mail_outlined,
                            color:
                                Theme.of(context).dialogTheme.backgroundColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                //si estamos conectados con el usuario admin, tendremos funciones únicas
                if (user.email == 'admin@acudakeys.com')
                  Column(
                    children: [
                      SizedBox(
                        width: 264.9,
                        child: FloatingActionButton.extended(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  if (Platform.isAndroid) {
                                    return const AgregarLlaveView();
                                  } else {
                                    return const AgregarLlaveWindows();
                                  }
                                },
                              ),
                            );
                          },
                          backgroundColor: const Color.fromARGB(
                            186,
                            2,
                            28,
                            114,
                          ),
                          label: Text(
                            l10n.agregarLlave,
                            style: GoogleFonts.manrope(
                              color:
                                  Theme.of(context).dialogTheme.backgroundColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          icon: Icon(
                            Icons.add_rounded,
                            color:
                                Theme.of(context).dialogTheme.backgroundColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      SizedBox(
                        width: 264.9,
                        child: FloatingActionButton.extended(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  if (Platform.isAndroid) {
                                    return const ConsultarPartesView();
                                  } else {
                                    return const ConsultarPartesWindowsView();
                                  }
                                },
                              ),
                            );
                          },
                          backgroundColor: const Color.fromARGB(
                            186,
                            2,
                            28,
                            114,
                          ),
                          label: Text(
                            l10n.consultarPartes,
                            style: GoogleFonts.manrope(
                              color:
                                  Theme.of(context).dialogTheme.backgroundColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          icon: Icon(
                            Icons.search_rounded,
                            color:
                                Theme.of(context).dialogTheme.backgroundColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 50),
                SizedBox(
                  width: 264.9,
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const GenerarInformePreview(),
                        ),
                      );
                    },
                    backgroundColor: const Color.fromARGB(186, 2, 28, 114),
                    label: Text(
                      l10n.generarInformeMensual,
                      style: GoogleFonts.manrope(
                        color: Theme.of(context).dialogTheme.backgroundColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    icon: Icon(
                      Icons.data_thresholding_rounded,
                      color: Theme.of(context).dialogTheme.backgroundColor,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 42),
                      child: BotonAcerdaDe(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 42),
                      child: BotonAjustes(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

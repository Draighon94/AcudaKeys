import 'dart:io';

import 'package:acuda_keys/l10n/app_localizations.dart';
import 'package:acuda_keys/models/parte.dart';
import 'package:acuda_keys/providers/lista_partes_controller.dart';
import 'package:acuda_keys/providers/parte_pdf_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ListaPartesItem extends ConsumerStatefulWidget {
  const ListaPartesItem({super.key, required this.item});

  final DocumentReference item;

  @override
  ConsumerState<ListaPartesItem> createState() {
    return _ListaPartesItemState();
  }
}

class _ListaPartesItemState extends ConsumerState<ListaPartesItem> {
  bool guardando = false;

  //metodo para descargar un parte de la base de datos
  Future<void> _guardarParte(
    BuildContext context,
    DocumentReference refParte,
    AppLocalizations l10n,
  ) async {
    setState(() {
      guardando = true;
    });
    Parte? parte = await ref
        .read(listaPartesControllerProvider.notifier)
        .guardarParte(refParte);

    String? ruta = await ref
        .read(partePDFControllerProvider.notifier)
        .generarParte(parte!);
    setState(() {
      guardando = false;
    });

    if (ruta == '') {
      _guardadoIncorrecto(context, l10n);
    } else {
      _guardadoCorrecto(context, ruta, l10n);
    }
  }

  //metodo que muestra el dialogo si se ha guardado el parte correctamente
  Future<void> _guardadoCorrecto(
    BuildContext context,
    String rutaDescargas,
    AppLocalizations l10n,
  ) {
    if (Platform.isAndroid) {
      rutaDescargas = 'Descargas';
    }

    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
          title: Text(
            l10n.parteGuardado,
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
            '${l10n.guardadoEn}:\n$rutaDescargas',
            style: GoogleFonts.manrope(
              color:
                  Theme.of(context).brightness == Brightness.light
                      ? const Color.fromARGB(200, 2, 28, 114)
                      : const Color.fromARGB(185, 2, 255, 200),
              fontSize: 17,
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                l10n.aceptar,
                style: GoogleFonts.manrope(
                  color:
                      Theme.of(context).brightness == Brightness.light
                          ? const Color.fromARGB(200, 2, 28, 114)
                          : const Color.fromARGB(185, 2, 255, 200),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  //metodo que muestra el mensaje si ha habido un error al guardar el mensaje
  Future<void> _guardadoIncorrecto(
    BuildContext context,
    AppLocalizations l10n,
  ) {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
          title: Text(
            l10n.errorGuardar,
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
            l10n.rutaNoSeleccionada,
            style: GoogleFonts.manrope(
              color:
                  Theme.of(context).brightness == Brightness.light
                      ? const Color.fromARGB(200, 2, 28, 114)
                      : const Color.fromARGB(185, 2, 255, 200),
              fontSize: 17,
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                l10n.aceptar,
                style: GoogleFonts.manrope(
                  color:
                      Theme.of(context).brightness == Brightness.light
                          ? const Color.fromARGB(200, 2, 28, 114)
                          : const Color.fromARGB(185, 2, 255, 200),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(186, 2, 28, 114)),
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).bannerTheme.backgroundColor!,
              Theme.of(context).bannerTheme.dividerColor!,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            ListTile(
              title: Center(
                child: Text(
                  widget.item.id,
                  style: GoogleFonts.manrope(
                    color: Theme.of(context).dialogTheme.backgroundColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (!guardando)
              FloatingActionButton.extended(
                onPressed: () {
                  _guardarParte(context, widget.item, l10n);
                },
                label: Text(
                  l10n.guardar,
                  style: GoogleFonts.manrope(
                    color: Theme.of(context).dialogTheme.backgroundColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: const Color.fromARGB(186, 2, 28, 114),
                icon: Icon(
                  Icons.download_rounded,
                  color: Theme.of(context).dialogTheme.backgroundColor,
                ),
              ),
            if (guardando)
              CircularProgressIndicator(
                color:
                    Theme.of(context).brightness == Brightness.light
                        ? const Color.fromARGB(200, 2, 28, 114)
                        : const Color.fromARGB(185, 2, 255, 200),
              ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

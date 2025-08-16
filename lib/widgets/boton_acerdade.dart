import 'package:acuda_keys/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BotonAcerdaDe extends StatelessWidget {
  const BotonAcerdaDe({super.key});

  //metodo que muestra el dialogo de Acerca de
  Future<void> acercaDe(BuildContext context, AppLocalizations l10n) {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            l10n.acercaDe,
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
            l10n.textAcercaDe,
            style: GoogleFonts.manrope(
              color:
                  Theme.of(context).brightness == Brightness.light
                      ? const Color.fromARGB(200, 2, 28, 114)
                      : const Color.fromARGB(185, 2, 255, 200),
              fontSize: 17,
            ),
            textAlign: TextAlign.justify,
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
          backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return IconButton(
      onPressed: () {
        acercaDe(context, l10n);
      },
      icon: const Icon(Icons.help_outline_rounded),
      color: Theme.of(context).dialogTheme.backgroundColor,
      padding: const EdgeInsets.only(left: 30),
      iconSize: 30,
    );
  }
}

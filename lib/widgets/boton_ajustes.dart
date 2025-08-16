import 'package:acuda_keys/l10n/app_localizations.dart';
import 'package:acuda_keys/widgets/widgets_ajustes/desplegable_idiomas.dart';
import 'package:acuda_keys/widgets/widgets_ajustes/desplegable_temas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class BotonAjustes extends ConsumerStatefulWidget {
  const BotonAjustes({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _BotonAjustesState();
  }
}

class _BotonAjustesState extends ConsumerState<BotonAjustes> {
  //metodo que muestra el dialogo de ajustes
  Future<void> _ajustes(BuildContext context, AppLocalizations l10n) async {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
          title: Text(
            l10n.ajustes,
            style: GoogleFonts.manrope(
              color:
                  Theme.of(context).brightness == Brightness.light
                      ? const Color.fromARGB(200, 2, 28, 114)
                      : const Color.fromARGB(185, 2, 255, 200),
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.idioma,
                    style: GoogleFonts.manrope(
                      color:
                          Theme.of(context).brightness == Brightness.light
                              ? const Color.fromARGB(200, 2, 28, 114)
                              : const Color.fromARGB(185, 2, 255, 200),
                      fontSize: 20,
                    ),
                  ),
                  const DesplegableIdiomas(),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.tema,
                    style: GoogleFonts.manrope(
                      color:
                          Theme.of(context).brightness == Brightness.light
                              ? const Color.fromARGB(200, 2, 28, 114)
                              : const Color.fromARGB(185, 2, 255, 200),
                      fontSize: 20,
                    ),
                  ),
                  const DesplegableTemas(),
                ],
              ),
            ],
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
    return IconButton(
      onPressed: () {
        _ajustes(context, l10n);
      },
      icon: const Icon(Icons.settings_rounded),
      color: Theme.of(context).dialogTheme.backgroundColor,
      padding: const EdgeInsets.only(right: 30),
      iconSize: 30,
    );
  }
}

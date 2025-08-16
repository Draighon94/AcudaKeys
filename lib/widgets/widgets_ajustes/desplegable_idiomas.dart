import 'package:acuda_keys/l10n/app_localizations.dart';
import 'package:acuda_keys/providers/idioma_actual_controller.dart';
import 'package:acuda_keys/providers/idioma_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class DesplegableIdiomas extends ConsumerStatefulWidget {
  const DesplegableIdiomas({super.key});

  @override
  ConsumerState<DesplegableIdiomas> createState() {
    return _DesplegableIdiomasState();
  }
}

class _DesplegableIdiomasState extends ConsumerState<DesplegableIdiomas> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    Locale idiomaActual = ref.watch(idiomaActualControllerProvider);
    List<Locale> idiomas = ref.watch(idiomaControllerProvider).toList();
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).drawerTheme.backgroundColor,
        border: Border.all(
          color:
              Theme.of(context).brightness == Brightness.light
                  ? const Color.fromARGB(200, 2, 28, 114)
                  : const Color.fromARGB(185, 2, 255, 200),
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 2),
        child: DropdownButton(
          dropdownColor: Theme.of(context).drawerTheme.backgroundColor,
          hint: Text(
            l10n.idioma,
            style: GoogleFonts.manrope(
              color:
                  Theme.of(context).brightness == Brightness.light
                      ? const Color.fromARGB(200, 2, 28, 114)
                      : const Color.fromARGB(185, 2, 255, 200),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          icon: const Icon(Icons.abc, color: Colors.transparent),
          borderRadius: BorderRadius.circular(15),
          underline: Container(
            decoration: const BoxDecoration(color: Colors.transparent),
          ),
          style: GoogleFonts.manrope(
            color:
                Theme.of(context).brightness == Brightness.light
                    ? const Color.fromARGB(200, 2, 28, 114)
                    : const Color.fromARGB(185, 2, 255, 200),
            fontWeight: FontWeight.bold,
          ),
          value: idiomaActual,
          items:
              idiomas.map((Locale locale) {
                String idioma = '';

                if (locale.toLanguageTag() == 'es') {
                  idioma = l10n.espaniol;
                } else if (locale.toLanguageTag() == 'en') {
                  idioma = l10n.ingles;
                } else if (locale.toLanguageTag() == 'zh') {
                  idioma = l10n.chino;
                } else if (locale.toLanguageTag() == 'ja') {
                  idioma = l10n.japones;
                }
                return DropdownMenuItem<Locale>(
                  value: locale,
                  child: Text(
                    idioma,
                    style: GoogleFonts.manrope(
                      color:
                          Theme.of(context).brightness == Brightness.light
                              ? const Color.fromARGB(200, 2, 28, 114)
                              : const Color.fromARGB(185, 2, 255, 200),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                );
              }).toList(),
          onChanged: (Locale? locale) {
            setState(() {
              idiomaActual = locale!;
              ref
                  .read(idiomaActualControllerProvider.notifier)
                  .cambiarIdioma(locale);
            });
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}

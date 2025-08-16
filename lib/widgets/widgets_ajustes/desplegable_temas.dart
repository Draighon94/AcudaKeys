import 'package:acuda_keys/l10n/app_localizations.dart';
import 'package:acuda_keys/providers/tema_actual_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class DesplegableTemas extends ConsumerStatefulWidget {
  const DesplegableTemas({super.key});

  @override
  ConsumerState<DesplegableTemas> createState() {
    return _DesplegableTemasState();
  }
}

class _DesplegableTemasState extends ConsumerState<DesplegableTemas> {
  List<ThemeMode> temas = ThemeMode.values;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    ThemeMode? temaActual = ref.watch(temaActualControllerProvider);
    List<ThemeMode> temas = [ThemeMode.light, ThemeMode.dark, ThemeMode.system];
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
          value: temaActual,
          items:
              temas.map((ThemeMode tema) {
                String nombreTema = '';
                if (tema.name == 'light') {
                  nombreTema = l10n.claro;
                } else if (tema.name == 'dark') {
                  nombreTema = l10n.oscuro;
                } else {
                  nombreTema = l10n.sistema;
                }
                return DropdownMenuItem<ThemeMode>(
                  value: tema,
                  child: Text(
                    nombreTema,
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
          onChanged: (ThemeMode? tema) {
            ref.read(temaActualControllerProvider.notifier).cambiarTema(tema!);
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}

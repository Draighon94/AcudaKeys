import 'package:acuda_keys/l10n/app_localizations.dart';
import 'package:acuda_keys/models/central_receptora_alarmas.dart';
import 'package:acuda_keys/providers/cras_controller.dart';
import 'package:acuda_keys/providers/realizar_parte_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class DesplegableCRAs extends ConsumerStatefulWidget {
  const DesplegableCRAs({super.key});

  @override
  ConsumerState<DesplegableCRAs> createState() {
    return _DesplegableCRAsState();
  }
}

class _DesplegableCRAsState extends ConsumerState<DesplegableCRAs> {
  CentralReceptoraAlarmas? _craSeleccionada;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    Map<String, TextEditingController> controladores = ref.watch(
      realizarParteControllerProvider,
    );
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
            l10n.cra,
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
            color: const Color.fromARGB(200, 2, 28, 114),
            fontWeight: FontWeight.bold,
          ),
          value: _craSeleccionada,
          items:
              ref.watch(cRAsControllerProvider).map((
                CentralReceptoraAlarmas cra,
              ) {
                return DropdownMenuItem<CentralReceptoraAlarmas>(
                  value: cra,
                  child: Text(
                    cra.nombre,
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
          onChanged: (CentralReceptoraAlarmas? cra) {
            setState(() {
              _craSeleccionada = cra;
              controladores['emailCRAController']!.text = cra!.email;
            });
          },
        ),
      ),
    );
  }
}

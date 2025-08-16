import 'package:acuda_keys/l10n/app_localizations.dart';
import 'package:acuda_keys/providers/realizar_parte_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class FormObservaciones extends ConsumerWidget {
  const FormObservaciones({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    Map<String, TextEditingController> controladores = ref.watch(
      realizarParteControllerProvider,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  l10n.observaciones,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.manrope(
                    color: Theme.of(context).dialogTheme.backgroundColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: TextFormField(
                  cursorColor: const Color.fromARGB(200, 2, 28, 114),
                  controller: controladores['observacionesController'],
                  style: GoogleFonts.manrope(
                    color: const Color.fromARGB(200, 2, 28, 114),
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    fillColor: Theme.of(context).dialogTheme.backgroundColor,
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

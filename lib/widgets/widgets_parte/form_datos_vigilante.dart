import 'package:acuda_keys/l10n/app_localizations.dart';
import 'package:acuda_keys/providers/realizar_parte_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class FormDatosVigilante extends ConsumerStatefulWidget {
  const FormDatosVigilante({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  ConsumerState<FormDatosVigilante> createState() {
    return _FormDatosVigilanteState();
  }
}

class _FormDatosVigilanteState extends ConsumerState<FormDatosVigilante> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    Map<String, TextEditingController> controladores = ref.watch(
      realizarParteControllerProvider,
    );
    return Form(
      key: widget.formKey,
      child: Padding(
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
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: Text(
                    l10n.datosVigilante,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.manrope(
                      color: Theme.of(context).dialogTheme.backgroundColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width > 400 ? 230 : 180,
                      child: TextFormField(
                        cursorColor: const Color.fromARGB(200, 2, 28, 114),
                        controller: controladores['nombreVigilanteController'],
                        style: GoogleFonts.manrope(
                          color: const Color.fromARGB(200, 2, 28, 114),
                          fontWeight: FontWeight.bold,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return l10n.validadorNombreVigilante;
                          }
                          return null;
                        },
                        autocorrect: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          helperText: l10n.nombreVigilante,
                          helperStyle: TextStyle(
                            color:
                                Theme.of(context).dialogTheme.backgroundColor,
                            fontSize: 15,
                          ),
                          fillColor:
                              Theme.of(context).dialogTheme.backgroundColor,
                          filled: true,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: TextFormField(
                        cursorColor: const Color.fromARGB(200, 2, 28, 114),
                        controller: controladores['tipController'],
                        style: GoogleFonts.manrope(
                          color: const Color.fromARGB(200, 2, 28, 114),
                          fontWeight: FontWeight.bold,
                        ),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        autocorrect: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return l10n.validadorTIP;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          helperText: 'TIP',
                          helperStyle: TextStyle(
                            color:
                                Theme.of(context).dialogTheme.backgroundColor,
                            fontSize: 15,
                          ),
                          fillColor:
                              Theme.of(context).dialogTheme.backgroundColor,
                          filled: true,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: TextFormField(
                    cursorColor: const Color.fromARGB(200, 2, 28, 114),
                    controller: controladores['delegacionController'],
                    style: GoogleFonts.manrope(
                      color: const Color.fromARGB(200, 2, 28, 114),
                      fontWeight: FontWeight.bold,
                    ),
                    autocorrect: false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return l10n.validadorDelegacion;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      helperText: l10n.delegacion,
                      helperStyle: TextStyle(
                        color: Theme.of(context).dialogTheme.backgroundColor,
                        fontSize: 15,
                      ),
                      fillColor: Theme.of(context).dialogTheme.backgroundColor,
                      filled: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

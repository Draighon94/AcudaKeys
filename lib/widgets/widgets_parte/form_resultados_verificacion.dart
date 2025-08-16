import 'package:acuda_keys/l10n/app_localizations.dart';
import 'package:acuda_keys/providers/realizar_parte_controller.dart';
import 'package:acuda_keys/providers/switches_parte_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class FormResultadosVerificacion extends ConsumerStatefulWidget {
  const FormResultadosVerificacion({super.key});

  @override
  ConsumerState<FormResultadosVerificacion> createState() {
    return _FormResultadosVerificacionState();
  }
}

class _FormResultadosVerificacionState
    extends ConsumerState<FormResultadosVerificacion> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    Map<String, TextEditingController> controladores = ref.watch(
      realizarParteControllerProvider,
    );
    Map<String, bool> switches = ref.watch(switchesParteControllerProvider);

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
                  l10n.resultadoVerificacion,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.manrope(
                    color: Theme.of(context).dialogTheme.backgroundColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          l10n.exterior,
                          style: GoogleFonts.manrope(
                            color:
                                Theme.of(context).dialogTheme.backgroundColor,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                MediaQuery.sizeOf(context).width <= 400
                                    ? 12
                                    : 14,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Switch(
                          value: switches['exterior']!,
                          onChanged: (valor) {
                            setState(() {
                              switches['exterior'] = valor;
                            });
                          },
                          activeTrackColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? const Color.fromARGB(200, 2, 28, 114)
                                  : const Color.fromARGB(185, 2, 255, 200),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          l10n.interior,
                          style: GoogleFonts.manrope(
                            color:
                                Theme.of(context).dialogTheme.backgroundColor,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                MediaQuery.sizeOf(context).width <= 400
                                    ? 12
                                    : 14,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Switch(
                          value: switches['interior']!,
                          onChanged: (valor) {
                            setState(() {
                              switches['interior'] = valor;
                            });
                          },
                          activeTrackColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? const Color.fromARGB(200, 2, 28, 114)
                                  : const Color.fromARGB(185, 2, 255, 200),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          l10n.guardiaCivil,
                          style: GoogleFonts.manrope(
                            color:
                                Theme.of(context).dialogTheme.backgroundColor,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                MediaQuery.sizeOf(context).width <= 400
                                    ? 12
                                    : 14,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Switch(
                          value: switches['guardiaCivil']!,
                          onChanged: (valor) {
                            setState(() {
                              switches['guardiaCivil'] = valor;
                            });
                          },
                          activeTrackColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? const Color.fromARGB(200, 2, 28, 114)
                                  : const Color.fromARGB(185, 2, 255, 200),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          l10n.policia,
                          style: GoogleFonts.manrope(
                            color:
                                Theme.of(context).dialogTheme.backgroundColor,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                MediaQuery.sizeOf(context).width <= 400
                                    ? 12
                                    : 14,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Switch(
                          value: switches['policia']!,
                          onChanged: (valor) {
                            setState(() {
                              switches['policia'] = valor;
                            });
                          },
                          activeTrackColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? const Color.fromARGB(200, 2, 28, 114)
                                  : const Color.fromARGB(185, 2, 255, 200),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: TextFormField(
                    cursorColor: const Color.fromARGB(200, 2, 28, 114),
                    keyboardType: TextInputType.number,
                    controller: controladores['numDotacionController'],
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
                      helperText: l10n.numDotacion,
                      helperStyle: TextStyle(
                        color: Theme.of(context).dialogTheme.backgroundColor,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.instalacionCerrada,
                      style: GoogleFonts.manrope(
                        color: Theme.of(context).dialogTheme.backgroundColor,
                        fontWeight: FontWeight.bold,
                        fontSize:
                            MediaQuery.sizeOf(context).width <= 400 ? 12 : 14,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Switch(
                      value: switches['instalacionCerrada']!,
                      onChanged: (valor) {
                        setState(() {
                          switches['instalacionCerrada'] = valor;
                        });
                      },
                      activeTrackColor:
                          Theme.of(context).brightness == Brightness.light
                              ? const Color.fromARGB(200, 2, 28, 114)
                              : const Color.fromARGB(185, 2, 255, 200),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.alarmaActivada,
                      style: GoogleFonts.manrope(
                        color: Theme.of(context).dialogTheme.backgroundColor,
                        fontWeight: FontWeight.bold,
                        fontSize:
                            MediaQuery.sizeOf(context).width <= 400 ? 12 : 14,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Switch(
                      value: switches['alarmaActivada']!,
                      onChanged: (valor) {
                        setState(() {
                          switches['alarmaActivada'] = valor;
                        });
                      },
                      activeTrackColor:
                          Theme.of(context).brightness == Brightness.light
                              ? const Color.fromARGB(200, 2, 28, 114)
                              : const Color.fromARGB(185, 2, 255, 200),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.senialesViolencia,
                      style: GoogleFonts.manrope(
                        color: Theme.of(context).dialogTheme.backgroundColor,
                        fontWeight: FontWeight.bold,
                        fontSize:
                            MediaQuery.sizeOf(context).width <= 400 ? 12 : 14,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Switch(
                      value: switches['senialesViolencia']!,
                      onChanged: (valor) {
                        setState(() {
                          switches['senialesViolencia'] = valor;
                        });
                      },
                      activeTrackColor:
                          Theme.of(context).brightness == Brightness.light
                              ? const Color.fromARGB(200, 2, 28, 114)
                              : const Color.fromARGB(185, 2, 255, 200),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.perosnasInterior,
                      style: GoogleFonts.manrope(
                        color: Theme.of(context).dialogTheme.backgroundColor,
                        fontWeight: FontWeight.bold,
                        fontSize:
                            MediaQuery.sizeOf(context).width <= 400 ? 12 : 14,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Switch(
                      value: switches['personasInterior']!,
                      onChanged: (valor) {
                        setState(() {
                          switches['personasInterior'] = valor;
                        });
                      },
                      activeTrackColor:
                          Theme.of(context).brightness == Brightness.light
                              ? const Color.fromARGB(200, 2, 28, 114)
                              : const Color.fromARGB(185, 2, 255, 200),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.quedaSistemaConectado,
                      style: GoogleFonts.manrope(
                        color: Theme.of(context).dialogTheme.backgroundColor,
                        fontWeight: FontWeight.bold,
                        fontSize:
                            MediaQuery.sizeOf(context).width <= 400 ? 12 : 14,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Switch(
                      value: switches['sistemaConectado']!,
                      onChanged: (valor) {
                        setState(() {
                          switches['sistemaConectado'] = valor;
                        });
                      },
                      activeTrackColor:
                          Theme.of(context).brightness == Brightness.light
                              ? const Color.fromARGB(200, 2, 28, 114)
                              : const Color.fromARGB(185, 2, 255, 200),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:acuda_keys/l10n/app_localizations.dart';
import 'package:acuda_keys/providers/idioma_actual_controller.dart';
import 'package:acuda_keys/providers/realizar_parte_controller.dart';
import 'package:acuda_keys/providers/switches_parte_controller.dart';
import 'package:acuda_keys/widgets/widgets_parte/desplegable_clientes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class FormSolicitudServicio extends ConsumerStatefulWidget {
  const FormSolicitudServicio({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  ConsumerState<FormSolicitudServicio> createState() {
    return _FormSolicitudServicio();
  }
}

class _FormSolicitudServicio extends ConsumerState<FormSolicitudServicio> {
  //metodo que lanza el selector de fecha
  Future<void> _seleccionarFecha(TextEditingController controlador) async {
    await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
      initialDate: DateTime.now(),
      locale: ref.watch(idiomaActualControllerProvider),
    ).then((fechaElegida) {
      controlador.text =
          '${fechaElegida!.day}/${fechaElegida.month}/${fechaElegida.year}';
    });
  }

  //metodo que lanza el selector de hora
  Future<void> _seleccionarHora(TextEditingController controlador) async {
    await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 0, minute: 0),
    ).then((horaSeleccionada) {
      final hora = horaSeleccionada!.hour;
      final minutos =
          horaSeleccionada.minute < 10
              ? '0${horaSeleccionada.minute}'
              : horaSeleccionada.minute;
      controlador.text = '$hora:$minutos';
    });
  }

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
          child: Form(
            key: widget.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    l10n.datosServicio,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.manrope(
                      color: Theme.of(context).dialogTheme.backgroundColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: DesplegableClientes(),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: TextFormField(
                    controller: controladores['direccionClienteController'],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return l10n.validadorCliente;
                      }
                      return null;
                    },
                    readOnly: true,
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
                      helperText: l10n.direccionCliente,
                      helperStyle: TextStyle(
                        color: Theme.of(context).dialogTheme.backgroundColor,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FloatingActionButton.extended(
                      onPressed: () {
                        _seleccionarFecha(controladores['fechaController']!);
                      },
                      foregroundColor:
                          Theme.of(context).dialogTheme.backgroundColor,
                      backgroundColor: const Color.fromARGB(186, 2, 28, 114),
                      icon: const Icon(Icons.edit_calendar_rounded),
                      label: Text(l10n.elegirFecha),
                    ),
                    SizedBox(
                      width: 150,
                      child: TextFormField(
                        controller: controladores['fechaController'],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return l10n.validadorFecha;
                          }
                          return null;
                        },
                        style: GoogleFonts.manrope(
                          color: const Color.fromARGB(200, 2, 28, 114),
                          fontWeight: FontWeight.bold,
                        ),
                        readOnly: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          helperText: l10n.fecha,
                          helperStyle: TextStyle(
                            color:
                                Theme.of(context).dialogTheme.backgroundColor,
                            fontSize:
                                MediaQuery.sizeOf(context).width > 400
                                    ? 15
                                    : 12,
                          ),
                          fillColor:
                              Theme.of(context).dialogTheme.backgroundColor,
                          filled: true,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: TextFormField(
                    readOnly: true,
                    controller: controladores['nombreCRAController'],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return l10n.validadorCliente;
                      }
                      return null;
                    },
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
                      helperText: l10n.cra,
                      helperStyle: TextStyle(
                        color: Theme.of(context).dialogTheme.backgroundColor,
                        fontSize:
                            MediaQuery.sizeOf(context).width > 400 ? 15 : 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        FloatingActionButton.small(
                          onPressed: () {
                            _seleccionarHora(
                              controladores['horaAvisoController']!,
                            );
                          },
                          backgroundColor: const Color.fromARGB(
                            186,
                            2,
                            28,
                            114,
                          ),
                          child: Icon(
                            Icons.more_time_rounded,
                            color:
                                Theme.of(context).dialogTheme.backgroundColor,
                          ),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width:
                              MediaQuery.sizeOf(context).width > 400 ? 100 : 90,
                          child: TextFormField(
                            readOnly: true,
                            controller: controladores['horaAvisoController'],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return l10n.validadorHora;
                              }
                              return null;
                            },
                            style: GoogleFonts.manrope(
                              color: const Color.fromARGB(200, 2, 28, 114),
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              fillColor:
                                  Theme.of(context).dialogTheme.backgroundColor,
                              filled: true,
                              helperText: l10n.horaAviso,
                              helperStyle: TextStyle(
                                color:
                                    Theme.of(
                                      context,
                                    ).dialogTheme.backgroundColor,
                                fontSize:
                                    MediaQuery.sizeOf(context).width > 400
                                        ? 14
                                        : 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        FloatingActionButton.small(
                          onPressed: () {
                            _seleccionarHora(
                              controladores['horaLlegadaController']!,
                            );
                          },
                          backgroundColor: const Color.fromARGB(
                            186,
                            2,
                            28,
                            114,
                          ),
                          child: Icon(
                            Icons.more_time_rounded,
                            color:
                                Theme.of(context).dialogTheme.backgroundColor,
                          ),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width:
                              MediaQuery.sizeOf(context).width > 400 ? 100 : 90,
                          child: TextFormField(
                            readOnly: true,
                            controller: controladores['horaLlegadaController'],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return l10n.validadorHora;
                              }
                              return null;
                            },
                            style: GoogleFonts.manrope(
                              color: const Color.fromARGB(200, 2, 28, 114),
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              fillColor:
                                  Theme.of(context).dialogTheme.backgroundColor,
                              filled: true,
                              helperText: l10n.horaLlegada,
                              helperStyle: TextStyle(
                                color:
                                    Theme.of(
                                      context,
                                    ).dialogTheme.backgroundColor,
                                fontSize:
                                    MediaQuery.sizeOf(context).width > 400
                                        ? 14
                                        : 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        FloatingActionButton.small(
                          onPressed: () {
                            _seleccionarHora(
                              controladores['horaFinalController']!,
                            );
                          },
                          backgroundColor: const Color.fromARGB(
                            186,
                            2,
                            28,
                            114,
                          ),
                          child: Icon(
                            Icons.more_time_rounded,
                            color:
                                Theme.of(context).dialogTheme.backgroundColor,
                          ),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width:
                              MediaQuery.sizeOf(context).width > 400 ? 100 : 90,
                          child: TextFormField(
                            readOnly: true,
                            controller: controladores['horaFinalController'],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return l10n.validadorHora;
                              }
                              return null;
                            },
                            style: GoogleFonts.manrope(
                              color: const Color.fromARGB(200, 2, 28, 114),
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              fillColor:
                                  Theme.of(context).dialogTheme.backgroundColor,
                              filled: true,
                              helperText: l10n.horaFinal,
                              helperStyle: TextStyle(
                                color:
                                    Theme.of(
                                      context,
                                    ).dialogTheme.backgroundColor,
                                fontSize:
                                    MediaQuery.sizeOf(context).width > 400
                                        ? 14
                                        : 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    left: 10,
                    right: 10,
                    bottom: 10,
                  ),
                  child: SizedBox(
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.perdidaComunicacion,
                          style: GoogleFonts.manrope(
                            color:
                                Theme.of(context).dialogTheme.backgroundColor,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                MediaQuery.sizeOf(context).width < 400
                                    ? 12
                                    : 14,
                          ),
                        ),
                        SizedBox(
                          width:
                              MediaQuery.sizeOf(context).width > 360 ? 50 : 43,
                        ),
                        Switch(
                          value: switches['perdidaComunicacion']!,
                          onChanged: (valor) {
                            setState(() {
                              switches['perdidaComunicacion'] = valor;
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
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 10,
                  ),
                  child: SizedBox(
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.intrusion,
                          style: GoogleFonts.manrope(
                            color:
                                Theme.of(context).dialogTheme.backgroundColor,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                MediaQuery.sizeOf(context).width < 400
                                    ? 12
                                    : 14,
                          ),
                        ),
                        SizedBox(
                          width:
                              MediaQuery.sizeOf(context).width > 400
                                  ? 157
                                  : 133,
                        ),
                        Switch(
                          value: switches['intrusion']!,
                          onChanged: (valor) {
                            setState(() {
                              switches['intrusion'] = valor;
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
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 10,
                  ),
                  child: SizedBox(
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.incendio,
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
                        SizedBox(
                          width:
                              MediaQuery.sizeOf(context).width > 400
                                  ? 160
                                  : 137,
                        ),
                        Switch(
                          value: switches['incendio']!,
                          onChanged: (valor) {
                            setState(() {
                              switches['incendio'] = valor;
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
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: SizedBox(
                    width: 300,
                    child: TextFormField(
                      cursorColor: const Color.fromARGB(200, 2, 28, 114),
                      controller: controladores['otrasIncidenciasController'],
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
                        fillColor:
                            Theme.of(context).dialogTheme.backgroundColor,
                        filled: true,
                        helperText: l10n.otrasIncidencias,
                        helperStyle: TextStyle(
                          color: Theme.of(context).dialogTheme.backgroundColor,
                          fontSize: 15,
                        ),
                      ),
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

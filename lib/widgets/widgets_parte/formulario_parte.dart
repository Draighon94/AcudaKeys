import 'dart:io';

import 'package:acuda_keys/l10n/app_localizations.dart';
import 'package:acuda_keys/models/parte.dart';
import 'package:acuda_keys/providers/parte_pdf_controller.dart';
import 'package:acuda_keys/providers/realizar_parte_controller.dart';
import 'package:acuda_keys/providers/switches_parte_controller.dart';
import 'package:acuda_keys/widgets/widgets_parte/form_datos_vigilante.dart';
import 'package:acuda_keys/widgets/widgets_parte/form_observaciones.dart';
import 'package:acuda_keys/widgets/widgets_parte/form_resultados_verificacion.dart';
import 'package:acuda_keys/widgets/widgets_parte/form_solicitud_servicio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class FormularioParte extends ConsumerStatefulWidget {
  const FormularioParte({super.key});

  @override
  ConsumerState<FormularioParte> createState() => _FormularioParteState();
}

class _FormularioParteState extends ConsumerState<FormularioParte> {
  bool isGuardando = false;
  final GlobalKey<FormState> formDatosVigilanteKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formSolicitudServicioKey = GlobalKey<FormState>();

  //metodo para generar el pdf del parte de servicio
  void generarPdf(AppLocalizations l10n) async {
    final Map<String, TextEditingController> controladores = ref.watch(
      realizarParteControllerProvider,
    );
    final Map<String, bool> switches = ref.watch(
      switchesParteControllerProvider,
    );
    final parte = Parte(
      nombreVigilante: controladores['nombreVigilanteController']!.text,
      fecha: controladores['fechaController']!.text,
      cra: controladores['nombreCRAController']!.text,
      tip: int.parse(controladores['tipController']!.text),
      horaAviso: controladores['horaAvisoController']!.text,
      horaLlegada: controladores['horaLlegadaController']!.text,
      horaFinalizacion: controladores['horaFinalController']!.text,
      delegacion: controladores['delegacionController']!.text,
      cliente: controladores['nombreClienteController']!.text,
      direccionCliente: controladores['direccionClienteController']!.text,
      observaciones: controladores['observacionesController']!.text,
      otrasIncidencias: controladores['otrasIncidenciasController']!.text,
      numDotacion: controladores['numDotacionController']!.text,
      perdidaComunicacion: switches['perdidaComunicacion']!,
      intrusion: switches['intrusion']!,
      incendio: switches['incendio']!,
      verificacionExterior: switches['exterior']!,
      verificacionInterior: switches['interior']!,
      guardiaCivil: switches['guardiaCivil']!,
      policia: switches['policia']!,
      instalacionCerrada: switches['instalacionCerrada']!,
      alarmaActivada: switches['alarmaActivada']!,
      senialesViolencia: switches['senialesViolencia']!,
      personasInterior: switches['personasInterior']!,
      quedaSistemaConectado: switches['sistemaConectado']!,
    );

    setState(() {
      isGuardando = true;
    });

    bool resultado = await ref
        .read(partePDFControllerProvider.notifier)
        .registrarParte(parte);
    if (resultado) {
      await ref
          .read(partePDFControllerProvider.notifier)
          .generarParte(parte)
          .then((ruta) {
            ScaffoldMessenger.of(context).clearSnackBars();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: const Color.fromARGB(150, 60, 60, 60),
                content:
                    Platform.isAndroid
                        ? Text(
                          '${l10n.guardadoEn} la carpeta de descargas',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Theme.of(
                                      context,
                                    ).dialogTheme.backgroundColor
                                    : const Color.fromARGB(185, 2, 255, 200),
                          ),
                        )
                        : Text(
                          '${l10n.guardadoEn} $ruta',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Theme.of(
                                      context,
                                    ).dialogTheme.backgroundColor
                                    : const Color.fromARGB(185, 2, 255, 200),
                          ),
                        ),
              ),
            );

            //si todo ha ido bien, limpiamos los campos
            ref.read(realizarParteControllerProvider.notifier).limpiarCampos();
            ref
                .read(switchesParteControllerProvider.notifier)
                .reinicarSwitches();
          });
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color.fromARGB(150, 60, 60, 60),
          content: Text(
            l10n.errorPdfGuardar,
            style: TextStyle(
              color:
                  Theme.of(context).brightness == Brightness.light
                      ? Theme.of(context).dialogTheme.backgroundColor
                      : const Color.fromARGB(185, 2, 255, 200),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    setState(() {
      isGuardando = false;
    });
  }

  //metodo que valida los campos
  void validarCampos(AppLocalizations l10n) {
    int form = 0;

    //se validan los formularios de manera independiente
    if (formDatosVigilanteKey.currentState!.validate()) {
      form++;
    }

    if (formSolicitudServicioKey.currentState!.validate()) {
      form++;
    }

    //si los dos formularios se han validado, se genera el pdf
    if (form == 2) {
      generarPdf(l10n);
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color.fromARGB(150, 60, 60, 60),
          content: Text(
            'Datos no válidos',
            style: TextStyle(
              color:
                  Theme.of(context).brightness == Brightness.light
                      ? Theme.of(context).dialogTheme.backgroundColor
                      : const Color.fromARGB(185, 2, 255, 200),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      child: Column(
        children: [
          FormDatosVigilante(formKey: formDatosVigilanteKey),
          FormSolicitudServicio(formKey: formSolicitudServicioKey),
          const FormResultadosVerificacion(),
          const FormObservaciones(),
          if (!isGuardando)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: FloatingActionButton.extended(
                onPressed: () {
                  validarCampos(l10n);
                },
                backgroundColor: const Color.fromARGB(186, 2, 28, 114),
                label: Text(
                  l10n.guardarPartePDF,
                  style: GoogleFonts.manrope(
                    color: Theme.of(context).dialogTheme.backgroundColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                icon: Icon(
                  Icons.save_rounded,
                  color: Theme.of(context).dialogTheme.backgroundColor,
                ),
              ),
            ),
          if (isGuardando)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: CircularProgressIndicator(
                color: Color.fromARGB(186, 2, 28, 114),
              ),
            ),
        ],
      ),
    );
  }
}

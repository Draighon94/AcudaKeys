import 'package:acuda_keys/l10n/app_localizations.dart';
import 'package:acuda_keys/models/parte.dart';
import 'package:acuda_keys/providers/idioma_actual_controller.dart';
import 'package:acuda_keys/providers/informe_controller.dart';
import 'package:acuda_keys/widgets/dato_informe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class GenerarInformeView extends ConsumerStatefulWidget {
  const GenerarInformeView({
    super.key,
    required this.mesIndex,
    required this.anioIndex,
  });

  final int mesIndex;
  final String anioIndex;

  @override
  ConsumerState<GenerarInformeView> createState() {
    return _GenerarInformeViewState();
  }
}

class _GenerarInformeViewState extends ConsumerState<GenerarInformeView> {
  String clienteConMasServicios = '';
  String vigilanteConMasServicios = '';
  int serviciosPerdidaComunicacion = 0;
  int serviciosIntrusion = 0;
  int serviciosIncendio = 0;
  bool isGuardando = false;

  List<Parte> listaPartes = [];
  String mesActual = '';

  //metodo para obtener los partes
  void obtenerPartes(WidgetRef ref) async {
    setState(() {});
    //tenemos que esperar a que se descarguen todos los partes de la base de datos
    listaPartes = await ref.watch(informeControllerProvider);
    //filtramos los partes por año
    ref
        .read(informeControllerProvider.notifier)
        .filtrarPartesPorAnio(widget.anioIndex);
    //sacamos el mes actual en formato literario
    mesActual = DateFormat(
      'MMMM',
      ref.watch(idiomaActualControllerProvider).languageCode,
    ).format(DateTime(2000, widget.mesIndex + 1, 1));
    //sacamos la estadistica del cliente con mas servicios
    clienteConMasServicios =
        ref.read(informeControllerProvider.notifier).clienteConMasServicios();
    //sacamos la estadistica del vigilante con mas servicios
    vigilanteConMasServicios =
        ref.read(informeControllerProvider.notifier).vigilanteConMasServicios();
    //sacamos la estadistica de servicios por perdida de comunicacion
    serviciosPerdidaComunicacion =
        ref
            .read(informeControllerProvider.notifier)
            .serviciosPerdidaComunicacion();
    //sacamos la estadistica de servicios por intrusion
    serviciosIntrusion =
        ref.read(informeControllerProvider.notifier).serviciosIntrusion();
    //sacamos la estadistica de servicios por incendio
    serviciosIncendio =
        ref.read(informeControllerProvider.notifier).serviciosIncendio();
  }

  //metodo para guardar el informe en un pdf
  void guardarInformePDF(AppLocalizations l10n) async {
    setState(() {
      isGuardando = true;
    });
    //creamos un pdf con las estadisticas del mes
    await ref
        .read(informeControllerProvider.notifier)
        .guardarInformePDF(widget.anioIndex)
        .then((resultado) {
          //una vez terminado el proceso, mostramos una snackbar informando del resultado
          ScaffoldMessenger.of(context).clearSnackBars();
          if (resultado != '') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: const Color.fromARGB(150, 60, 60, 60),
                content: Text(
                  '${l10n.pdfGuardado} $resultado',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color:
                        Theme.of(context).brightness == Brightness.light
                            ? Theme.of(context).dialogTheme.backgroundColor
                            : const Color.fromARGB(185, 2, 255, 200),
                  ),
                ),
              ),
            );
          } else {
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
        });
    setState(() {
      isGuardando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    obtenerPartes(ref);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '${l10n.informeDe} $mesActual ${widget.anioIndex}',
          style: GoogleFonts.manrope(
            color: Theme.of(context).dialogTheme.backgroundColor,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            shadows: [
              const Shadow(
                offset: Offset(1, 1),
                color: Colors.black,
                blurRadius: 20,
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        leading: BackButton(
          color: Theme.of(context).dialogTheme.backgroundColor,
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).secondaryHeaderColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 70),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DatoInforme(
                    dato: '${l10n.numeroPartesRealizados}:',
                    valor: '${listaPartes.length}',
                  ),

                  DatoInforme(
                    dato: '${l10n.clienteMasServicios}:',
                    valor: clienteConMasServicios,
                  ),

                  DatoInforme(
                    dato: '${l10n.vigilanteMasServicios}:',
                    valor: vigilanteConMasServicios,
                  ),

                  DatoInforme(
                    dato: '${l10n.serviciosPerdidaComunicacion}:',
                    valor: '$serviciosPerdidaComunicacion',
                  ),

                  DatoInforme(
                    dato: '${l10n.serviciosIntrusion}:',
                    valor: '$serviciosIntrusion',
                  ),

                  DatoInforme(
                    dato: '${l10n.serviciosIncendio}:',
                    valor: '$serviciosIncendio',
                  ),

                  Padding(
                    padding: const EdgeInsets.all(10),
                    child:
                        !isGuardando
                            ? FloatingActionButton.extended(
                              onPressed: () {
                                guardarInformePDF(l10n);
                              },
                              backgroundColor: const Color.fromARGB(
                                186,
                                2,
                                28,
                                114,
                              ),
                              label: Text(
                                l10n.guardarInformePDF,
                                style: GoogleFonts.manrope(
                                  color:
                                      Theme.of(
                                        context,
                                      ).dialogTheme.backgroundColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              icon: Icon(
                                Icons.save_rounded,
                                color:
                                    Theme.of(
                                      context,
                                    ).dialogTheme.backgroundColor,
                              ),
                            )
                            : const CircularProgressIndicator(
                              color: Color.fromARGB(186, 2, 28, 114),
                            ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:acuda_keys/models/parte.dart';
import 'package:acuda_keys/providers/mes_controller.dart';
import 'package:acuda_keys/widgets/widgets_informe_pdf/estadisticas_informe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pdf/widgets.dart' as pw;

part 'informe_controller.g.dart';

final _firebase = FirebaseFirestore.instance;

//provider que contiene los metodos para realizar el informe mensual
@riverpod
class InformeController extends _$InformeController {
  @override
  List<Parte> build() {
    List<Parte> listaPartes = [];
    _obtenerPartes();
    return listaPartes;
  }

  //metodo para obtener los datos de los partes de la base de datos
  Future<void> _obtenerPartes() async {
    List<Parte> listaPartes = [];
    int? mesActual = ref
        .read(mesControllerProvider.notifier)
        .obtenerMesNumero(ref.watch(mesControllerProvider));
    String fechaActual = '${DateTime.now().year}_$mesActual';
    //recorremos los partes que hay en la base de datos
    await _firebase.collection('Partes').get().then((query) {
      for (var parte in query.docs) {
        //solo cogemos los que pertenezcan al mes actual
        if (parte.id.startsWith(fechaActual)) {
          //añadimos al parte a la lista temporal
          listaPartes.add(
            Parte(
              cliente: parte['cliente'],
              cra: parte['cra'],
              delegacion: parte['delegacion'],
              fecha: parte['fecha'],
              guardiaCivil: parte['guardiaCivil'] as bool,
              horaAviso: parte['horaAviso'],
              horaFinalizacion: parte['horaFinalizacion'],
              horaLlegada: parte['horaLlegada'],
              incendio: parte['incendio'] as bool,
              intrusion: parte['intrusion'] as bool,
              nombreVigilante: parte['nombreVigilante'],
              otrasIncidencias: parte['otrasIncidencias'],
              perdidaComunicacion: parte['perdidaComunicacion'] as bool,
              policia: parte['policia'] as bool,
              senialesViolencia: parte['senialesViolencia'] as bool,
              tip: parte['tip'] as int,
              direccionCliente: '',
              verificacionExterior: false,
              verificacionInterior: false,
              alarmaActivada: false,
              instalacionCerrada: false,
              personasInterior: false,
              quedaSistemaConectado: false,
            ),
          );
        }
      }
    });
    //actualizamos el estado del provider con los partes
    state = listaPartes;
  }

  //metodo para obtener el cliente con más servicios
  String clienteConMasServicios() {
    List<Parte> listaPartes = state;
    String clienteConMasServicios = '';
    Map<String, int> contadores = {};
    int contadorMasAlto = -1;

    //contamos cuantos servicios se ha realizado a cada cliente
    for (var parte in listaPartes) {
      if (!contadores.containsKey(parte.cliente)) {
        contadores[parte.cliente] = 1;
      } else {
        contadores[parte.cliente] = 1 + (contadores[parte.cliente] as int);
      }
    }

    //buscamos el cliente con mas servicios
    for (var cliente in contadores.entries) {
      if (cliente.value > contadorMasAlto) {
        contadorMasAlto = cliente.value;
        clienteConMasServicios = '${cliente.key} ($contadorMasAlto)';
      }
    }

    return clienteConMasServicios;
  }

  //metodo para saber quien el vigilante con más servicios
  String vigilanteConMasServicios() {
    List<Parte> listaPartes = state;
    String vigilanteConMasServicios = '';
    Map<String, int> contadores = {};
    int contadorMasAlto = -1;

    //contamos cuantos servicios se ha realizado a cada cliente
    for (var parte in listaPartes) {
      if (!contadores.containsKey(parte.nombreVigilante)) {
        contadores[parte.nombreVigilante] = 1;
      } else {
        contadores[parte.nombreVigilante] =
            1 + (contadores[parte.nombreVigilante] as int);
      }
    }

    //buscamos el cliente con mas servicios
    for (var vigilante in contadores.entries) {
      if (vigilante.value > contadorMasAlto) {
        contadorMasAlto = vigilante.value;
        vigilanteConMasServicios = '${vigilante.key} ($contadorMasAlto)';
      }
    }

    return vigilanteConMasServicios;
  }

  //metodo para saber cuantos servicios son por perdida de comunicacion
  int serviciosPerdidaComunicacion() {
    List<Parte> listaPartes = state;
    int contador = 0;

    //recorremos los partes para saber cuantos han sido por perdida de comunicacion
    for (var parte in listaPartes) {
      if (parte.perdidaComunicacion) contador++;
    }

    return contador;
  }

  //metodo para saber cuantos servicios son por intrusion
  int serviciosIntrusion() {
    List<Parte> listaPartes = state;
    int contador = 0;

    //recorremos los partes para saber cuantos han sido por perdida de comunicacion
    for (var parte in listaPartes) {
      if (parte.intrusion) contador++;
    }

    return contador;
  }

  //metodo para saber cuantos servicios son por incendio
  int serviciosIncendio() {
    List<Parte> listaPartes = state;
    int contador = 0;

    //recorremos los partes para saber cuantos han sido por perdida de comunicacion
    for (var parte in listaPartes) {
      if (parte.incendio) contador++;
    }

    return contador;
  }

  //metodo de filtrado por año
  void filtrarPartesPorAnio(String anio) {
    List<Parte> partes = state;
    List<Parte> filtrado = [];

    for (var parte in partes) {
      if (parte.fecha.endsWith(anio)) {
        filtrado.add(parte);
      }
    }
    state = filtrado;
  }

  //metodo para guardar el informe mensual en pdf
  Future<String> guardarInformePDF(String anio) async {
    //creamos una instancia del documento
    pw.Document pdf = pw.Document();
    //cargamos la imagen del logo
    final image = await rootBundle.load('assets/images/logo.png');
    final imageBytes = image.buffer.asUint8List();
    //creamos la instancia del logo
    pw.Image logo = pw.Image(pw.MemoryImage(imageBytes));
    String? ruta = '';
    File file;

    //pintamos el documento pdf
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Container(
            child: pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColor.fromHex('#021C72B9')),
              ),
              child: pw.Column(
                mainAxisSize: pw.MainAxisSize.min,
                children: [
                  //CABECERA DEL INFORME
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(
                          left: 100,
                          top: 10,
                          bottom: 10,
                        ),
                        child: pw.Container(
                          child: pw.Container(height: 50, child: logo),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(right: 100),
                        child: pw.Text(
                          'Acuda Keys',
                          style: pw.TextStyle(
                            color: PdfColor.fromHex('#021C72B9'),
                            fontSize: 30,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  //SUBTITULO
                  pw.Container(
                    width: double.infinity,
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(
                        color: PdfColor.fromHex('#021C72B9'),
                      ),
                      gradient: pw.LinearGradient(
                        colors: [
                          PdfColor.fromHex('#69f0ae33'),
                          PdfColor.fromHex('#448aff33'),
                        ],
                      ),
                    ),
                    child: pw.Text(
                      'INFORME MENSUAL',
                      style: pw.TextStyle(
                        color: PdfColor.fromHex('#021C72B9'),
                        fontSize: 20,
                      ),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                  //ESTADISTICAS
                  EstadisticasInforme(
                    partesTotales: state.length,
                    clienteMasServicios: clienteConMasServicios(),
                    vigilanteMasServicios: vigilanteConMasServicios(),
                    serviciosPerdidaComunicacion:
                        serviciosPerdidaComunicacion(),
                    serviciosIntrusion: serviciosIntrusion(),
                    serviciosIncendio: serviciosIncendio(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );

    //si la aplicacion está corriendo en Android
    if (Platform.isAndroid) {
      //nombre de la ruta de salida del .pdf
      ruta = '/storage/self/primary/Download';
    } else {
      ruta = await getDirectoryPath();
      if (ruta == null) {
        //si el resultado es null es porque el usuario ha cancelado la operacion
        return '';
      }
    }
    file = File('$ruta/informe_${ref.watch(mesControllerProvider)}_$anio.pdf');
    //si el fichero existe, lo sobreescribimos
    if (file.existsSync()) {
      await file.writeAsBytes(await pdf.save()).then((file) {}).onError((e, _) {
        ruta = '';
      });
    } //si no existe, lo guardamos
    else {
      await file.writeAsBytes(await pdf.save()).then((file) {}).onError((e, _) {
        ruta = '';
      });
    }
    return ruta!;
  }
}

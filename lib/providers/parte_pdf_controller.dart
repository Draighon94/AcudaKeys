import 'dart:io';
import 'package:acuda_keys/models/parte.dart';
import 'package:acuda_keys/widgets/widgets_parte_pdf/datos_cliente.dart';
import 'package:acuda_keys/widgets/widgets_parte_pdf/datos_solicitud_servicio.dart';
import 'package:acuda_keys/widgets/widgets_parte_pdf/datos_vigilante.dart';
import 'package:acuda_keys/widgets/widgets_parte_pdf/resultados_verificacion.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_selector/file_selector.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;

part 'parte_pdf_controller.g.dart';

//obtenemos la referencia del almacenamiento de Firebase
final _storageRef = FirebaseStorage.instance.ref();
//obtenemos la referencia de la base de datos
final _firebase = FirebaseFirestore.instance;

//provider que almacena la logica para realizar un pdf de un parte de servicio
@riverpod
class PartePDFController extends _$PartePDFController {
  @override
  pw.Document build() => pw.Document();

  //metodo para cargar el parte desde el explorador de ficheros
  Future<String?> cargarParte() async {
    File parte;
    String? resultado;

    await FilePicker.platform
        .pickFiles()
        .then((file) {
          parte = File(file!.files.single.path!);
          resultado = parte.path;
        })
        .onError((e, _) {
          resultado = '';
        });

    return resultado;
  }

  //metodo para subir el parte a la base de datos
  Future<int> subirParte(String rutaFichero) async {
    //creamos una instancia del archivo
    File file = File(rutaFichero);
    //creamos una referencia al fichero en la base de datos
    final parteRef = _storageRef.child('partes/${path.basename(rutaFichero)}');

    try {
      await parteRef.putFile(file);
    } on Error {
      return -1;
    }
    return 0;
  }

  //metodo para registrar los datos del parte en la base de datos para el informe mensual
  Future<bool> registrarParte(Parte parte) async {
    bool resultado = false;
    //creamos una referencia del parte en la base de datos
    final DocumentReference parteRef = _firebase
        .collection('Partes')
        .doc(
          '${_guardarFecha(parte.fecha)}_${parte.cliente.replaceAll(' ', '_')}',
        );

    try {
      //guardamos los datos del parte en la base de datos
      await parteRef
          .set({
            'nombreVigilante': parte.nombreVigilante,
            'fecha': parte.fecha,
            'cra': parte.cra,
            'tip': parte.tip,
            'horaAviso': parte.horaAviso,
            'horaLlegada': parte.horaLlegada,
            'horaFinalizacion': parte.horaFinalizacion,
            'delegacion': parte.delegacion,
            'cliente': parte.cliente,
            'direccionCliente': parte.direccionCliente,
            'observaciones': parte.observaciones,
            'otrasIncidencias': parte.otrasIncidencias,
            'numDotacion': parte.numDotacion,
            'perdidaComunicacion': parte.perdidaComunicacion,
            'intrusion': parte.intrusion,
            'incendio': parte.incendio,
            'verificacionExterior': parte.verificacionExterior,
            'verificacionInterior': parte.verificacionInterior,
            'guardiaCivil': parte.guardiaCivil,
            'policia': parte.policia,
            'instalacionCerrada': parte.instalacionCerrada,
            'alarmaActivada': parte.instalacionCerrada,
            'senialesViolencia': parte.senialesViolencia,
            'personasInterior': parte.personasInterior,
            'quedaSistemaConectado': parte.quedaSistemaConectado,
          })
          .whenComplete(() {
            resultado = true;
          })
          .timeout(
            const Duration(seconds: 5),
            onTimeout: () {
              resultado = false;
            },
          );
    } on Error {
      //si falla devolvemos false
      resultado = false;
    }
    return resultado;
  }

  //metodo para generar el parte en formato pdf
  Future<String> generarParte(Parte parte) async {
    String ruta = '';
    final pdf = state;
    //cargamos la imagen del logo en memoria
    final image = await rootBundle.load('assets/images/logo.png');
    final imageBytes = image.buffer.asUint8List();
    //creamos una instancia del logo
    pw.Image logo = pw.Image(pw.MemoryImage(imageBytes));

    //empezamos a pintar el pdf
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Container(
            alignment: pw.Alignment.topCenter,
            child: pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColor.fromHex('#021C72B9')),
              ),
              child: pw.Column(
                mainAxisSize: pw.MainAxisSize.min,
                children: [
                  //CABECERA DEL PARTE
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
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
                        padding: const pw.EdgeInsets.only(right: 10),
                        child: pw.Text(
                          'Acuda Keys',
                          style: pw.TextStyle(
                            color: PdfColor.fromHex('#021C72B9'),
                            fontSize: 30,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),

                      pw.Container(
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(
                            color: PdfColor.fromHex('#021C72B9'),
                          ),
                        ),
                        child: pw.Padding(
                          padding: const pw.EdgeInsets.symmetric(
                            vertical: 30,
                            horizontal: 10,
                          ),
                          child: pw.Row(
                            children: [
                              pw.Text(
                                'FECHA: ',
                                style: const pw.TextStyle(fontSize: 12),
                              ),
                              pw.Text(
                                parte.fecha,
                                style: const pw.TextStyle(
                                  fontSize: 12,
                                  color: PdfColors.blue900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
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
                      'INFORME DE SERVICIO DE ACUDA',
                      style: pw.TextStyle(
                        color: PdfColor.fromHex('#021C72B9'),
                        fontSize: 20,
                      ),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                  //DATOS DEL CLIENTE
                  DatosCliente(
                    nombreCliente: parte.cliente,
                    direccionCliente: parte.direccionCliente,
                  ),
                  //DATOS DEL VIGILANTE
                  DatosVigilante(
                    nombreVigilante: parte.nombreVigilante,
                    tip: parte.tip,
                    delegacion: parte.delegacion,
                  ),
                  //DATOS DE LA SOLICITUD DEL SERVICIO
                  DatosSolicitudServicio(parte: parte),
                  //DATOS RESULTADO VERIFICACION
                  ResultadosVerificacion(parte: parte),
                  //OBSERVACIONES DEL SERVICIO
                  pw.Container(
                    width: double.infinity,
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(
                        color: PdfColor.fromHex('#021C72B9'),
                      ),
                    ),
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.all(10),
                      child: pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('Observaciones: '),
                          pw.SizedBox(
                            width: 375,
                            child: pw.Text(
                              parte.observaciones!,
                              style: const pw.TextStyle(
                                color: PdfColors.blue900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
    //si la aplicacion está corriendo en Windows
    if (Platform.isWindows) {
      await getDirectoryPath()
          .then((rutaFinal) {
            ruta = rutaFinal!;
          })
          .onError((e, _) {
            ruta = '';
          });
    } else {
      //nombre de la ruta de salida del .pdf
      ruta = '/storage/self/primary/Download';
    }

    if (ruta != '') {
      //fecha del parte
      final fecha = _guardarFecha(parte.fecha);

      //creamos el fichero pdf con el formato AAAA_MM_DD_Nombre_del_cliente.pdf
      final file = File(
        '$ruta/${fecha}_${parte.cliente.replaceAll(' ', '_')}.pdf',
      );
      //guardamos el fichero
      await file.writeAsBytes(await pdf.save()).onError((e, _) {
        ruta = '';
        return File('');
      });
    }

    return ruta;
  }

  //metodo para enviar el parte por correo electrónico
  Future<int> enviarParte({
    required String nombreCliente,
    required String rutaParte,
    required String destino,
  }) async {
    int codigoSalida = 0;
    String saludo;
    //dependiendo de la hora del sistema, establecemos el saludo
    if (DateTime.now().hour > 5 && DateTime.now().hour < 13) {
      saludo = 'Buenos días';
    } else if (DateTime.now().hour >= 13 && DateTime.now().hour <= 20) {
      saludo = 'Buenas tardes';
    } else {
      saludo = 'Buenas noches';
    }

    //pregeneramos el contenido del email
    final Email email = Email(
      body: '$saludo.\n Le adjuntamos el parte realizado a $nombreCliente',
      subject: 'Parte realizado a $nombreCliente',
      bcc: [destino],
      attachmentPaths: [rutaParte],
      isHTML: false,
    );

    //abrimos la aplicacion de correo electrónico con el email precargado
    await FlutterEmailSender.send(email).onError((e, _) {
      codigoSalida = -1;
    });

    return codigoSalida;
  }

  //metodo para darle formato a la fecha para poder nombrar el fichero .pdf
  String _guardarFecha(String fecha) {
    List<String> datos = fecha.split('/');
    int? dia = int.tryParse(datos[0]);
    if (dia! < 10) {
      datos[0] = '0$dia';
    }
    String texto = '${datos[2]}_${datos[1]}_${datos[0]}';
    return texto;
  }
}

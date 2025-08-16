import 'package:acuda_keys/models/parte.dart';
import 'package:acuda_keys/widgets/widgets_parte_pdf/casilla_x.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

class DatosSolicitudServicio extends pw.StatelessWidget {
  DatosSolicitudServicio({required this.parte});

  final Parte parte;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      width: double.infinity,
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColor.fromHex('#021C72B9')),
      ),
      child: pw.Padding(
        padding: const pw.EdgeInsets.all(10),
        child: pw.Column(
          children: [
            pw.Row(
              children: [
                pw.Text(
                  'C.R.A.: ',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                pw.Text(
                  parte.cra,
                  style: const pw.TextStyle(color: PdfColors.blue900),
                ),
              ],
            ),
            pw.SizedBox(height: 10),
            pw.Text(
              'SOLICITUD DE SERVICIO POR:',
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.symmetric(vertical: 10),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    children: [
                      pw.Row(
                        children: [
                          pw.Text('Pérdida de comunicación '),
                          pw.Text(
                            '......... ',
                            style: const pw.TextStyle(color: PdfColors.blue900),
                          ),
                          CasillaX(
                            marcado: parte.perdidaComunicacion,
                            padding: 0,
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 10),
                      pw.Row(
                        children: [
                          pw.Text('Incendio '),
                          pw.Text(
                            '.................................... ',
                            style: const pw.TextStyle(color: PdfColors.blue900),
                          ),
                          CasillaX(marcado: parte.incendio, padding: 0),
                        ],
                      ),
                    ],
                  ),
                  pw.Column(
                    children: [
                      pw.Row(
                        children: [
                          pw.Text('Intrusión '),
                          pw.Text(
                            '.......................................... ',
                            style: const pw.TextStyle(color: PdfColors.blue900),
                          ),
                          CasillaX(marcado: parte.intrusion, padding: 0),
                        ],
                      ),
                      pw.SizedBox(height: 10),
                      pw.Row(
                        children: [
                          pw.Text('Otras '),
                          pw.Text(
                            '..... ',
                            style: const pw.TextStyle(color: PdfColors.blue900),
                          ),
                          pw.SizedBox(
                            height: 18,
                            width: 158,
                            child: pw.Container(
                              decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                  color: PdfColor.fromHex('#021C72B9'),
                                ),
                              ),
                              child: pw.Text(
                                parte.otrasIncidencias != null
                                    ? parte.otrasIncidencias!
                                    : '',
                                style: const pw.TextStyle(
                                  color: PdfColors.blue900,
                                ),
                                textAlign: pw.TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 10),
                    ],
                  ),
                ],
              ),
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('HORA AVISO:'),
                pw.SizedBox(
                  height: 15,
                  width: 45,
                  child: pw.Container(
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(
                        color: PdfColor.fromHex('#021C72B9'),
                      ),
                    ),
                    child: pw.Text(
                      parte.horaAviso,
                      style: const pw.TextStyle(color: PdfColors.blue900),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                ),
                pw.Text('HORA LLEGADA:'),
                pw.SizedBox(
                  height: 15,
                  width: 45,
                  child: pw.Container(
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(
                        color: PdfColor.fromHex('#021C72B9'),
                      ),
                    ),
                    child: pw.Text(
                      parte.horaLlegada,
                      style: const pw.TextStyle(color: PdfColors.blue900),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                ),
                pw.Text('HORA FINALIZACIÓN:'),
                pw.SizedBox(
                  height: 15,
                  width: 45,
                  child: pw.Container(
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(
                        color: PdfColor.fromHex('#021C72B9'),
                      ),
                    ),
                    child: pw.Text(
                      parte.horaFinalizacion,
                      style: const pw.TextStyle(color: PdfColors.blue900),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

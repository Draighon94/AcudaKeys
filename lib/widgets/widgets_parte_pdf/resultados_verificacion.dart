import 'package:acuda_keys/models/parte.dart';
import 'package:acuda_keys/widgets/widgets_parte_pdf/casilla_x.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ResultadosVerificacion extends pw.StatelessWidget {
  ResultadosVerificacion({required this.parte});

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
            pw.Text(
              'RESULTADO DE LA VERIFICACIÓN:',
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
            ),
            pw.Row(
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.SizedBox(height: 20),
                    pw.Text('Verificación exterior'),
                    pw.SizedBox(height: 8),
                    pw.Text('Verificación interior'),
                    pw.SizedBox(height: 8),
                    pw.Text('Guardia Civil'),
                    pw.SizedBox(height: 8),
                    pw.Text('Alarma activada'),
                    pw.SizedBox(height: 8),
                    pw.Text('Señales de violencia'),
                    pw.SizedBox(height: 8),
                  ],
                ),
                pw.SizedBox(width: 35),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Text('SI'),
                    CasillaX(marcado: parte.verificacionExterior, padding: 2),
                    CasillaX(marcado: parte.verificacionInterior, padding: 2),
                    CasillaX(marcado: parte.guardiaCivil, padding: 2),
                    CasillaX(marcado: parte.alarmaActivada, padding: 2),
                    CasillaX(marcado: parte.senialesViolencia, padding: 2),
                  ],
                ),
                pw.SizedBox(width: 10),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Text('NO'),
                    CasillaX(marcado: !parte.verificacionExterior, padding: 2),
                    CasillaX(marcado: !parte.verificacionInterior, padding: 2),
                    CasillaX(marcado: !parte.guardiaCivil, padding: 2),
                    CasillaX(marcado: !parte.alarmaActivada, padding: 2),
                    CasillaX(marcado: !parte.senialesViolencia, padding: 2),
                  ],
                ),
                pw.SizedBox(width: 15),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.SizedBox(height: 20),
                    pw.Text('Policía Nacional'),
                    pw.SizedBox(height: 8),
                    pw.Text('Nº Dotación'),
                    pw.SizedBox(height: 8),
                    pw.Text('Instalación cerrada'),
                    pw.SizedBox(height: 8),
                    pw.Text('Personas en el interior'),
                    pw.SizedBox(height: 8),
                    pw.Text('Queda conectado el sistema'),
                    pw.SizedBox(height: 8),
                  ],
                ),
                pw.SizedBox(width: 15),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Row(
                      children: [
                        pw.Text('SI'),
                        pw.SizedBox(width: 12),
                        pw.Text('NO'),
                      ],
                    ),
                    pw.Row(
                      children: [
                        CasillaX(marcado: parte.policia, padding: 0),
                        pw.SizedBox(width: 10),
                        CasillaX(marcado: !parte.policia, padding: 0),
                      ],
                    ),
                    pw.SizedBox(height: 4),
                    pw.SizedBox(
                      height: 18,
                      width: 80,
                      child: pw.Container(
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(
                            color: PdfColor.fromHex('#021C72B9'),
                          ),
                        ),
                        child: pw.Text(
                          parte.numDotacion != null ? parte.numDotacion! : '',
                          style: const pw.TextStyle(color: PdfColors.blue900),
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Row(
                      children: [
                        CasillaX(marcado: parte.instalacionCerrada, padding: 0),
                        pw.SizedBox(width: 10),
                        CasillaX(
                          marcado: !parte.instalacionCerrada,
                          padding: 0,
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 4),
                    pw.Row(
                      children: [
                        CasillaX(marcado: parte.personasInterior, padding: 0),
                        pw.SizedBox(width: 10),
                        CasillaX(marcado: !parte.personasInterior, padding: 0),
                      ],
                    ),
                    pw.SizedBox(height: 4),
                    pw.Row(
                      children: [
                        CasillaX(
                          marcado: parte.quedaSistemaConectado,
                          padding: 0,
                        ),
                        pw.SizedBox(width: 10),
                        CasillaX(
                          marcado: !parte.quedaSistemaConectado,
                          padding: 0,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

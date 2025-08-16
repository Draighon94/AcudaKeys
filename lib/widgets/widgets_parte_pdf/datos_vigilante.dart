import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class DatosVigilante extends pw.StatelessWidget {
  DatosVigilante({
    required this.nombreVigilante,
    required this.tip,
    required this.delegacion,
  });

  final String nombreVigilante;
  final int tip;
  final String delegacion;

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
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Row(
                  children: [
                    pw.Text('NOMBRE: '),
                    pw.Text(
                      nombreVigilante,
                      style: const pw.TextStyle(color: PdfColors.blue900),
                    ),
                  ],
                ),

                pw.Row(
                  children: [
                    pw.Text('TIP: '),
                    pw.Text(
                      tip.toString(),
                      style: const pw.TextStyle(color: PdfColors.blue900),
                    ),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 10),
            pw.Row(
              children: [
                pw.Text('DELEGACIÓN: '),
                pw.Text(
                  delegacion,
                  style: const pw.TextStyle(color: PdfColors.blue900),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

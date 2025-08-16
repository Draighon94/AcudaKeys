import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class DatosCliente extends pw.StatelessWidget {
  DatosCliente({required this.nombreCliente, required this.direccionCliente});

  final String nombreCliente;
  final String direccionCliente;

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
                pw.Text('Cliente: '),
                pw.Text(
                  nombreCliente,
                  style: const pw.TextStyle(color: PdfColors.blue900),
                ),
              ],
            ),
            pw.SizedBox(height: 10),
            pw.Row(
              children: [
                pw.Text('Dirección: '),
                pw.Text(
                  direccionCliente,
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

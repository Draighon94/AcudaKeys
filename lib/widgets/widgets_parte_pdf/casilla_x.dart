import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class CasillaX extends pw.StatelessWidget {
  CasillaX({required this.marcado, required this.padding});

  final bool marcado;
  final double padding;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Padding(
      padding: pw.EdgeInsets.all(padding),
      child: pw.SizedBox(
        height: 18,
        width: 18,
        child: pw.Container(
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColor.fromHex('#021C72B9')),
          ),
          child: pw.Text(
            marcado ? 'X' : '',
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.blue900,
            ),
            textAlign: pw.TextAlign.center,
          ),
        ),
      ),
    );
  }
}

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class EstadisticaInforme extends pw.StatelessWidget {
  EstadisticaInforme({required this.titulo, required this.valor});

  final String titulo;
  final String valor;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(titulo),
          pw.Text(valor, style: const pw.TextStyle(color: PdfColors.blue900)),
        ],
      ),
    );
  }
}

import 'package:acuda_keys/widgets/widgets_informe_pdf/estadistica_informe.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class EstadisticasInforme extends pw.StatelessWidget {
  EstadisticasInforme({
    required this.partesTotales,
    required this.clienteMasServicios,
    required this.vigilanteMasServicios,
    required this.serviciosPerdidaComunicacion,
    required this.serviciosIntrusion,
    required this.serviciosIncendio,
  });

  final int partesTotales;
  final String clienteMasServicios;
  final String vigilanteMasServicios;
  final int serviciosPerdidaComunicacion;
  final int serviciosIntrusion;
  final int serviciosIncendio;

  @override
  pw.Widget build(pw.Context context) {
    String mesActual = DateFormat('MMMM', 'es_ES').format(DateTime.now());

    return pw.Container(
      width: double.infinity,
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColor.fromHex('#021C72B9')),
      ),
      child: pw.Column(
        children: [
          pw.SizedBox(height: 10),
          pw.Text(
            mesActual.toUpperCase(),
            style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
          ),
          EstadisticaInforme(
            titulo: 'Numero de partes realizados este mes',
            valor: '$partesTotales',
          ),
          EstadisticaInforme(
            titulo: 'Cliente con más Servicios:',
            valor: clienteMasServicios,
          ),
          EstadisticaInforme(
            titulo: 'Vigilante con más Servicios realizados: ',
            valor: vigilanteMasServicios,
          ),
          EstadisticaInforme(
            titulo: 'Servicios por pérdida de comunicación: ',
            valor: '$serviciosPerdidaComunicacion',
          ),
          EstadisticaInforme(
            titulo: 'Servicios por intrusión: ',
            valor: '$serviciosIntrusion',
          ),
          EstadisticaInforme(
            titulo: 'Servicios por incendio: ',
            valor: '$serviciosIncendio',
          ),
          pw.SizedBox(height: 400),
        ],
      ),
    );
  }
}

import 'package:acuda_keys/models/central_receptora_alarmas.dart';

class Cliente {
  Cliente({
    required this.codLlave,
    required this.nombreCliente,
    required this.direccionGoogleMaps,
    required this.cra,
    this.cantidadLlaves,
    this.funcionanLlaves,
  });

  String codLlave;
  String nombreCliente;
  String direccionGoogleMaps;
  int? cantidadLlaves;
  bool? funcionanLlaves;
  CentralReceptoraAlarmas cra;
}

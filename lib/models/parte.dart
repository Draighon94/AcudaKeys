class Parte {
  Parte({
    required this.nombreVigilante,
    required this.tip,
    required this.fecha,
    required this.cliente,
    required this.direccionCliente,
    required this.delegacion,
    required this.cra,
    required this.perdidaComunicacion,
    required this.intrusion,
    required this.incendio,
    this.otrasIncidencias,
    required this.horaAviso,
    required this.horaLlegada,
    required this.horaFinalizacion,
    required this.verificacionInterior,
    required this.verificacionExterior,
    required this.guardiaCivil,
    required this.alarmaActivada,
    required this.senialesViolencia,
    required this.policia,
    this.numDotacion,
    required this.instalacionCerrada,
    required this.personasInterior,
    required this.quedaSistemaConectado,
    this.observaciones,
  });

  String nombreVigilante;
  int tip;
  String fecha;
  String cliente;
  String direccionCliente;
  String delegacion;
  String cra;
  bool perdidaComunicacion;
  bool intrusion;
  bool incendio;
  String? otrasIncidencias;
  String horaAviso;
  String horaLlegada;
  String horaFinalizacion;
  bool verificacionInterior;
  bool verificacionExterior;
  bool guardiaCivil;
  bool alarmaActivada;
  bool senialesViolencia;
  bool policia;
  String? numDotacion;
  bool instalacionCerrada;
  bool personasInterior;
  bool quedaSistemaConectado;
  String? observaciones;
}

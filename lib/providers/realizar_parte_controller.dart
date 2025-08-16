import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'realizar_parte_controller.g.dart';

final Map<String, TextEditingController> controladores = {
  'nombreClienteController': TextEditingController(),
  'direccionClienteController': TextEditingController(),
  'nombreVigilanteController': TextEditingController(),
  'tipController': TextEditingController(),
  'delegacionController': TextEditingController(),
  'fechaController': TextEditingController(),
  'nombreCRAController': TextEditingController(),
  'horaAvisoController': TextEditingController(),
  'horaLlegadaController': TextEditingController(),
  'horaFinalController': TextEditingController(),
  'otrasIncidenciasController': TextEditingController(),
  'numDotacionController': TextEditingController(),
  'observacionesController': TextEditingController(),
  'emailCRAController': TextEditingController(),
};

//provider que almacena la lista de controladores de los TextFields del formulario del parte de servicio
@riverpod
class RealizarParteController extends _$RealizarParteController {
  @override
  Map<String, TextEditingController> build() => controladores;

  //metodo que limpia los campos del formulario al realizar el parte
  void limpiarCampos() {
    for (var i = 0; i < controladores.values.toList().length; i++) {
      controladores.values.toList()[i].text = '';
    }
  }

  //metodo que devuelve el email de la CRA
  String obtenerEmailCRA() {
    return controladores['emailCRAController']!.text;
  }

  //metodo que devuelve el nombre del cliente
  String obtenerNombreCliente() {
    return controladores['nombreClienteController']!.text;
  }
}

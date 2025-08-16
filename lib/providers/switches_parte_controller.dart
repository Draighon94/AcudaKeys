import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'switches_parte_controller.g.dart';

Map<String, bool> switches = {
  'perdidaComunicacion': false,
  'intrusion': false,
  'incendio': false,
  'exterior': false,
  'interior': false,
  'guardiaCivil': false,
  'policia': false,
  'instalacionCerrada': false,
  'alarmaActivada': false,
  'senialesViolencia': false,
  'personasInterior': false,
  'sistemaConectado': false,
};

//provider que almacena todos los valores de los switches del formulario del parte de servicio
@riverpod
class SwitchesParteController extends _$SwitchesParteController {
  @override
  Map<String, bool> build() => switches;

  //método que reinicia los switches del formulario de realizar parte
  void reinicarSwitches() {
    for (var i = 0; i < switches.values.toList().length; i++) {
      switches.values.toList()[i] = false;
    }
  }
}

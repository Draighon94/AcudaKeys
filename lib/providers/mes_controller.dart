import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mes_controller.g.dart';

//provider que guarda la informacion del mes al que queremos hacer el informe
@riverpod
class MesController extends _$MesController {
  @override
  String build() => '';

  //metodo que cambia el mes
  void actualizarMes(String mes) {
    state = mes;
  }

  //metdo que devuelve el numero del mes en todos los idiomas
  int? obtenerMesNumero(String mes) {
    Map<String, int> calendario = {
      "enero": 1,
      "febrero": 2,
      "marzo": 3,
      "abril": 4,
      "mayo": 5,
      "junio": 6,
      "julio": 7,
      "agosto": 8,
      "septiembre": 9,
      "octubre": 10,
      "noviembre": 11,
      "diciembre": 12,
      "January": 1,
      "February": 2,
      "March": 3,
      "April": 4,
      "May": 5,
      "June": 6,
      "July": 7,
      "August": 8,
      "September": 9,
      "October": 10,
      "November": 11,
      "December": 12,
      "一月": 1,
      "二月": 2,
      "三月": 3,
      "四月": 4,
      "五月": 5,
      "六月": 6,
      "七月": 7,
      "八月": 8,
      "九月": 9,
      "十月": 10,
      "十一月": 11,
      "十二月": 12,
      "1月": 1,
      "2月": 2,
      "3月": 3,
      "4月": 4,
      "5月": 5,
      "6月": 6,
      "7月": 7,
      "8月": 8,
      "9月": 9,
      "10月": 10,
      "11月": 11,
      "12月": 12,
    };

    return calendario[mes];
  }
}

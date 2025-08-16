import 'package:acuda_keys/models/central_receptora_alarmas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cras_controller.g.dart';

final _firebase = FirebaseFirestore.instance;

@riverpod
class CRAsController extends _$CRAsController {
  @override
  List<CentralReceptoraAlarmas> build() {
    List<CentralReceptoraAlarmas> cras = [];
    obtenerCRAs();
    return cras;
  }

  Future<void> obtenerCRAs() async {
    //creamos una lista vacia de CRAs
    List<CentralReceptoraAlarmas> cras = [];
    //recorremos las CRAs de la base de datos
    await _firebase.collection('CRAs').get().then((listaCRAs) {
      //por cada cra de la base de datos
      for (var doc in listaCRAs.docs) {
        //obtenemos sus datos
        final datosCRA = doc.data() as Map<Object?, dynamic>;
        //instanciamos una CRA con los datos
        CentralReceptoraAlarmas cra = CentralReceptoraAlarmas(
          nombre: datosCRA['nombre'],
          telefono: datosCRA['telefono'],
          email: datosCRA['email'],
        );
        //añadimos la CRA a la lista
        cras.add(cra);
      }
    });
    //cuando se hayan agregado todas las CRAs, las asignamos al estado del provider
    state = cras;
  }
}

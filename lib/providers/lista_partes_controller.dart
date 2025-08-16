import 'package:acuda_keys/models/parte.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'lista_partes_controller.g.dart';

final _firebase = FirebaseFirestore.instance;

//provider que contiene la lista de partes de la base de datos
@riverpod
class ListaPartesController extends _$ListaPartesController {
  @override
  List<DocumentReference> build() {
    List<DocumentReference> partes = [];
    obtenerPartes();
    return partes;
  }

  //metodo para obtener la lista de partes de la base de datos
  Future<void> obtenerPartes() async {
    List<DocumentReference> lista = [];
    await _firebase.collection('Partes').get().then((query) {
      //recorremos todos los partes registrados
      for (var doc in query.docs) {
        //añadimos secuencialmene los partes
        lista.add(doc.reference);
      }
    });

    state = lista;
  }

  //metodo para guardar los datos del parte en memoria
  Future<Parte?> guardarParte(DocumentReference refParte) async {
    Parte? parte;

    await _firebase.collection('Partes').doc(refParte.id).get().then((doc) {
      final datosParte = doc.data() as Map<Object?, dynamic>;
      parte = Parte(
        nombreVigilante: datosParte['nombreVigilante'],
        fecha: datosParte['fecha'],
        cra: datosParte['cra'],
        tip: datosParte['tip'],
        horaAviso: datosParte['horaAviso'],
        horaLlegada: datosParte['horaLlegada'],
        horaFinalizacion: datosParte['horaFinalizacion'],
        delegacion: datosParte['delegacion'],
        cliente: datosParte['cliente'],
        direccionCliente: datosParte['direccionCliente'],
        observaciones: datosParte['observaciones'],
        otrasIncidencias: datosParte['otrasIncidendias'],
        numDotacion: datosParte['numDotacion'],
        perdidaComunicacion: datosParte['perdidaComunicacion'],
        intrusion: datosParte['intrusion'],
        incendio: datosParte['incendio'],
        verificacionExterior: datosParte['verificacionExterior'],
        verificacionInterior: datosParte['verificacionInterior'],
        guardiaCivil: datosParte['guardiaCivil'],
        policia: datosParte['policia'],
        instalacionCerrada: datosParte['instalacionCerrada'],
        alarmaActivada: datosParte['alarmaActivada'],
        senialesViolencia: datosParte['senialesViolencia'],
        personasInterior: datosParte['personasInterior'],
        quedaSistemaConectado: datosParte['quedaSistemaConectado'],
      );
    });
    return parte;
  }

  //metodo para mostrar los partes realizados al mismo cliente
  Future<void> filtrarPartesPorCliente(String cliente) async {
    await obtenerPartes();
    List<DocumentReference> partesActuales = state;
    List<DocumentReference> partesFiltrados = [];
    String nombreFormateado = cliente.trim().replaceAll(' ', '_').toLowerCase();

    //buscamos en la lista de partes de la memoria los partes que coincidan con el cliente
    for (var parte in partesActuales) {
      if (parte.id.toLowerCase().contains(nombreFormateado)) {
        //añadimos las coincidencias
        partesFiltrados.add(parte);
      }
    }

    state = partesFiltrados;
  }

  //metodo para mostrar los partes realizados un dia concreto
  Future<void> filtrarPartesPorFecha(String fecha) async {
    await obtenerPartes();
    String fechaFormateada = _guardarFecha(fecha);
    List<DocumentReference> partesActuales = state;
    List<DocumentReference> partesFiltrados = [];

    //buscamos los partes que coincidan con el dia
    for (var parte in partesActuales) {
      if (parte.id.startsWith(fechaFormateada)) {
        //agregamos las coincidencias
        partesFiltrados.add(parte);
      }
    }

    state = partesFiltrados;
  }

  //metodo para darle formato a la fecha para poder filtrar
  String _guardarFecha(String fecha) {
    List<String> datos = fecha.split('/');
    int? dia = int.tryParse(datos[0]);
    //si el dia numerico es menor que 10 le añadimos delante un '0'
    if (dia! < 10) {
      datos[0] = '0$dia';
    }
    String texto = '${datos[2]}_${datos[1]}_${datos[0]}';
    return texto;
  }
}

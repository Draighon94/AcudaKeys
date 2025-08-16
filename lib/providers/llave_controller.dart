import 'package:acuda_keys/models/central_receptora_alarmas.dart';
import 'package:acuda_keys/models/cliente.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'llave_controller.g.dart';

final _firebase = FirebaseFirestore.instance;

//provider que contiene la lista de clientes/llaves de la base de datos
@riverpod
class LlaveController extends _$LlaveController {
  @override
  List<Cliente> build() {
    List<Cliente> clientes = [];
    obtenerClientes();
    return clientes;
  }

  //metodo para obtener la lista de clientes de la base de datos
  Future<void> obtenerClientes() async {
    List<Cliente> clientes = [];
    CentralReceptoraAlarmas cra;
    Cliente cliente;
    Map<Object?, dynamic> datosCliente = {};
    Map<Object?, dynamic> datosCRA = {};

    await _firebase.collection('Clientes').get().then((query) async {
      //recorremos los datos del cliente
      for (var doc in query.docs) {
        //obtenemos los datos del cliente
        datosCliente = doc.data();

        //obtenemos los datos de la CRA
        await _firebase.collection('CRAs').doc(datosCliente['cra']).get().then((
          docCRA,
        ) {
          datosCRA = docCRA.data() as Map<Object?, dynamic>;
        });

        //si hay datos de la CRA, se instancian los objetos
        if (datosCRA.isNotEmpty) {
          //instanciamos una CRA con los datos obtenidos
          cra = CentralReceptoraAlarmas(
            nombre: datosCliente['cra'],
            telefono: datosCRA['telefono'],
            email: datosCRA['email'],
          );
          //instanciamos un cliente con los datos obtenidos
          cliente = Cliente(
            nombreCliente: doc.id,
            codLlave: datosCliente['codLlave'],
            direccionGoogleMaps: datosCliente['direccion'],
            funcionanLlaves: datosCliente['funcionanLlaves'],
            cantidadLlaves: datosCliente['cantidadLlaves'],
            cra: cra,
          );
          //añadimos la instancia creada a la lista de clientes
          clientes.add(cliente);
        }
      }
    });

    state = clientes;
  }

  //metodo para cargar la lista de CRAs de la base de datos
  Future<List<CentralReceptoraAlarmas>> obtenerCRAs() async {
    List<CentralReceptoraAlarmas> cras = [];

    //obtenemos las CRAs de la base de datos
    await _firebase.collection('CRAs').get().then((query) {
      for (var doc in query.docs) {
        Map<Object, dynamic> datosCRA = doc.data() as Map<Object, dynamic>;
        CentralReceptoraAlarmas cra = CentralReceptoraAlarmas(
          nombre: doc.id,
          telefono: datosCRA['telefono'],
          email: datosCRA['email'],
        );
        //añadimos la instancia de la CRA a la lista
        cras.add(cra);
      }
    });

    return cras;
  }

  //metodo para agregar los datos de la llave en la base de datos
  Future<int> agregarLlave(Cliente cliente) async {
    final DocumentReference referenciaCliente = _firebase
        .collection('Clientes')
        .doc(cliente.nombreCliente);
    final CentralReceptoraAlarmas cra = cliente.cra;
    final DocumentReference referenciaCRA = _firebase
        .collection('CRAs')
        .doc(cra.nombre);
    var clientes = state;
    int codigoSalida = 0;

    //agregamos el Cliente
    await referenciaCliente.get().then((snapshot) {
      //el cliente no existe, hay que agregarlo en la base de datos
      if (snapshot.exists) {
        codigoSalida = -1;
      } else {
        //intentamos agregar la CRA
        referenciaCRA.get().then((snapshot) {
          //si no existe, la agregamos
          if (!snapshot.exists) {
            referenciaCRA.set({
              'nombre': cra.nombre,
              'telefono': cra.telefono,
              'email': cra.email,
            });
          }
        });

        //registramos el cliente en la base de datos
        referenciaCliente.set({
          'nombre': cliente.nombreCliente,
          'codLlave': cliente.codLlave,
          'direccion': cliente.direccionGoogleMaps,
          'cra': cra.nombre,
          'cantidadLlaves': cliente.cantidadLlaves,
          'funcionanLlaves': cliente.funcionanLlaves,
        });
        clientes.add(cliente);
        state = clientes;
        codigoSalida = 0;
      }
    });
    //despues de esperar, se devuelve el codigo de salida
    return codigoSalida;
  }

  //método para borrar un cliente
  Future<void> borrarCliente(Cliente cliente) async {
    //borramos el cliente
    await _firebase
        .collection('Clientes')
        .doc(cliente.nombreCliente)
        .delete()
        .then((doc) {
          //cuando se haya borrado actualizamos la lista de clientes
          obtenerClientes();
        });
  }

  //metodo para filtrar clientes por nombre
  Future<void> filtrarPorCliente(String nombreClienteFiltro) async {
    //obtenemos todos los clientes de la base de datos
    await obtenerClientes();
    //instanciamos una lista de clientes vacía
    List<Cliente> clientes = [];

    //recorremos la lista de clientes actuales
    for (var cliente in state) {
      //comprobamos los clientes cuyo nombre contiene la string que pasamos por el filtro
      if (cliente.nombreCliente.toLowerCase().contains(
        nombreClienteFiltro.toLowerCase(),
      )) {
        //añadimos el cliente que coincida a la lista temporal
        clientes.add(cliente);
      }
    }

    //establecemos la lista del provider a la lista actual
    state = clientes;
  }

  //metodo para filtrar clientes por su cra
  Future<void> filtrarPorCra(String nombreCra) async {
    //obtenemos todos los clientes de la base de datos
    await obtenerClientes();
    //cargamos la lista de clientes actual
    List<Cliente> listaClientesActual = state;
    //creamos una lista de clientes vacía
    List<Cliente> clientes = [];

    for (final cliente in listaClientesActual) {
      //comprobamos si los nombres de las CRAs contienen la string que pasamos por el filtro
      if (cliente.cra.nombre.toLowerCase().contains(nombreCra.toLowerCase())) {
        clientes.add(cliente);
      }
    }

    //establecemos la lista en los datos del provider
    state = clientes;
  }
}

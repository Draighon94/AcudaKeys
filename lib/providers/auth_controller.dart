import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';
part 'auth_controller.g.dart';

final _firebase = FirebaseAuth.instance;

@riverpod
class AuthController extends _$AuthController {
  @override
  User? build() => _firebase.currentUser; //devolvemos el usuario activo

  //guardamos en la lista el email y contraseña para autenticarnos
  Future<String> iniciarSesion(String email, String password) async {
    try {
      final userCredential = await _firebase.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      //si el cliente actual es null establecemos el valor del provider a null
      if (userCredential.user == null) {
        state = null;
      }
      //si el cliente no es null lo establecemos en el provider
      if (userCredential.user != null) {
        state = userCredential.user;
      }
      return '';
    } on FirebaseAuthException catch (error) {
      return error.code;
    }
  }

  //metodo que cierra la sesion
  void cerrarSesion() async {
    await _firebase.signOut();
  }
}

import 'dart:io';

import 'package:acuda_keys/l10n/app_localizations.dart';
import 'package:acuda_keys/providers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginContainer extends ConsumerStatefulWidget {
  const LoginContainer({super.key});

  @override
  ConsumerState<LoginContainer> createState() {
    return _LoginContainerState();
  }
}

class _LoginContainerState extends ConsumerState<LoginContainer> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var _isAutenticando = false;

  //método para iniciar sesión
  void _iniciarSesion(WidgetRef ref, AppLocalizations l10n) async {
    //variable para comprobar si se ha podido iniciar sesión
    String sesionIniciada;

    //comienza la autenticacion
    setState(() {
      //establecemos la variable a true
      _isAutenticando = true;
    });

    sesionIniciada = await ref
        .read(authControllerProvider.notifier)
        .iniciarSesion(_emailController.text, _passwordController.text);
    _emailController.text = '';
    _passwordController.text = '';

    //termina la autenticacion
    setState(() {
      //reestablecemos la variable a false
      _isAutenticando = false;
    });

    //si no se ha iniciado sesion
    if (sesionIniciada == 'network-request-failed') {
      //limpiamos las snackBar
      ScaffoldMessenger.of(context).clearSnackBars();
      //mostramos una snackBar informando de la situación
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color.fromARGB(150, 60, 60, 60),
          content: Text(
            l10n.errorConexion,
            style: TextStyle(
              color:
                  Theme.of(context).brightness == Brightness.light
                      ? Theme.of(context).dialogTheme.backgroundColor
                      : const Color.fromARGB(185, 2, 255, 200),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else if (sesionIniciada == 'invalid-email') {
      //limpiamos las snackBar
      ScaffoldMessenger.of(context).clearSnackBars();
      //mostramos una snackBar informando de la situación
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color.fromARGB(150, 60, 60, 60),
          content: Text(
            '${l10n.validadorEmailCRA}.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color:
                  Theme.of(context).brightness == Brightness.light
                      ? Theme.of(context).dialogTheme.backgroundColor
                      : const Color.fromARGB(185, 2, 255, 200),
            ),
          ),
        ),
      );
    } else if (sesionIniciada == 'invalid-credential') {
      //limpiamos las snackBar
      ScaffoldMessenger.of(context).clearSnackBars();
      //mostramos una snackBar informando de la situación
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color.fromARGB(150, 60, 60, 60),
          content: Text(
            l10n.contraseniaIncorrecta,
            textAlign: TextAlign.center,
            style: TextStyle(
              color:
                  Theme.of(context).brightness == Brightness.light
                      ? Theme.of(context).dialogTheme.backgroundColor
                      : const Color.fromARGB(185, 2, 255, 200),
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SizedBox(
      //En la version de windows, el login container va a tener siempre la misma anchura
      width: Platform.isWindows ? 400 : double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 0),
                color: Colors.black,
                blurRadius: 5,
              ),
            ],
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color.fromARGB(255, 35, 76, 167)),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).bannerTheme.backgroundColor!,
                Theme.of(context).bannerTheme.dividerColor!,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: 10,
                ),
                child: TextField(
                  style: GoogleFonts.manrope(
                    color: const Color.fromARGB(200, 2, 28, 114),
                    fontWeight: FontWeight.bold,
                  ),
                  controller: _emailController,
                  cursorColor: const Color.fromARGB(200, 2, 28, 114),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    helperText: l10n.correoElectronico,
                    helperStyle: TextStyle(
                      color: Theme.of(context).dialogTheme.backgroundColor,
                      fontSize: 15,
                    ),
                    fillColor: Theme.of(context).dialogTheme.backgroundColor,
                    filled: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 20,
                  bottom: 20,
                  right: 20,
                ),
                child: TextField(
                  style: GoogleFonts.manrope(
                    color: const Color.fromARGB(200, 2, 28, 114),
                    fontWeight: FontWeight.bold,
                  ),
                  controller: _passwordController,
                  cursorColor: const Color.fromARGB(200, 2, 28, 114),
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    helperText: l10n.contrasenia,
                    helperStyle: TextStyle(
                      color: Theme.of(context).dialogTheme.backgroundColor,
                      fontSize: 15,
                    ),
                    fillColor: Theme.of(context).dialogTheme.backgroundColor,
                    filled: true,
                  ),
                  obscureText: true,
                ),
              ),
              if (!_isAutenticando)
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    bottom: 20,
                    right: 20,
                  ),
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      _iniciarSesion(ref, l10n);
                    },
                    backgroundColor: const Color.fromARGB(186, 2, 28, 114),
                    label: Text(
                      l10n.iniciarSesion,
                      style: GoogleFonts.manrope(
                        color: Theme.of(context).dialogTheme.backgroundColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              if (_isAutenticando)
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    bottom: 40,
                    right: 20,
                  ),
                  child: CircularProgressIndicator(
                    color:
                        Theme.of(context).brightness == Brightness.light
                            ? const Color.fromARGB(200, 2, 28, 114)
                            : const Color.fromARGB(185, 2, 255, 200),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

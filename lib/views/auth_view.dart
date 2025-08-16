import 'package:acuda_keys/widgets/boton_acerdade.dart';
import 'package:acuda_keys/widgets/boton_ajustes.dart';
import 'package:acuda_keys/widgets/login_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

var logoPath = 'assets/images/logo.png';

class AuthView extends ConsumerStatefulWidget {
  const AuthView({super.key});

  @override
  ConsumerState<AuthView> createState() {
    return _AuthViewState();
  }
}

class _AuthViewState extends ConsumerState<AuthView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).secondaryHeaderColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        width: double.infinity,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.sizeOf(context).width < 400 ? 40 : 15,
                  ),
                  child: Image.asset(logoPath, width: 150),
                ),
                Text(
                  'Acuda Keys',
                  style: GoogleFonts.manrope(
                    color: Theme.of(context).dialogTheme.backgroundColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      const Shadow(
                        offset: Offset(1, 1),
                        color: Colors.black,
                        blurRadius: 20,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),
                const LoginContainer(),
                SizedBox(
                  height: MediaQuery.sizeOf(context).width < 400 ? 5 : 15,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [BotonAcerdaDe(), BotonAjustes()],
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

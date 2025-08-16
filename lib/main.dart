import 'package:acuda_keys/l10n/app_localizations.dart';
import 'package:acuda_keys/providers/idioma_actual_controller.dart';
import 'package:acuda_keys/providers/tema_actual_controller.dart';
import 'package:acuda_keys/views/auth_view.dart';
import 'package:acuda_keys/views/cargando_view.dart';
import 'package:acuda_keys/views/menu_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'firebase_options.dart';

void main() async {
  //cargamos el fichero .env con las variables
  await dotenv.load(fileName: ".env");
  //codigo necesario para la autenticacion de firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //establecemos que la aplicacion solo pueda ejecutarse en posicion vertical
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
    fn,
  ) {
    sqfliteFfiInit();
    //envolvemos MyApp con ProviderScope para que la aplicacion pueda hacer uso de los providers.
    runApp(const ProviderScope(child: MyApp()));
  });
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  //Widget raíz de la aplicación.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Acuda Keys',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: ref.watch(idiomaActualControllerProvider),
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.greenAccent,
        secondaryHeaderColor: Colors.blueAccent,
        bannerTheme: const MaterialBannerThemeData(
          backgroundColor: Color.fromARGB(255, 35, 76, 167),
          dividerColor: Color.fromARGB(255, 20, 204, 195),
        ),
        dialogTheme: const DialogThemeData(backgroundColor: Colors.white),
        drawerTheme: const DrawerThemeData(backgroundColor: Colors.white),
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: const Color.fromARGB(255, 33, 67, 126),
        secondaryHeaderColor: const Color.fromARGB(255, 45, 104, 76),
        bannerTheme: const MaterialBannerThemeData(
          backgroundColor: Color.fromARGB(255, 9, 95, 91),
          dividerColor: Color.fromARGB(255, 19, 41, 88),
        ),
        dialogTheme: const DialogThemeData(
          backgroundColor: Color.fromARGB(255, 214, 214, 214),
        ),
        drawerTheme: const DrawerThemeData(
          backgroundColor: Color.fromARGB(255, 71, 71, 71),
        ),
      ),
      themeMode: ref.watch(temaActualControllerProvider),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          //se comprueba si ya hay un token de autenticacion
          if (snapshot.connectionState == ConnectionState.waiting) {
            //se muestra una animación de carga
            return const CargandoView();
          }
          //si hay un token de autenticación
          if (snapshot.hasData) {
            //entramos directamente al menu
            return const MenuView();
          }
          //se muestra la pantalla para autenticarse
          return const AuthView();
        },
      ),
    );
  }
}

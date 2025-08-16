import 'dart:io';
import 'dart:ui';

import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

part 'idioma_actual_controller.g.dart';

//definimos la base de datos de android
Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'ajustes.db'),
    onCreate: (db, version) {
      return db.execute('CREATE TABLE ajustes(idioma TEXT, tema TEXT)');
    },
    version: 1,
  );
  return db;
}

//definimos la base de datos de windows
Future<Database> _getDatabaseWindows() async {
  var databaseFactory = databaseFactoryFfi;
  final Directory appDocumentsDir = await getApplicationDocumentsDirectory();

  String dbPath = path.join(
    appDocumentsDir.path,
    "\\Acuda Keys\\databases",
    "ajustes.db",
  );
  var db = await databaseFactory.openDatabase(dbPath);

  await db.execute(
    'CREATE TABLE IF NOT EXISTS ajustes(idioma TEXT, tema TEXT)',
  );

  return db;
}

@riverpod
class IdiomaActualController extends _$IdiomaActualController {
  @override
  Locale build() {
    cargarIdioma();
    //por defecto ponemos el idioma actual al español
    return const Locale('es');
  }

  //metodo para cambiar el idioma actual
  void cambiarIdioma(Locale locale) {
    guardarIdioma(locale);
    state = locale;
  }

  //metodo para guardar los ajustes del idioma en la base de datos en local
  void guardarIdioma(Locale locale) async {
    //cogemos la base de datos en funcion de la plataforma
    Database db =
        Platform.isAndroid ? await _getDatabase() : await _getDatabaseWindows();
    //cogemos los datos que hay en la base de datos
    List<Map<String, Object?>> datos = await db.query('ajustes');
    //si estan vacips, los guardamos
    if (datos.isEmpty) {
      Map<String, Object?> nuevosDatos = {'idioma': locale.toLanguageTag()};
      db.insert('ajustes', nuevosDatos);
    } //si no estan vacios, borramos los que habian y guardamos los nuevos, para que solo haya un registro
    else {
      db.delete('ajustes');
      String tema = datos.first['tema'] as String;
      Map<String, Object?> nuevosDatos = {
        'idioma': locale.toLanguageTag(),
        'tema': tema,
      };
      db.insert('ajustes', nuevosDatos);
    }
  }

  //metodo para cargar el ajuste del idioma de la base de datos
  void cargarIdioma() async {
    Database db =
        Platform.isAndroid ? await _getDatabase() : await _getDatabaseWindows();

    final datos = await db.query('ajustes');
    state = Locale(datos.first['idioma'] as String);
  }
}

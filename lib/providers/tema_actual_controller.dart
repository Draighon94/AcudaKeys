import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

part 'tema_actual_controller.g.dart';

//obtenemos la base de datos en android
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

//obtenemos la bse de datos en windows
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

//provider que almacena el tema actual de la aplicacion
@riverpod
class TemaActualController extends _$TemaActualController {
  @override
  ThemeMode build() {
    cargarTema();
    //por defecto establecemos el tema del sistema
    return ThemeMode.system;
  }

  //metodo que establece el tema de la aplicacion
  void cambiarTema(ThemeMode tema) {
    guardarTema(tema);
    state = tema;
  }

  //metodo que guarda el ajuste del tema en la base de datos
  void guardarTema(ThemeMode tema) async {
    final db =
        Platform.isAndroid ? await _getDatabase() : await _getDatabaseWindows();

    //obtenemos el ajuste de tema guardado en la base de datos
    List<Map<String, Object?>> datos = await db.query('ajustes');
    //si el dato esta vacio, guardamos el valor actual
    if (datos.isEmpty) {
      Map<String, Object?> nuevosDatos = {'tema': tema.name};
      db.insert('ajustes', nuevosDatos);
    } //si contiene algo, borramos lo que hay y guardamos el ajuste nuevo, para que solo haya un registro
    else {
      String idioma = datos.first['idioma'] as String;
      Map<String, Object?> nuevosDatos = {'idioma': idioma, 'tema': tema.name};
      db.delete('ajustes');
      db.insert('ajustes', nuevosDatos);
    }
  }

  //metodo para cargar el ajuste actual de tema de la base de datos
  void cargarTema() async {
    final db =
        Platform.isAndroid ? await _getDatabase() : await _getDatabaseWindows();
    final datos = await db.query('ajustes');
    switch (datos.first['tema']) {
      case 'light':
        state = ThemeMode.light;
        break;
      case 'dark':
        state = ThemeMode.dark;
        break;
      default:
        state = ThemeMode.system;
    }
  }
}

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('ja'),
    Locale('zh'),
  ];

  /// No description provided for @abrirEnGoogleMaps.
  ///
  /// In es, this message translates to:
  /// **'Abrir en Google Maps'**
  String get abrirEnGoogleMaps;

  /// No description provided for @acercaDe.
  ///
  /// In es, this message translates to:
  /// **'Acerca de'**
  String get acercaDe;

  /// No description provided for @aceptar.
  ///
  /// In es, this message translates to:
  /// **'Aceptar'**
  String get aceptar;

  /// No description provided for @admin.
  ///
  /// In es, this message translates to:
  /// **'Administrador'**
  String get admin;

  /// No description provided for @agregarLlave.
  ///
  /// In es, this message translates to:
  /// **'Agregar Llave'**
  String get agregarLlave;

  /// No description provided for @ajustes.
  ///
  /// In es, this message translates to:
  /// **'Ajustes'**
  String get ajustes;

  /// No description provided for @alarmaActivada.
  ///
  /// In es, this message translates to:
  /// **'Alarma Activada'**
  String get alarmaActivada;

  /// No description provided for @busquedaDePartes.
  ///
  /// In es, this message translates to:
  /// **'Búsqueda de Partes'**
  String get busquedaDePartes;

  /// No description provided for @cantidad.
  ///
  /// In es, this message translates to:
  /// **'Cantidad'**
  String get cantidad;

  /// No description provided for @cantidadDeLlaves.
  ///
  /// In es, this message translates to:
  /// **'Cantidad de Llaves'**
  String get cantidadDeLlaves;

  /// No description provided for @centrarReceptoraAlarmas.
  ///
  /// In es, this message translates to:
  /// **'Central Receptora de Alarmas'**
  String get centrarReceptoraAlarmas;

  /// No description provided for @cerrarSesion.
  ///
  /// In es, this message translates to:
  /// **'Cerrar Sesión'**
  String get cerrarSesion;

  /// No description provided for @chino.
  ///
  /// In es, this message translates to:
  /// **'Chino'**
  String get chino;

  /// No description provided for @claro.
  ///
  /// In es, this message translates to:
  /// **'Claro'**
  String get claro;

  /// No description provided for @cliente.
  ///
  /// In es, this message translates to:
  /// **'Cliente'**
  String get cliente;

  /// No description provided for @clienteExistente.
  ///
  /// In es, this message translates to:
  /// **'Ya existe el cliente en la base de datos'**
  String get clienteExistente;

  /// No description provided for @clienteMasServicios.
  ///
  /// In es, this message translates to:
  /// **'Cliente con más Servicios'**
  String get clienteMasServicios;

  /// No description provided for @codigoDeLlave.
  ///
  /// In es, this message translates to:
  /// **'Código de Llave'**
  String get codigoDeLlave;

  /// No description provided for @confirmacionCerrarSesion.
  ///
  /// In es, this message translates to:
  /// **'¿Estás seguro de que quiere cerrar la sesión?'**
  String get confirmacionCerrarSesion;

  /// No description provided for @confirmacionEliminar.
  ///
  /// In es, this message translates to:
  /// **'¿Estás seguro de que desea eliminar el cliente?'**
  String get confirmacionEliminar;

  /// No description provided for @consultarLlaves.
  ///
  /// In es, this message translates to:
  /// **'Consultar Llaves'**
  String get consultarLlaves;

  /// No description provided for @consultarPartes.
  ///
  /// In es, this message translates to:
  /// **'Consultar Partes'**
  String get consultarPartes;

  /// No description provided for @contrasenia.
  ///
  /// In es, this message translates to:
  /// **'Contraseña'**
  String get contrasenia;

  /// No description provided for @contraseniaIncorrecta.
  ///
  /// In es, this message translates to:
  /// **'contraseña incorrecta.'**
  String get contraseniaIncorrecta;

  /// No description provided for @correoElectronico.
  ///
  /// In es, this message translates to:
  /// **'Correo Electrónico'**
  String get correoElectronico;

  /// No description provided for @cra.
  ///
  /// In es, this message translates to:
  /// **'C.R.A.'**
  String get cra;

  /// No description provided for @datosServicio.
  ///
  /// In es, this message translates to:
  /// **'Datos del Servicio'**
  String get datosServicio;

  /// No description provided for @datosVigilante.
  ///
  /// In es, this message translates to:
  /// **'Datos del Vigilante'**
  String get datosVigilante;

  /// No description provided for @delegacion.
  ///
  /// In es, this message translates to:
  /// **'Delegación'**
  String get delegacion;

  /// No description provided for @direccion.
  ///
  /// In es, this message translates to:
  /// **'Dirección'**
  String get direccion;

  /// No description provided for @direccionCliente.
  ///
  /// In es, this message translates to:
  /// **'Dirección del Cliente'**
  String get direccionCliente;

  /// No description provided for @elegirFecha.
  ///
  /// In es, this message translates to:
  /// **'Elegir Fecha'**
  String get elegirFecha;

  /// No description provided for @eliminar.
  ///
  /// In es, this message translates to:
  /// **'Eliminar'**
  String get eliminar;

  /// No description provided for @enviarA.
  ///
  /// In es, this message translates to:
  /// **'Enviar a'**
  String get enviarA;

  /// No description provided for @enviarParte.
  ///
  /// In es, this message translates to:
  /// **'Enviar Parte'**
  String get enviarParte;

  /// No description provided for @errorEnvio.
  ///
  /// In es, this message translates to:
  /// **'Ha ocurrido un error al enviar el parte'**
  String get errorEnvio;

  /// No description provided for @errorConexion.
  ///
  /// In es, this message translates to:
  /// **'Error al establecer la conexión.'**
  String get errorConexion;

  /// No description provided for @errorGuardar.
  ///
  /// In es, this message translates to:
  /// **'Error al guardar'**
  String get errorGuardar;

  /// No description provided for @errorPdfGuardar.
  ///
  /// In es, this message translates to:
  /// **'No se ha podido guardar el informe en pdf'**
  String get errorPdfGuardar;

  /// No description provided for @espaniol.
  ///
  /// In es, this message translates to:
  /// **'Español'**
  String get espaniol;

  /// No description provided for @exterior.
  ///
  /// In es, this message translates to:
  /// **'Exterior'**
  String get exterior;

  /// No description provided for @fecha.
  ///
  /// In es, this message translates to:
  /// **'Fecha'**
  String get fecha;

  /// No description provided for @filtrosDeBusqueda.
  ///
  /// In es, this message translates to:
  /// **'Filtros de búsqueda'**
  String get filtrosDeBusqueda;

  /// No description provided for @funcionan.
  ///
  /// In es, this message translates to:
  /// **'¿Funcionan?'**
  String get funcionan;

  /// No description provided for @generarInformeMensual.
  ///
  /// In es, this message translates to:
  /// **'Generar Informe Mensual'**
  String get generarInformeMensual;

  /// No description provided for @guardar.
  ///
  /// In es, this message translates to:
  /// **'Guardar'**
  String get guardar;

  /// No description provided for @guardadoEn.
  ///
  /// In es, this message translates to:
  /// **'Se ha guardado en'**
  String get guardadoEn;

  /// No description provided for @guardarInformePDF.
  ///
  /// In es, this message translates to:
  /// **'Guardar informe en PDF'**
  String get guardarInformePDF;

  /// No description provided for @guardarPartePDF.
  ///
  /// In es, this message translates to:
  /// **'Guardar parte en PDF'**
  String get guardarPartePDF;

  /// No description provided for @guardiaCivil.
  ///
  /// In es, this message translates to:
  /// **'Guardia Civil'**
  String get guardiaCivil;

  /// No description provided for @horaAviso.
  ///
  /// In es, this message translates to:
  /// **'Hora Aviso'**
  String get horaAviso;

  /// No description provided for @horaFinal.
  ///
  /// In es, this message translates to:
  /// **'Hora Final'**
  String get horaFinal;

  /// No description provided for @horaLlegada.
  ///
  /// In es, this message translates to:
  /// **'Llegada'**
  String get horaLlegada;

  /// No description provided for @idioma.
  ///
  /// In es, this message translates to:
  /// **'Idioma'**
  String get idioma;

  /// No description provided for @incendio.
  ///
  /// In es, this message translates to:
  /// **'Incendio'**
  String get incendio;

  /// No description provided for @informeDe.
  ///
  /// In es, this message translates to:
  /// **'Informe de'**
  String get informeDe;

  /// No description provided for @ingles.
  ///
  /// In es, this message translates to:
  /// **'Inglés'**
  String get ingles;

  /// No description provided for @iniciarSesion.
  ///
  /// In es, this message translates to:
  /// **'Iniciar Sesión'**
  String get iniciarSesion;

  /// No description provided for @instalacionCerrada.
  ///
  /// In es, this message translates to:
  /// **'Instalación cerrada'**
  String get instalacionCerrada;

  /// No description provided for @interior.
  ///
  /// In es, this message translates to:
  /// **'Interior'**
  String get interior;

  /// No description provided for @intrusion.
  ///
  /// In es, this message translates to:
  /// **'Intrusión'**
  String get intrusion;

  /// No description provided for @japones.
  ///
  /// In es, this message translates to:
  /// **'Japonés'**
  String get japones;

  /// No description provided for @llaves.
  ///
  /// In es, this message translates to:
  /// **'Llaves'**
  String get llaves;

  /// No description provided for @llavesAgregadas.
  ///
  /// In es, this message translates to:
  /// **'Llaves agregadas'**
  String get llavesAgregadas;

  /// No description provided for @mes.
  ///
  /// In es, this message translates to:
  /// **'mes'**
  String get mes;

  /// No description provided for @no.
  ///
  /// In es, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @nombre.
  ///
  /// In es, this message translates to:
  /// **'Nombre'**
  String get nombre;

  /// No description provided for @nombreCliente.
  ///
  /// In es, this message translates to:
  /// **'Nombre del Clente'**
  String get nombreCliente;

  /// No description provided for @nombreVigilante.
  ///
  /// In es, this message translates to:
  /// **'Nombre del Vigilante'**
  String get nombreVigilante;

  /// No description provided for @numDotacion.
  ///
  /// In es, this message translates to:
  /// **'Nº de Dotación'**
  String get numDotacion;

  /// No description provided for @numeroPartesRealizados.
  ///
  /// In es, this message translates to:
  /// **'Número de partes realizados este mes'**
  String get numeroPartesRealizados;

  /// No description provided for @observaciones.
  ///
  /// In es, this message translates to:
  /// **'Observaciones'**
  String get observaciones;

  /// No description provided for @oscuro.
  ///
  /// In es, this message translates to:
  /// **'Oscuro'**
  String get oscuro;

  /// No description provided for @otrasIncidencias.
  ///
  /// In es, this message translates to:
  /// **'Otras Incidencias'**
  String get otrasIncidencias;

  /// No description provided for @parteEnviado.
  ///
  /// In es, this message translates to:
  /// **'El parte se ha enviado a la CRA'**
  String get parteEnviado;

  /// No description provided for @parteGuardado.
  ///
  /// In es, this message translates to:
  /// **'Parte Guardado'**
  String get parteGuardado;

  /// No description provided for @pdfGuardado.
  ///
  /// In es, this message translates to:
  /// **'Se ha guardado el pdf en'**
  String get pdfGuardado;

  /// No description provided for @perdidaComunicacion.
  ///
  /// In es, this message translates to:
  /// **'Pérdida de comunicación'**
  String get perdidaComunicacion;

  /// No description provided for @perosnasInterior.
  ///
  /// In es, this message translates to:
  /// **'Personas en el interior'**
  String get perosnasInterior;

  /// No description provided for @policia.
  ///
  /// In es, this message translates to:
  /// **'Policía'**
  String get policia;

  /// No description provided for @quedaSistemaConectado.
  ///
  /// In es, this message translates to:
  /// **'Queda conectado el sistema'**
  String get quedaSistemaConectado;

  /// No description provided for @realizarParte.
  ///
  /// In es, this message translates to:
  /// **'Realizar Parte'**
  String get realizarParte;

  /// No description provided for @reiniciar.
  ///
  /// In es, this message translates to:
  /// **'Reiniciar'**
  String get reiniciar;

  /// No description provided for @resultadoVerificacion.
  ///
  /// In es, this message translates to:
  /// **'Resultado de la Verificación'**
  String get resultadoVerificacion;

  /// No description provided for @rutaNoSeleccionada.
  ///
  /// In es, this message translates to:
  /// **'No has seleccionado una ruta'**
  String get rutaNoSeleccionada;

  /// No description provided for @seleccionaFichero.
  ///
  /// In es, this message translates to:
  /// **'Selecciona un fichero pdf para previsualizarlo'**
  String get seleccionaFichero;

  /// No description provided for @seleccionaAnio.
  ///
  /// In es, this message translates to:
  /// **'Selecciona el año'**
  String get seleccionaAnio;

  /// No description provided for @seleccionaMes.
  ///
  /// In es, this message translates to:
  /// **'Selecciona el mes'**
  String get seleccionaMes;

  /// No description provided for @seleccionarParte.
  ///
  /// In es, this message translates to:
  /// **'Seleccionar un parte...'**
  String get seleccionarParte;

  /// No description provided for @senialesViolencia.
  ///
  /// In es, this message translates to:
  /// **'Señales de violencia'**
  String get senialesViolencia;

  /// No description provided for @serviciosIncendio.
  ///
  /// In es, this message translates to:
  /// **'Servicios por incendio'**
  String get serviciosIncendio;

  /// No description provided for @serviciosIntrusion.
  ///
  /// In es, this message translates to:
  /// **'Servicios por intrusión'**
  String get serviciosIntrusion;

  /// No description provided for @serviciosPerdidaComunicacion.
  ///
  /// In es, this message translates to:
  /// **'Servicios por pérdida de comunicación'**
  String get serviciosPerdidaComunicacion;

  /// No description provided for @sesionIniciada.
  ///
  /// In es, this message translates to:
  /// **'Se ha iniciado sesión con'**
  String get sesionIniciada;

  /// No description provided for @si.
  ///
  /// In es, this message translates to:
  /// **'Sí'**
  String get si;

  /// No description provided for @sistema.
  ///
  /// In es, this message translates to:
  /// **'Sistema'**
  String get sistema;

  /// No description provided for @telefono.
  ///
  /// In es, this message translates to:
  /// **'Teléfono'**
  String get telefono;

  /// No description provided for @tema.
  ///
  /// In es, this message translates to:
  /// **'Tema'**
  String get tema;

  /// No description provided for @textAcercaDe.
  ///
  /// In es, this message translates to:
  /// **'Esta aplicación ha sido desarrollada por Jonatan Reyes González, alumno de 2ºDAM en el IES Leonardo da Vinci'**
  String get textAcercaDe;

  /// No description provided for @usuario.
  ///
  /// In es, this message translates to:
  /// **'Usuario'**
  String get usuario;

  /// No description provided for @vigilante.
  ///
  /// In es, this message translates to:
  /// **'Vigilante'**
  String get vigilante;

  /// No description provided for @vigilanteMasServicios.
  ///
  /// In es, this message translates to:
  /// **'Vigilante con más Servicios'**
  String get vigilanteMasServicios;

  /// No description provided for @validadorCodLlave.
  ///
  /// In es, this message translates to:
  /// **'Introduce un valor para el código de la llave'**
  String get validadorCodLlave;

  /// No description provided for @validadorCliente.
  ///
  /// In es, this message translates to:
  /// **'Seleccione un cliente'**
  String get validadorCliente;

  /// No description provided for @validadorDelegacion.
  ///
  /// In es, this message translates to:
  /// **'Introduce la delegación'**
  String get validadorDelegacion;

  /// No description provided for @validadorDireccionCliente.
  ///
  /// In es, this message translates to:
  /// **'Introduce la dirección del cliente'**
  String get validadorDireccionCliente;

  /// No description provided for @validadorEmailCRA.
  ///
  /// In es, this message translates to:
  /// **'Correo electrónico no válido'**
  String get validadorEmailCRA;

  /// No description provided for @validadorFecha.
  ///
  /// In es, this message translates to:
  /// **'Seleccione una fecha'**
  String get validadorFecha;

  /// No description provided for @validadorHora.
  ///
  /// In es, this message translates to:
  /// **'Seleccione una hora'**
  String get validadorHora;

  /// No description provided for @validadorNombre.
  ///
  /// In es, this message translates to:
  /// **'Nombre erróneo'**
  String get validadorNombre;

  /// No description provided for @validadorNombreCliente.
  ///
  /// In es, this message translates to:
  /// **'Introduce el nombre del cliente'**
  String get validadorNombreCliente;

  /// No description provided for @validadorNombreVigilante.
  ///
  /// In es, this message translates to:
  /// **'Introduce el nombre del vigilante'**
  String get validadorNombreVigilante;

  /// No description provided for @validadorTelefonoCRA.
  ///
  /// In es, this message translates to:
  /// **'Teléfono incorrecto'**
  String get validadorTelefonoCRA;

  /// No description provided for @validadorTIP.
  ///
  /// In es, this message translates to:
  /// **'Falta la TIP'**
  String get validadorTIP;

  /// No description provided for @validadorCantidadLlaves.
  ///
  /// In es, this message translates to:
  /// **'Introduce un número entero'**
  String get validadorCantidadLlaves;

  /// No description provided for @volver.
  ///
  /// In es, this message translates to:
  /// **'Volver'**
  String get volver;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'ja', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'ja':
      return AppLocalizationsJa();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

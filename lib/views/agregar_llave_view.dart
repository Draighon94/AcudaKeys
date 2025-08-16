// ignore_for_file: use_build_context_synchronously

import 'package:acuda_keys/l10n/app_localizations.dart';
import 'package:acuda_keys/models/central_receptora_alarmas.dart';
import 'package:acuda_keys/models/cliente.dart';
import 'package:acuda_keys/providers/llave_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class AgregarLlaveView extends ConsumerStatefulWidget {
  const AgregarLlaveView({super.key});

  @override
  ConsumerState<AgregarLlaveView> createState() {
    return _AgregarClienteViewState();
  }
}

class _AgregarClienteViewState extends ConsumerState<AgregarLlaveView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _funcionanLlaves = true;
  final _codLlaveController = TextEditingController();
  final _nombreClienteController = TextEditingController();
  final _direccionClienteController = TextEditingController();
  final _nombreCRAController = TextEditingController();
  final _telefonoCRAController = TextEditingController();
  final _emailCRAController = TextEditingController();
  final _cantidadLlavesController = TextEditingController();
  bool guardando = false;

  //metodo que limpia los campos
  void _limpiarCampos() {
    _codLlaveController.text = '';
    _nombreCRAController.text = '';
    _nombreClienteController.text = '';
    _telefonoCRAController.text = '';
    _cantidadLlavesController.text = '';
    _direccionClienteController.text = '';
    _emailCRAController.text = '';
    _funcionanLlaves = true;
  }

  //metodo que agrega la llave
  void _agregarLlave(WidgetRef ref, AppLocalizations l10n) async {
    setState(() {
      guardando = true;
    });
    var cra = CentralReceptoraAlarmas(
      nombre: _nombreCRAController.text.trim(),
      telefono: int.parse(_telefonoCRAController.text.trim()),
      email: _emailCRAController.text.trim(),
    );

    var cliente = Cliente(
      codLlave: _codLlaveController.text,
      cra: cra,
      nombreCliente: _nombreClienteController.text,
      direccionGoogleMaps: _direccionClienteController.text,
      cantidadLlaves: int.parse(_cantidadLlavesController.text),
      funcionanLlaves: _funcionanLlaves,
    );

    //llamo al metodo del provider que almacena la logica para registrar la llave
    final resultado = await ref
        .read(llaveControllerProvider.notifier)
        .agregarLlave(cliente);

    //limpiamos las snackbar si las hay.
    ScaffoldMessenger.of(context).clearSnackBars();
    //mostramos una snackBar informando de la situación
    if (resultado == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color.fromARGB(150, 60, 60, 60),
          content: Text(
            l10n.llavesAgregadas,
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
      //si se ha agregado, limpiamos los campos
      _limpiarCampos();
    } else if (resultado == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color.fromARGB(150, 60, 60, 60),
          content: Text(
            l10n.clienteExistente,
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
    }
    setState(() {
      guardando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          l10n.agregarLlave,
          style: GoogleFonts.manrope(
            color: Theme.of(context).dialogTheme.backgroundColor,
            fontSize: 25,
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
        backgroundColor: Colors.transparent,
        leading: BackButton(
          color: Theme.of(context).dialogTheme.backgroundColor,
        ),
      ),
      extendBodyBehindAppBar: true,
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
        child: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 50,
                  right: 50,
                  top: MediaQuery.sizeOf(context).width > 400 ? 110 : 80,
                  bottom: 0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      cursorColor: const Color.fromARGB(200, 2, 28, 114),
                      style: GoogleFonts.manrope(
                        color: const Color.fromARGB(200, 2, 28, 114),
                        fontWeight: FontWeight.bold,
                      ),
                      controller: _codLlaveController,
                      validator: (value) {
                        if (value!.isEmpty && value.trim().isEmpty) {
                          return l10n.validadorCantidadLlaves;
                        }
                        return null;
                      },
                      autocorrect: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        helperText: l10n.codigoDeLlave,
                        helperStyle: TextStyle(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? const Color.fromARGB(200, 2, 28, 114)
                                  : const Color.fromARGB(185, 2, 255, 200),
                          fontSize: 15,
                        ),
                        fillColor:
                            Theme.of(context).dialogTheme.backgroundColor,
                        filled: true,
                      ),
                      maxLength: 5,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      style: GoogleFonts.manrope(
                        color: const Color.fromARGB(200, 2, 28, 114),
                        fontWeight: FontWeight.bold,
                      ),
                      cursorColor: const Color.fromARGB(200, 2, 28, 114),
                      autocorrect: false,
                      controller: _nombreClienteController,
                      validator: (value) {
                        if (value!.isEmpty && value.trim().isEmpty) {
                          return l10n.validadorNombreCliente;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        helperText: l10n.nombreCliente,
                        helperStyle: TextStyle(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? const Color.fromARGB(200, 2, 28, 114)
                                  : const Color.fromARGB(185, 2, 255, 200),
                          fontSize: 15,
                        ),
                        fillColor:
                            Theme.of(context).dialogTheme.backgroundColor,
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      style: GoogleFonts.manrope(
                        color: const Color.fromARGB(200, 2, 28, 114),
                        fontWeight: FontWeight.bold,
                      ),
                      cursorColor: const Color.fromARGB(200, 2, 28, 114),
                      autocorrect: false,
                      controller: _direccionClienteController,
                      validator: (value) {
                        if (value!.isEmpty && value.trim().isEmpty) {
                          return l10n.validadorDireccionCliente;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        helperText: l10n.direccionCliente,
                        helperStyle: TextStyle(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? const Color.fromARGB(200, 2, 28, 114)
                                  : const Color.fromARGB(185, 2, 255, 200),
                          fontSize: 15,
                        ),
                        fillColor:
                            Theme.of(context).dialogTheme.backgroundColor,
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color.fromARGB(186, 2, 28, 114),
                        ),
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
                          Text(
                            l10n.centrarReceptoraAlarmas,
                            style: GoogleFonts.manrope(
                              color:
                                  Theme.of(context).dialogTheme.backgroundColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    style: GoogleFonts.manrope(
                                      color: const Color.fromARGB(
                                        200,
                                        2,
                                        28,
                                        114,
                                      ),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    cursorColor: const Color.fromARGB(
                                      200,
                                      2,
                                      28,
                                      114,
                                    ),
                                    autocorrect: false,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      helperText: l10n.nombre,
                                      helperStyle: TextStyle(
                                        color:
                                            Theme.of(
                                              context,
                                            ).dialogTheme.backgroundColor,
                                        fontSize: 15,
                                      ),
                                      fillColor:
                                          Theme.of(
                                            context,
                                          ).dialogTheme.backgroundColor,
                                      filled: true,
                                    ),
                                    controller: _nombreCRAController,
                                    validator: (value) {
                                      if (value!.isEmpty &&
                                          value.trim().isEmpty) {
                                        return l10n.validadorNombre;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: TextFormField(
                                    style: GoogleFonts.manrope(
                                      color: const Color.fromARGB(
                                        200,
                                        2,
                                        28,
                                        114,
                                      ),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    cursorColor: const Color.fromARGB(
                                      200,
                                      2,
                                      28,
                                      114,
                                    ),
                                    autocorrect: false,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      helperText: l10n.telefono,
                                      helperStyle: TextStyle(
                                        color:
                                            Theme.of(
                                              context,
                                            ).dialogTheme.backgroundColor,
                                        fontSize: 15,
                                      ),
                                      fillColor:
                                          Theme.of(
                                            context,
                                          ).dialogTheme.backgroundColor,
                                      filled: true,
                                    ),
                                    maxLength: 9,
                                    controller: _telefonoCRAController,
                                    validator: (value) {
                                      RegExp validador = RegExp(
                                        r'^[9|7|6]\d{8}$',
                                      );
                                      if (!validador.hasMatch(value!)) {
                                        return l10n.validadorTelefonoCRA;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              style: GoogleFonts.manrope(
                                color: const Color.fromARGB(200, 2, 28, 114),
                                fontWeight: FontWeight.bold,
                              ),
                              autocorrect: false,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                helperText: l10n.correoElectronico,
                                helperStyle: TextStyle(
                                  color:
                                      Theme.of(
                                        context,
                                      ).dialogTheme.backgroundColor,
                                  fontSize: 15,
                                ),
                                fillColor:
                                    Theme.of(
                                      context,
                                    ).dialogTheme.backgroundColor,
                                filled: true,
                              ),
                              controller: _emailCRAController,
                              cursorColor: const Color.fromARGB(
                                200,
                                2,
                                28,
                                114,
                              ),
                              validator: (value) {
                                if (value == null ||
                                    !value.contains('@') ||
                                    value.contains(' ') ||
                                    (!value.endsWith('.es') &&
                                        !value.endsWith('.com'))) {
                                  return l10n.validadorEmailCRA;
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color.fromARGB(186, 2, 28, 114),
                        ),
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
                          Text(
                            l10n.llaves,
                            style: GoogleFonts.manrope(
                              color:
                                  Theme.of(context).dialogTheme.backgroundColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    style: GoogleFonts.manrope(
                                      color: const Color.fromARGB(
                                        200,
                                        2,
                                        28,
                                        114,
                                      ),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    cursorColor: const Color.fromARGB(
                                      200,
                                      2,
                                      28,
                                      114,
                                    ),
                                    keyboardType: TextInputType.number,
                                    autocorrect: false,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      helperText: l10n.cantidad,
                                      helperStyle: TextStyle(
                                        color:
                                            Theme.of(
                                              context,
                                            ).dialogTheme.backgroundColor,
                                        fontSize: 15,
                                      ),
                                      fillColor:
                                          Theme.of(
                                            context,
                                          ).dialogTheme.backgroundColor,
                                      filled: true,
                                    ),
                                    controller: _cantidadLlavesController,
                                    validator: (value) {
                                      if (int.tryParse(value!) == null) {
                                        return l10n.validadorCantidadLlaves;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        l10n.funcionan,
                                        style: GoogleFonts.manrope(
                                          color:
                                              Theme.of(
                                                context,
                                              ).dialogTheme.backgroundColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Switch(
                                        value: _funcionanLlaves,
                                        onChanged: (value) {
                                          setState(() {
                                            _funcionanLlaves = value;
                                          });
                                        },
                                        activeTrackColor:
                                            Theme.of(context).brightness ==
                                                    Brightness.light
                                                ? const Color.fromARGB(
                                                  200,
                                                  2,
                                                  28,
                                                  114,
                                                )
                                                : const Color.fromARGB(
                                                  185,
                                                  2,
                                                  255,
                                                  200,
                                                ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        bottom: 20,
                        right: 20,
                      ),
                      child:
                          !guardando
                              ? FloatingActionButton.extended(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _agregarLlave(ref, l10n);
                                  }
                                },
                                backgroundColor: const Color.fromARGB(
                                  186,
                                  2,
                                  28,
                                  114,
                                ),
                                label: Text(
                                  l10n.agregarLlave,
                                  style: GoogleFonts.manrope(
                                    color:
                                        Theme.of(
                                          context,
                                        ).dialogTheme.backgroundColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              )
                              : const CircularProgressIndicator(
                                color: Color.fromARGB(186, 2, 28, 114),
                              ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:acuda_keys/l10n/app_localizations.dart';
import 'package:acuda_keys/providers/idioma_actual_controller.dart';
import 'package:acuda_keys/providers/mes_controller.dart';
import 'package:acuda_keys/views/generar_informe_view.dart';
import 'package:acuda_keys/widgets/widgets_windows/generar_informe_windows.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class GenerarInformePreview extends ConsumerStatefulWidget {
  const GenerarInformePreview({super.key});

  @override
  ConsumerState<GenerarInformePreview> createState() {
    return _GenerarInformePreviewState();
  }
}

class _GenerarInformePreviewState extends ConsumerState<GenerarInformePreview> {
  String anioSeleccionado = '';

  //sacamos la lista de meses para mostrarlo luego en el dropdownbutton
  List<String> obtenerMeses(Locale locale) {
    final List<String> meses = [];

    for (var i = 1; i <= 12; i++) {
      final dateTime = DateTime(2020, i, 1);
      meses.add(DateFormat('MMMM', locale.languageCode).format(dateTime));
    }
    return meses;
  }

  @override
  Widget build(BuildContext context) {
    final idiomaActual = ref.watch(idiomaActualControllerProvider);
    final meses = obtenerMeses(idiomaActual);
    final anios = [
      '2025',
      '2024',
      '2023',
      '2022',
      '2021',
      '2020',
      '2019',
      '2018',
      '2017',
    ];
    String mesSeleccionado = ref.watch(mesControllerProvider);
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          l10n.generarInformeMensual,
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 300,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${l10n.seleccionaMes}:',
                      style: GoogleFonts.manrope(
                        color:
                            Theme.of(context).brightness == Brightness.light
                                ? Theme.of(context).dialogTheme.backgroundColor
                                : const Color.fromARGB(185, 2, 255, 200),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).drawerTheme.backgroundColor,
                        border: Border.all(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? const Color.fromARGB(200, 2, 28, 114)
                                  : const Color.fromARGB(185, 2, 255, 200),
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          top: 2,
                        ),
                        child: DropdownButton(
                          value:
                              mesSeleccionado == ''
                                  ? meses.first
                                  : mesSeleccionado,
                          dropdownColor:
                              Theme.of(context).drawerTheme.backgroundColor,
                          icon: const Icon(
                            Icons.abc,
                            color: Colors.transparent,
                          ),
                          borderRadius: BorderRadius.circular(15),
                          underline: Container(
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                          ),
                          style: GoogleFonts.manrope(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? const Color.fromARGB(200, 2, 28, 114)
                                    : const Color.fromARGB(185, 2, 255, 200),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          items:
                              meses.map<DropdownMenuItem<String>>((
                                String value,
                              ) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                          onChanged: (value) {
                            ref
                                .read(mesControllerProvider.notifier)
                                .actualizarMes(value!);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${l10n.seleccionaAnio}:',
                      style: GoogleFonts.manrope(
                        color:
                            Theme.of(context).brightness == Brightness.light
                                ? Theme.of(context).dialogTheme.backgroundColor
                                : const Color.fromARGB(185, 2, 255, 200),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).drawerTheme.backgroundColor,
                        border: Border.all(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? const Color.fromARGB(200, 2, 28, 114)
                                  : const Color.fromARGB(185, 2, 255, 200),
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          top: 2,
                        ),
                        child: DropdownButton(
                          value:
                              anioSeleccionado == ''
                                  ? anios.first
                                  : anioSeleccionado,
                          dropdownColor:
                              Theme.of(context).drawerTheme.backgroundColor,
                          icon: const Icon(
                            Icons.abc,
                            color: Colors.transparent,
                          ),
                          borderRadius: BorderRadius.circular(15),
                          underline: Container(
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                          ),
                          style: GoogleFonts.manrope(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? const Color.fromARGB(200, 2, 28, 114)
                                    : const Color.fromARGB(185, 2, 255, 200),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          items:
                              anios.map<DropdownMenuItem<String>>((
                                String value,
                              ) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                          onChanged: (value) {
                            setState(() {
                              anioSeleccionado = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              FloatingActionButton.extended(
                onPressed: () {
                  if (Platform.isWindows) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return GenerarInformeWindows(
                            mesIndex: meses.indexOf(mesSeleccionado),
                            anioIndex: anioSeleccionado,
                          );
                        },
                      ),
                    );
                  } else {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return GenerarInformeView(
                            mesIndex: meses.indexOf(mesSeleccionado),
                            anioIndex: anioSeleccionado,
                          );
                        },
                      ),
                    );
                  }
                },
                label: Text(
                  l10n.generarInformeMensual,
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    color: Theme.of(context).dialogTheme.backgroundColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: const Color.fromARGB(186, 2, 28, 114),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

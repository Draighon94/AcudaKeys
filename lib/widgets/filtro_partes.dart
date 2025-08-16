import 'package:acuda_keys/l10n/app_localizations.dart';
import 'package:acuda_keys/providers/lista_partes_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class FiltroPartes extends ConsumerStatefulWidget {
  const FiltroPartes({super.key});

  @override
  ConsumerState<FiltroPartes> createState() {
    return _FiltroState();
  }
}

class _FiltroState extends ConsumerState<FiltroPartes> {
  final _nombreClienteController = TextEditingController();
  final _fechaController = TextEditingController();

  //metodo que abre el selector de fecha
  Future<void> _seleccionarFecha(TextEditingController controlador) async {
    await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
      initialDate: DateTime.now(),
      locale: const Locale('es'),
    ).then((fechaElegida) {
      controlador.text =
          '${fechaElegida!.day}/${fechaElegida.month}/${fechaElegida.year}';
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Container(
            height:
                MediaQuery.sizeOf(context).width > 400
                    ? MediaQuery.of(context).size.height / 5
                    : MediaQuery.of(context).size.height / 3.5,
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
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 10),
                    child: Image.asset('assets/icon/icon.png', scale: 10),
                  ),
                ),
                Text(
                  'Acuda Keys',
                  style: GoogleFonts.manrope(
                    color: Theme.of(context).dialogTheme.backgroundColor,
                    fontSize: 20,
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
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).drawerTheme.backgroundColor,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
                child: Column(
                  children: [
                    Text(
                      l10n.busquedaDePartes,
                      style: GoogleFonts.manrope(
                        color:
                            Theme.of(context).brightness == Brightness.light
                                ? const Color.fromARGB(200, 2, 28, 114)
                                : const Color.fromARGB(185, 2, 255, 200),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //linea del subrayado
                    Divider(
                      thickness: 1.5,
                      color:
                          Theme.of(context).brightness == Brightness.light
                              ? const Color.fromARGB(200, 2, 28, 114)
                              : const Color.fromARGB(185, 2, 255, 200),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          '${l10n.cliente}:',
                          style: GoogleFonts.manrope(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? const Color.fromARGB(200, 2, 28, 114)
                                    : const Color.fromARGB(185, 2, 255, 200),
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.4,
                          child: TextField(
                            controller: _nombreClienteController,
                            keyboardType: TextInputType.name,
                            cursorColor: const Color.fromARGB(200, 2, 28, 114),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              fillColor:
                                  Theme.of(context).dialogTheme.backgroundColor,
                              filled: true,
                            ),
                            style: GoogleFonts.manrope(
                              color: const Color.fromARGB(200, 2, 28, 114),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        FloatingActionButton(
                          onPressed: () {
                            //llamamos al metodo de filtrado por cliente
                            ref
                                .read(listaPartesControllerProvider.notifier)
                                .filtrarPartesPorCliente(
                                  _nombreClienteController.text,
                                );
                            //cerramos el drawer
                            Navigator.of(context).pop();
                          },
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? const Color.fromARGB(200, 2, 28, 114)
                                  : const Color.fromARGB(185, 2, 255, 200),
                          child: Icon(
                            Icons.search_rounded,
                            color:
                                Theme.of(context).dialogTheme.backgroundColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          '${l10n.fecha}:',
                          style: GoogleFonts.manrope(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? const Color.fromARGB(200, 2, 28, 114)
                                    : const Color.fromARGB(185, 2, 255, 200),
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FloatingActionButton(
                          onPressed: () {
                            //llamamos al metodo para seleccionar la hora
                            _seleccionarFecha(_fechaController);
                          },
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? const Color.fromARGB(200, 2, 28, 114)
                                  : const Color.fromARGB(185, 2, 255, 200),
                          child: Icon(
                            Icons.date_range_rounded,
                            color:
                                Theme.of(context).dialogTheme.backgroundColor,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 4,
                          child: TextField(
                            textAlign: TextAlign.center,
                            style: GoogleFonts.manrope(
                              color: const Color.fromARGB(200, 2, 28, 114),
                              fontWeight: FontWeight.bold,
                            ),
                            controller: _fechaController,
                            readOnly: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              fillColor:
                                  Theme.of(context).dialogTheme.backgroundColor,
                              filled: true,
                            ),
                          ),
                        ),
                        FloatingActionButton(
                          onPressed: () {
                            //llamamos al metodo de filtrado por fecha
                            ref
                                .read(listaPartesControllerProvider.notifier)
                                .filtrarPartesPorFecha(_fechaController.text);

                            //cerramos el drawer
                            Navigator.of(context).pop();
                          },
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? const Color.fromARGB(200, 2, 28, 114)
                                  : const Color.fromARGB(185, 2, 255, 200),
                          child: Icon(
                            Icons.search_rounded,
                            color:
                                Theme.of(context).dialogTheme.backgroundColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FloatingActionButton.extended(
                          onPressed: () {
                            //Reiniciamos el filtro obteniendo todos los partes
                            ref
                                .read(listaPartesControllerProvider.notifier)
                                .obtenerPartes();
                            //cerramos el drawer
                            Navigator.of(context).pop();
                          },
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? const Color.fromARGB(200, 2, 28, 114)
                                  : const Color.fromARGB(185, 2, 255, 200),
                          label: Text(
                            l10n.reiniciar,
                            style: GoogleFonts.manrope(
                              color:
                                  Theme.of(context).dialogTheme.backgroundColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          icon: Icon(
                            Icons.restart_alt_rounded,
                            color:
                                Theme.of(context).dialogTheme.backgroundColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

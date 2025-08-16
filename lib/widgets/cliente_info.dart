import 'package:acuda_keys/l10n/app_localizations.dart';
import 'package:acuda_keys/models/cliente.dart';
import 'package:acuda_keys/providers/llave_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ClienteInfo extends ConsumerStatefulWidget {
  const ClienteInfo({super.key, required this.cliente});

  final Cliente cliente;

  @override
  ConsumerState<ClienteInfo> createState() {
    return _ClienteInfoState();
  }
}

class _ClienteInfoState extends ConsumerState<ClienteInfo> {
  _ClienteInfoState();

  //función para hacer abrir la aplicacion de telefono con el numero de la CRA marcado
  Future<void> _hacerLlamada() async {
    final Uri uri = Uri(
      scheme: 'tel',
      path: widget.cliente.cra.telefono.toString(),
    );
    await launchUrl(uri);
  }

  //método para abrir la dirección del cliente en google maps
  Future<void> _abrirDireccion() async {
    final Uri googleMapsUri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${widget.cliente.direccionGoogleMaps}',
    );
    await launchUrl(googleMapsUri);
  }

  @override
  build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      child: SizedBox(
        child: Column(
          children: [
            Center(
              child: Text(
                widget.cliente.nombreCliente,
                style: GoogleFonts.manrope(
                  color:
                      Theme.of(context).brightness == Brightness.light
                          ? const Color.fromARGB(186, 2, 28, 114)
                          : Theme.of(context).dialogTheme.backgroundColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),

            Container(
              height: 1.5,
              color:
                  Theme.of(context).brightness == Brightness.light
                      ? const Color.fromARGB(186, 2, 28, 114)
                      : Theme.of(context).dialogTheme.backgroundColor,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    Text(
                      '${l10n.codigoDeLlave}: ',
                      style: GoogleFonts.manrope(
                        color:
                            Theme.of(context).brightness == Brightness.light
                                ? const Color.fromARGB(186, 2, 28, 114)
                                : Theme.of(context).dialogTheme.backgroundColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    Text(
                      widget.cliente.codLlave,
                      style: GoogleFonts.manrope(
                        color:
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.black
                                : const Color.fromARGB(185, 2, 255, 200),
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  '${l10n.cantidadDeLlaves}: ',
                  style: GoogleFonts.manrope(
                    color:
                        Theme.of(context).brightness == Brightness.light
                            ? const Color.fromARGB(186, 2, 28, 114)
                            : Theme.of(context).dialogTheme.backgroundColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                Text(
                  '${widget.cliente.cantidadLlaves}',
                  style: GoogleFonts.manrope(
                    color:
                        Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : const Color.fromARGB(185, 2, 255, 200),
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  '${l10n.funcionan} ',
                  style: GoogleFonts.manrope(
                    color:
                        Theme.of(context).brightness == Brightness.light
                            ? const Color.fromARGB(186, 2, 28, 114)
                            : Theme.of(context).dialogTheme.backgroundColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                Text(
                  widget.cliente.funcionanLlaves! ? l10n.si : l10n.no,
                  style: GoogleFonts.manrope(
                    color:
                        Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : const Color.fromARGB(185, 2, 255, 200),
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      '${l10n.direccion}: ',
                      style: GoogleFonts.manrope(
                        color:
                            Theme.of(context).brightness == Brightness.light
                                ? const Color.fromARGB(186, 2, 28, 114)
                                : Theme.of(context).dialogTheme.backgroundColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: Text(
                        widget.cliente.direccionGoogleMaps,
                        style: GoogleFonts.manrope(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black
                                  : const Color.fromARGB(185, 2, 255, 200),
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    FloatingActionButton.extended(
                      onPressed: () {
                        _abrirDireccion();
                      },
                      label: Text(
                        l10n.abrirEnGoogleMaps,
                        style: GoogleFonts.manrope(
                          color: Theme.of(context).dialogTheme.backgroundColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: const Color.fromARGB(186, 2, 28, 114),
                      icon: Icon(
                        Icons.map_rounded,
                        color: Theme.of(context).dialogTheme.backgroundColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color:
                      Theme.of(context).brightness == Brightness.light
                          ? const Color.fromARGB(186, 2, 28, 114)
                          : Theme.of(context).dialogTheme.backgroundColor!,
                  width: 2.5,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${l10n.cra}: ',
                          style: GoogleFonts.manrope(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? const Color.fromARGB(186, 2, 28, 114)
                                    : Theme.of(
                                      context,
                                    ).dialogTheme.backgroundColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          widget.cliente.cra.nombre,
                          style: GoogleFonts.manrope(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.black
                                    : const Color.fromARGB(185, 2, 255, 200),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${l10n.telefono}: ',
                          style: GoogleFonts.manrope(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? const Color.fromARGB(186, 2, 28, 114)
                                    : Theme.of(
                                      context,
                                    ).dialogTheme.backgroundColor,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                MediaQuery.sizeOf(context).width > 400
                                    ? 20
                                    : 18,
                          ),
                        ),
                        FloatingActionButton.extended(
                          onPressed: () {
                            _hacerLlamada();
                          },
                          backgroundColor: const Color.fromARGB(
                            186,
                            2,
                            28,
                            114,
                          ),
                          foregroundColor: Colors.green,
                          icon: const Icon(Icons.call_rounded),
                          label: Text(
                            '${widget.cliente.cra.telefono}',
                            style: GoogleFonts.manrope(
                              color:
                                  Theme.of(context).dialogTheme.backgroundColor,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.sizeOf(context).width > 400
                                      ? 16
                                      : 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              '${l10n.correoElectronico}: ',
                              style: GoogleFonts.manrope(
                                color:
                                    Theme.of(context).brightness ==
                                            Brightness.light
                                        ? const Color.fromARGB(186, 2, 28, 114)
                                        : Theme.of(
                                          context,
                                        ).dialogTheme.backgroundColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            SizedBox(
                              width: 250,
                              child: Text(
                                widget.cliente.cra.email,
                                style: GoogleFonts.manrope(
                                  color:
                                      Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Colors.black
                                          : const Color.fromARGB(
                                            185,
                                            2,
                                            255,
                                            200,
                                          ),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  backgroundColor: const Color.fromARGB(186, 2, 28, 114),
                  label: Text(
                    l10n.aceptar,
                    style: GoogleFonts.manrope(
                      color: Theme.of(context).dialogTheme.backgroundColor,
                      fontWeight: FontWeight.bold,
                      fontSize:
                          MediaQuery.sizeOf(context).width > 400 ? 24 : 18,
                    ),
                  ),
                ),
                //si el usuario es administrador, saldrá el botón para borrar el cliente
                if (FirebaseAuth.instance.currentUser!.email ==
                    'admin@acudakeys.com')
                  FloatingActionButton.extended(
                    onPressed:
                        () => showDialog(
                          context: context,
                          builder:
                              (context) => AlertDialog(
                                backgroundColor:
                                    Theme.of(
                                      context,
                                    ).dialogTheme.backgroundColor,
                                title: Text(
                                  l10n.eliminar,
                                  style: GoogleFonts.manrope(
                                    color: const Color.fromARGB(
                                      186,
                                      2,
                                      28,
                                      114,
                                    ),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                ),
                                content: Text(
                                  '${l10n.confirmacionEliminar} ${widget.cliente.nombreCliente}?',
                                  style: GoogleFonts.manrope(
                                    color: const Color.fromARGB(
                                      186,
                                      2,
                                      28,
                                      114,
                                    ),
                                    fontSize: 17,
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed:
                                        () => Navigator.pop(context, l10n.no),
                                    child: Text(
                                      l10n.no,
                                      style: GoogleFonts.manrope(
                                        color: const Color.fromARGB(
                                          186,
                                          2,
                                          28,
                                          114,
                                        ),
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, 'Sí');
                                      ref
                                          .read(
                                            llaveControllerProvider.notifier,
                                          )
                                          .borrarCliente(widget.cliente);
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Sí',
                                      style: GoogleFonts.manrope(
                                        color: const Color.fromARGB(
                                          186,
                                          2,
                                          28,
                                          114,
                                        ),
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        ),
                    backgroundColor: const Color.fromARGB(186, 2, 28, 114),
                    label: Text(
                      l10n.eliminar,
                      style: GoogleFonts.manrope(
                        color: Theme.of(context).dialogTheme.backgroundColor,
                        fontWeight: FontWeight.bold,
                        fontSize:
                            MediaQuery.sizeOf(context).width > 400 ? 24 : 18,
                      ),
                    ),
                    icon: const Icon(
                      Icons.delete_forever_rounded,
                      color: Colors.red,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

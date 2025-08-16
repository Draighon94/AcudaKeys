// ignore_for_file: use_build_context_synchronously

import 'package:acuda_keys/l10n/app_localizations.dart';
import 'package:acuda_keys/models/central_receptora_alarmas.dart';
import 'package:acuda_keys/providers/idioma_actual_controller.dart';
import 'package:acuda_keys/providers/parte_pdf_controller.dart';
import 'package:acuda_keys/providers/realizar_parte_controller.dart';
import 'package:acuda_keys/widgets/desplegable_cras.dart';
import 'package:acuda_keys/widgets/parte_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class EnviarParteView extends ConsumerStatefulWidget {
  const EnviarParteView({super.key});

  @override
  ConsumerState<EnviarParteView> createState() {
    return _SubirParteViewState();
  }
}

class _SubirParteViewState extends ConsumerState<EnviarParteView> {
  String? ruta;
  bool isCargando = false;
  bool isEnviando = false;
  CentralReceptoraAlarmas? cra;
  late Widget pdfPreview = SizedBox(
    height: 380,
    width: 300,
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(186, 2, 28, 114)),
      ),
      child: Center(
        child: Text(
          ref.watch(idiomaActualControllerProvider) == const Locale('es')
              ? 'Selecciona un fichero pdf para previsualizarlo'
              : 'Select a pdf file to preview',
          style: GoogleFonts.manrope(
            color:
                Theme.of(context).brightness == Brightness.light
                    ? Theme.of(context).dialogTheme.backgroundColor
                    : const Color.fromARGB(185, 2, 255, 200),
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );

  //metodo para previsualizar el PDF
  Future<void> _previsualizarPDF() async {
    setState(() {
      isCargando = true;
    });

    //llamamos al metodo del provider que almacena la logica de previsualizar el parte
    ruta = await ref.read(partePDFControllerProvider.notifier).cargarParte();
    if (ruta != '') {
      pdfPreview = SizedBox(
        height: 380,
        width: 300,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(186, 2, 28, 114)),
          ),
          child: PartePdfViewer(filePath: ruta!),
        ),
      );
    }

    setState(() {
      isCargando = false;
    });
  }

  //metodo para enviar el parte
  Future<void> _enviarParte(WidgetRef ref, AppLocalizations l10n) async {
    //obtenemos la direccion de correo electronico de la CRA
    String direccionDestino =
        ref.read(realizarParteControllerProvider.notifier).obtenerEmailCRA();
    //obtenemos el nombre del cliente
    String nombreCliente = _obtenernombreCliente();

    //si la ruta del fichero no está vacía, enviamos el documento
    if (ruta != null) {
      setState(() {
        isEnviando = true;
      });
      //lamamos la metodo que contiene la logica para enviar el parte
      int codigoSubida = await ref
          .read(partePDFControllerProvider.notifier)
          .enviarParte(
            destino: direccionDestino,
            nombreCliente: nombreCliente,
            rutaParte: ruta!,
          );
      //en funcion del codigo de salida, informamos al usuario de la situacion
      if (codigoSubida == 0) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color.fromARGB(150, 60, 60, 60),
            content: Text(
              l10n.parteEnviado,
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
      } else if (codigoSubida == -1) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color.fromARGB(150, 60, 60, 60),
            content: Text(
              l10n.errorEnvio,
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
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color.fromARGB(150, 60, 60, 60),
          content: Text(
            l10n.rutaNoSeleccionada,
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
      isEnviando = false;
    });
  }

  //metodo para obtener el nombre del cliente
  String _obtenernombreCliente() {
    String nombre = '';
    //obtenemos el nombre del cliente separado por _
    List<String> palabrasRuta = ruta!.split('_');

    for (var i = 5; i < palabrasRuta.length; i++) {
      nombre = '$nombre ${palabrasRuta[i]} ';
    }
    return nombre.replaceAll('.pdf', '').trim();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          l10n.enviarParte,
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
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.sizeOf(context).width > 400 ? 0 : 80,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton.extended(
                    onPressed: () {
                      _previsualizarPDF();
                    },
                    label: Text(
                      l10n.seleccionarParte,
                      style: GoogleFonts.manrope(
                        color: Theme.of(context).dialogTheme.backgroundColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    backgroundColor: const Color.fromARGB(186, 2, 28, 114),
                    icon: Icon(
                      Icons.add_link_rounded,
                      color: Theme.of(context).dialogTheme.backgroundColor,
                    ),
                  ),
                  const SizedBox(height: 10),

                  if (isCargando)
                    SizedBox(
                      height: 380,
                      width: 300,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).dialogTheme.backgroundColor,
                        ),
                      ),
                    ),
                  if (!isCargando) pdfPreview,
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal:
                          MediaQuery.sizeOf(context).width > 400 ? 80 : 50,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${l10n.enviarA}:',
                          style: GoogleFonts.manrope(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? const Color.fromARGB(200, 2, 28, 114)
                                    : const Color.fromARGB(185, 2, 255, 200),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const DesplegableCRAs(),
                      ],
                    ),
                  ),
                  if (!isEnviando)
                    FloatingActionButton.extended(
                      onPressed: () {
                        _enviarParte(ref, l10n);
                      },
                      label: Text(
                        l10n.enviarParte,
                        style: GoogleFonts.manrope(
                          color: Theme.of(context).dialogTheme.backgroundColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      backgroundColor: const Color.fromARGB(186, 2, 28, 114),
                      icon: Icon(
                        Icons.send_rounded,
                        color: Theme.of(context).dialogTheme.backgroundColor,
                      ),
                    ),
                  if (isEnviando)
                    const CircularProgressIndicator(
                      color: Color.fromARGB(186, 2, 28, 114),
                    ),

                  const SizedBox(height: 25),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

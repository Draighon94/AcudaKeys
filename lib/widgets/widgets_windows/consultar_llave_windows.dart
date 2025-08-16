import 'dart:io';

import 'package:acuda_keys/l10n/app_localizations.dart';
import 'package:acuda_keys/models/cliente.dart';
import 'package:acuda_keys/providers/llave_controller.dart';
import 'package:acuda_keys/widgets/filtro.dart';
import 'package:acuda_keys/widgets/llave_list_item.dart';
import 'package:acuda_keys/widgets/widgets_windows/cliente_info_windows.dart';
import 'package:acuda_keys/widgets/widgets_windows/filtro_clientes_windows.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ConsultarLlaveViewWindows extends ConsumerStatefulWidget {
  const ConsultarLlaveViewWindows({super.key});

  @override
  ConsumerState<ConsultarLlaveViewWindows> createState() {
    return _ConsultarLlaveViewState();
  }
}

class _ConsultarLlaveViewState
    extends ConsumerState<ConsultarLlaveViewWindows> {
  //metodo que muestra la hoja modal con los datos de cliente
  void _verInfo(BuildContext context, Cliente cliente) {
    showModalBottomSheet(
      useSafeArea: true, //lanza la hoja modal sin llegar a la barra de estado
      shape: RoundedRectangleBorder(
        side: BorderSide(
          strokeAlign: BorderSide.strokeAlignOutside,
          color:
              Theme.of(context).brightness == Brightness.light
                  ? const Color.fromARGB(200, 2, 28, 114)
                  : const Color.fromARGB(185, 2, 255, 200),
          width: 8,
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true, //para que no se solape el teclado con widgets
      backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
      context: context,
      builder:
          (ctx) => Padding(
            padding: const EdgeInsets.all(50),
            child: SizedBox(
              width: double.infinity,
              child: ClienteInfoWindows(cliente: cliente),
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    var listaClientes = ref.watch(llaveControllerProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          l10n.consultarLlaves,
          style: GoogleFonts.manrope(
            color: Theme.of(context).dialogTheme.backgroundColor,
            fontSize: MediaQuery.sizeOf(context).width > 400 ? 25 : 22,
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
        iconTheme: IconThemeData(
          color: Theme.of(context).dialogTheme.backgroundColor,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                l10n.volver,
                style: GoogleFonts.manrope(
                  color: Theme.of(context).dialogTheme.backgroundColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(200, 255, 255, 255),
        child: Center(
          child:
              Platform.isAndroid
                  ? const Filtro()
                  : const FiltroClientesWindows(),
        ),
      ),
      body:
          listaClientes.isNotEmpty
              ? Container(
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
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 50,
                    left: 25,
                    right: 25,
                    bottom: 25,
                  ),
                  child: GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                    childAspectRatio: 285 / 100,
                    children: [
                      for (var i = 0; i < listaClientes.length; i++)
                        GestureDetector(
                          onTap: () {
                            _verInfo(context, listaClientes[i]);
                          },
                          child: LlaveListItem(cliente: listaClientes[i]),
                        ),
                    ],
                  ),
                ),
              )
              : Container(
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
                      left: 40,
                      top: 100,
                      right: 40,
                      bottom: MediaQuery.sizeOf(context).width > 400 ? 25 : 100,
                    ),
                    child: CircularProgressIndicator(
                      color: Theme.of(context).dialogTheme.backgroundColor,
                    ),
                  ),
                ),
              ),
    );
  }
}

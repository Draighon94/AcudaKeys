import 'dart:io';

import 'package:acuda_keys/models/cliente.dart';
import 'package:acuda_keys/widgets/cliente_info.dart';
import 'package:acuda_keys/widgets/llave_list_item.dart';
import 'package:acuda_keys/widgets/widgets_windows/cliente_info_windows.dart';
import 'package:flutter/material.dart';

class ListaLlaves extends StatelessWidget {
  const ListaLlaves({super.key, required this.listaClientes});

  final List<Cliente> listaClientes;

  //metodo que muestra la hoja modal con la informacion del cliente
  void verInfo(BuildContext context, Cliente cliente) {
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
        borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
      ),
      isScrollControlled: true, //para que no se solape el teclado con widgets
      backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
      context: context,
      builder:
          (ctx) => Padding(
            padding: const EdgeInsets.all(50),
            child: SizedBox(
              width: double.infinity,
              child:
                  Platform.isAndroid
                      ? ClienteInfo(cliente: cliente)
                      : ClienteInfoWindows(cliente: cliente),
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < listaClientes.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: GestureDetector(
                onTap: () {
                  verInfo(context, listaClientes[i]);
                },
                child: LlaveListItem(cliente: listaClientes[i]),
              ),
            ),
        ],
      ),
    );
  }
}

import 'package:acuda_keys/l10n/app_localizations.dart';
import 'package:acuda_keys/models/cliente.dart';
import 'package:acuda_keys/providers/llave_controller.dart';
import 'package:acuda_keys/providers/realizar_parte_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class DesplegableClientes extends ConsumerStatefulWidget {
  const DesplegableClientes({super.key});

  @override
  ConsumerState<DesplegableClientes> createState() {
    return _DesplegableClientesState();
  }
}

class _DesplegableClientesState extends ConsumerState<DesplegableClientes> {
  Cliente? _clienteSeleccionado;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    Map<String, TextEditingController> controladores = ref.watch(
      realizarParteControllerProvider,
    );
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).dialogTheme.backgroundColor,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 2),
        child: DropdownButton(
          dropdownColor: Theme.of(context).dialogTheme.backgroundColor,
          hint: Text(
            l10n.cliente,
            style: GoogleFonts.manrope(
              color: const Color.fromARGB(200, 2, 28, 114),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          icon: const Icon(Icons.abc, color: Colors.transparent),
          borderRadius: BorderRadius.circular(15),
          underline: Container(
            decoration: const BoxDecoration(color: Colors.transparent),
          ),
          style: GoogleFonts.manrope(
            color: const Color.fromARGB(200, 2, 28, 114),
            fontWeight: FontWeight.bold,
          ),
          value: _clienteSeleccionado,
          items:
              ref.watch(llaveControllerProvider).map((Cliente cliente) {
                return DropdownMenuItem<Cliente>(
                  value: cliente,
                  child: Text(
                    cliente.nombreCliente,
                    style: GoogleFonts.manrope(
                      color: const Color.fromARGB(200, 2, 28, 114),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                );
              }).toList(),
          onChanged: (Cliente? cliente) {
            setState(() {
              _clienteSeleccionado = cliente;
              controladores['nombreClienteController']!.text =
                  cliente!.nombreCliente;
              controladores['direccionClienteController']!.text =
                  cliente.direccionGoogleMaps;
              controladores['nombreCRAController']!.text = cliente.cra.nombre;
            });
          },
        ),
      ),
    );
  }
}

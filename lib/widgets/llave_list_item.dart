import 'dart:io';

import 'package:acuda_keys/l10n/app_localizations.dart';
import 'package:acuda_keys/models/cliente.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LlaveListItem extends StatelessWidget {
  const LlaveListItem({super.key, required this.cliente});

  final Cliente cliente;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      height: 100,
      width: Platform.isAndroid ? double.infinity : 350,
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(186, 2, 28, 114)),
        borderRadius: BorderRadius.circular(15),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              cliente.nombreCliente,
              style: GoogleFonts.manrope(
                color: Theme.of(context).dialogTheme.backgroundColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${l10n.codigoDeLlave}: ',
                  style: GoogleFonts.manrope(
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  cliente.codLlave,
                  style: GoogleFonts.manrope(
                    color: Theme.of(context).dialogTheme.backgroundColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

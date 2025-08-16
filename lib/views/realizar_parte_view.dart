import 'dart:io';

import 'package:acuda_keys/l10n/app_localizations.dart';
import 'package:acuda_keys/widgets/widgets_parte/formulario_parte.dart';
import 'package:acuda_keys/widgets/widgets_windows/formulario_parte_windows.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class RealizarParteView extends ConsumerWidget {
  const RealizarParteView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          l10n.realizarParte,
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
              top: Platform.isAndroid ? 110 : 60,
              bottom: Platform.isAndroid ? 0 : 25,
            ),
            child:
                Platform.isAndroid
                    ? const FormularioParte()
                    : const FormularioParteWindows(),
          ),
        ),
      ),
    );
  }
}

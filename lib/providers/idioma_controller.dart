import 'dart:ui';

import 'package:acuda_keys/l10n/app_localizations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'idioma_controller.g.dart';

//provider que contiene la lista de idiomas soportados
@riverpod
class IdiomaController extends _$IdiomaController {
  @override
  List<Locale> build() {
    return AppLocalizations.supportedLocales;
  }
}

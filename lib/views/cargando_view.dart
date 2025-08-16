import 'package:flutter/material.dart';

class CargandoView extends StatelessWidget {
  const CargandoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        width: double.infinity,
        child: Center(
          //la pantalla consiste en un una rueda de carga
          child: CircularProgressIndicator(
            color: Theme.of(context).dialogTheme.backgroundColor,
          ),
        ),
      ),
    );
  }
}

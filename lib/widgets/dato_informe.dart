import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DatoInforme extends StatelessWidget {
  const DatoInforme({super.key, required this.dato, required this.valor});

  final String dato;
  final String valor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Container(
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
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width > 400 ? 320 : 250,
                      child: Text(
                        dato,
                        style: GoogleFonts.manrope(
                          color: Theme.of(context).dialogTheme.backgroundColor,
                          fontWeight: FontWeight.bold,
                          fontSize:
                              MediaQuery.sizeOf(context).width > 400 ? 20 : 16,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      valor,
                      style: GoogleFonts.manrope(
                        color:
                            Theme.of(context).brightness == Brightness.light
                                ? const Color.fromARGB(186, 2, 28, 114)
                                : const Color.fromARGB(185, 2, 255, 200),
                        fontWeight: FontWeight.bold,
                        fontSize:
                            MediaQuery.sizeOf(context).width > 4000 ? 20 : 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

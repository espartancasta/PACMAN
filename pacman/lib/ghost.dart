import 'package:flutter/material.dart';

class MyGhost extends StatelessWidget {
  MyGhost({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Image.asset(
          'lib/images/ghost.png'), // Asegúrate de que la imagen esté en la ruta correcta
    );
  }
}

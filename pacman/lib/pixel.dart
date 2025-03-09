import 'package:flutter/material.dart';

class MyPixel extends StatelessWidget {
  final innerColor;
  final outerColor;
  final child;

  MyPixel({this.innerColor, this.outerColor, this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(1.0),
        child: ClipRRect(
          borderRadius:
              BorderRadius.circular(10), // Ajuste correcto del borde redondeado
          child: Container(
            padding: const EdgeInsets.all(12),
            color: outerColor, // Se usa el color exterior
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: innerColor,
                child: Center(child: child),
              ),
            ),
          ),
        ));
  }
}

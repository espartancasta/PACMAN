import 'package:flutter/material.dart';

class MyPath extends StatelessWidget {
  final innerColor;
  final outerColor;
  final child;

  MyPath({this.innerColor, this.outerColor, this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Container(
          padding: EdgeInsets.all(17),
          color: outerColor, // Se usa el color exterior
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              color: innerColor, // Se usa el color interior
              child: Center(
                child: child, // Se coloca el widget hijo
              ),
            ),
          ),
        ),
      ),
    );
  }
}

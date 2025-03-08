import 'package:flutter/material.dart';

class MyPixel extends StatelessWidget {
  final color;
  final child;

  const MyPixel({this.color, this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        color: Colors.blue,
        child: Center(child: child),
      ),
    );
  }
}

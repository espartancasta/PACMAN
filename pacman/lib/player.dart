import 'package:flutter/material.dart';

class MyPlayer extends StatelessWidget {
  MyPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Image.asset('lib/images/pacman.png'),
    );
  }
}

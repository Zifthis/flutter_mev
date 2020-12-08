import 'package:flutter/material.dart';
import 'package:flutter_mev/view/main_screen.dart';

void main() {
  runApp(MevApp());
}

class MevApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}

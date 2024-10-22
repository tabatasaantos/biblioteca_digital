import 'package:flutter/material.dart';

void main() {
  runApp(const BiliotecaDigital());
}

class BiliotecaDigital extends StatelessWidget {
  const BiliotecaDigital({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Biblioteca Digital",
      theme: ThemeData.dark(useMaterial3: true),
      home: Container(),
    );
  }
}

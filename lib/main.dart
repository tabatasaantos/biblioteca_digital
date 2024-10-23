import 'package:biblioteca_digital/pages/widgets/dashboard_widget_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BiliotecaDigital());
}

class BiliotecaDigital extends StatelessWidget {
  const BiliotecaDigital({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Biblioteca Digital",
      theme: ThemeData.dark(useMaterial3: true),
      home: const DashboardPage(),
    );
  }
}

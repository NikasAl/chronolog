import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'presentation/screens/dashboard_screen.dart';

void main() {
  runApp(const ChronoLogApp());
}

class ChronoLogApp extends StatelessWidget {
  const ChronoLogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChronoLog',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const DashboardScreen(), // Сразу зовем новый экран
    );
  }
}
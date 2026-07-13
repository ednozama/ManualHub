import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const ManualHubApp());
}

class ManualHubApp extends StatelessWidget {
  const ManualHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Manual Hub',
      theme: AppTheme.darkTheme,
      home: const SplashScreen(),
    );
  }
}
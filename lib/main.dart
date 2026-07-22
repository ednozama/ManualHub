import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';
import 'services/storage_service.dart';
import 'theme/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await StorageService.init();

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
      localizationsDelegates: const [
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
],

supportedLocales: const [
  Locale('de'),
  Locale('en'),
],
      home: const SplashScreen(),
    );
  }
}
import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'theme/theme.dart';
import 'theme/util.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _selectedLanguageCode = 'es';
  String _selectedLanguageLabel = 'Español';
  ThemeMode _themeMode = ThemeMode.light;

  void _updateLanguage(String code, String label) {
    setState(() {
      _selectedLanguageCode = code;
      _selectedLanguageLabel = label;
    });
  }

  void _updateThemeMode(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Crear el TextTheme usando las utilidades del proyecto con Press Start 2P
    final textTheme = createTextTheme(
      context,
      'Press Start 2P',
      'Press Start 2P',
    );

    // Crear la instancia de MaterialTheme con el TextTheme personalizado
    final materialTheme = MaterialTheme(textTheme);

    return MaterialApp(
      title: 'PokeApp',
      theme: materialTheme.light().copyWith(
        textTheme: textTheme,
        primaryTextTheme: textTheme,
      ),
      darkTheme: materialTheme.dark().copyWith(
        textTheme: textTheme,
        primaryTextTheme: textTheme,
      ),
      themeMode: _themeMode,
      home: HomePage(
        selectedLanguageCode: _selectedLanguageCode,
        selectedLanguageLabel: _selectedLanguageLabel,
        selectedThemeMode: _themeMode,
        onLanguageChanged: _updateLanguage,
        onThemeModeChanged: _updateThemeMode,
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const BeatStarsCloneApp());
}

class BeatStarsCloneApp extends StatelessWidget {
  const BeatStarsCloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BeatStars Clone',
      debugShowCheckedModeBanner: false,
      // Configuración del Tema Oscuro por defecto
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212), // Fondo negro/gris oscuro
        primaryColor: const Color(0xFFE50914), // Rojo BeatStars / acento
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFE50914),
          secondary: Color(0xFF1DB954), // Detalles o botones de reproducción
          surface: Color(0xFF1E1E1E), // Tarjetas y contenedores
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF121212),
          elevation: 0,
        ),
      ),
      home: const Scaffold(
        body: Center(
          child: Text('Bienvenido al Clon de BeatStars'),
        ),
      ),
    );
  }
}
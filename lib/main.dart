import 'package:flutter/material.dart';
import 'screens/main_navigation.dart';

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
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: const Color(0xFFE50914),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFE50914),
          secondary: Color(0xFF1DB954),
          surface: Color(0xFF1E1E1E),
        ),
      ),
      home: const MainNavigation(),
    );
  }
}
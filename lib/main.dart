// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_notifier.dart';
import 'flashscreen.dart';
import 'text_to_speech.dart'; // Import TextToSpeech here
import 'package:flutter_gemini/flutter_gemini.dart'; // Import Gemini package

// Define your API key here
const String GEMINI_API_KEY = 'AIzaSyAmzhfCjNRiQoxUh-e-uyG5B9bC1Ebf-2A';

void main() {
  // Initialize the Gemini instance
  Gemini.init(apiKey: GEMINI_API_KEY);

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(ThemeData.light()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mirai',
      theme: Provider.of<ThemeNotifier>(context).themeData,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

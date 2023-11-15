import 'package:flutter/material.dart';

import 'language_translator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Language Translator App',
      debugShowCheckedModeBanner: false,
      home: LanguageTranslatorPage(),
    );
  }
}

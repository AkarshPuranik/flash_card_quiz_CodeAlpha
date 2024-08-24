import 'package:flashcard_quiz_app/screens/homescreen.dart';
import 'package:flashcard_quiz_app/screens/score.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FlashcardProvider(),
      child: FlashcardQuizApp(),
    ),
  );
}

class FlashcardQuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashcard Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: TextTheme(
          displayLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.green),
          bodyLarge: TextStyle(fontSize: 18.0, color: Colors.black),
        ),
      ),
      home: HomeScreen(),
    );
  }
}

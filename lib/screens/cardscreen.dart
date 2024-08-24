import 'package:flashcard_quiz_app/screens/score.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class FlashcardScreen extends StatelessWidget {
  final _questionController = TextEditingController();
  final _answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Flashcards'),
        backgroundColor: Colors.white, // AppBar color
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade700, Colors.blue.shade900],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedTextField(
                controller: _questionController,
                labelText: 'Question',
              ),
              SizedBox(height: 16.0),
              AnimatedTextField(
                controller: _answerController,
                labelText: 'Answer',
              ),
              SizedBox(height: 32.0),
              AnimatedButton(
                onPressed: () {
                  if (_questionController.text.isNotEmpty && _answerController.text.isNotEmpty) {
                    Provider.of<FlashcardProvider>(context, listen: false)
                        .addFlashcard(_questionController.text, _answerController.text);
                    _questionController.clear();
                    _answerController.clear();
                  }
                },
                text: 'Add Flashcard',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;

  AnimatedTextField({required this.controller, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class AnimatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  AnimatedButton({required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
class Flashcard {
  final String question;
  final String answer;

  Flashcard({required this.question, required this.answer});
}

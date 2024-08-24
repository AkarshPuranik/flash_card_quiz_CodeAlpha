import 'package:flashcard_quiz_app/screens/score.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'homescreen.dart';

class ScoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final score = Provider.of<FlashcardProvider>(context, listen: false).score;
    final total = Provider.of<FlashcardProvider>(context, listen: false).flashcards.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Score'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You scored:',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 16.0),
            Text(
              '$score / $total',
              style: TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                Provider.of<FlashcardProvider>(context, listen: false).resetScore();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                      (route) => false,
                );
              },
              child: Text('Return to Home'),
            ),
          ],
        ),
      ),
    );
  }
}

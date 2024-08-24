import 'package:flashcard_quiz_app/screens/cardscreen.dart';
import 'package:flashcard_quiz_app/screens/scorescreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'score.dart'; // Assuming this is a screen to display the final score

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  final TextEditingController _answerController = TextEditingController();
  bool _hasSubmitted = false;
  bool _isCorrect = false;

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
        backgroundColor: Colors.white, // Optional: Set the AppBar color
      ),
      body: Container(
        color: Colors.blue.shade800, // Set the background color
        child: Consumer<FlashcardProvider>(
          builder: (context, provider, child) {
            if (provider.flashcards.isEmpty) {
              return Center(
                child: Text(
                  'No flashcards available.',
                  style: TextStyle(color: Colors.white), // Ensure text is visible
                ),
              );
            }

            final flashcard = provider.flashcards[_currentIndex];

            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    flashcard.question,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white), // Ensure text is visible
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24.0),
                  TextField(
                    controller: _answerController,
                    decoration: InputDecoration(
                      labelText: 'Your Answer',
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(color: Colors.white), // Ensure label text is visible
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: TextStyle(color: Colors.white), // Ensure input text is visible
                    onSubmitted: (_) => _submitAnswer(provider, flashcard),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () => _submitAnswer(provider, flashcard),
                    child: Text('Submit'),
                  ),
                  SizedBox(height: 24.0),
                  if (_hasSubmitted)
                    Column(
                      children: [
                        Text(
                          _isCorrect ? 'Correct!' : 'Incorrect.',
                          style: TextStyle(
                            color: _isCorrect ? Colors.green : Colors.red,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Correct Answer: ${flashcard.answer}',
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () => _nextFlashcard(provider),
                          child: Text('Next'),
                        ),
                      ],
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _submitAnswer(FlashcardProvider provider, Flashcard flashcard) {
    final userAnswer = _answerController.text.trim().toLowerCase();
    final correctAnswer = flashcard.answer.trim().toLowerCase();

    setState(() {
      _hasSubmitted = true;
      _isCorrect = userAnswer == correctAnswer;
      if (_isCorrect) {
        provider.incrementScore();
      }
    });

    // Optionally, show a Snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isCorrect ? 'Correct!' : 'Incorrect.'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _nextFlashcard(FlashcardProvider provider) {
    setState(() {
      _hasSubmitted = false;
      _isCorrect = false;
      _answerController.clear();
      if (_currentIndex < provider.flashcards.length - 1) {
        _currentIndex++;
      } else {
        // Optionally, navigate to a score screen or show a completion dialog
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ScoreScreen()),
        );
        return;
      }
    });
  }
}

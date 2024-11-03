import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class ResultsPage extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final ConfettiController _confettiController = ConfettiController(duration: const Duration(seconds: 3));

  ResultsPage({super.key, required this.score, required this.totalQuestions}) {
    _confettiController.play();
  }

  @override
  Widget build(BuildContext context) {
    double percentage = (score / totalQuestions) * 100;
    String feedbackText;
    if (percentage >= 80) {
      feedbackText = "Excellent!";
    } else if (percentage >= 50) {
      feedbackText = "Good Job!";
    } else {
      feedbackText = "Keep Trying!";
    }

    return Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Your Score:',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '$score / $totalQuestions',
                    style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    feedbackText,
                    style: const TextStyle(fontSize: 24, color: Colors.green),
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {
                      _confettiController.stop();
                      Navigator.pop(context);
                    },
                    child: const Text('Back to Home'),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [Colors.green, Colors.blue, Colors.pink, Colors.orange, Colors.purple],
            ),
          ),
        ],
      );
 
  }
}

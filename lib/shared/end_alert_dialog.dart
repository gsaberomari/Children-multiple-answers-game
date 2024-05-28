import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class EndCorrectIncorrectAlertDialog extends StatelessWidget {
  EndCorrectIncorrectAlertDialog(
      {super.key,
      required this.isEnd,
      this.isCorrect,
      required this.player,
      this.next});
  final bool isEnd;
  final bool? isCorrect;

  final VoidCallback? next;
  final AudioPlayer player;

  @override
  Widget build(BuildContext context) {
    if (isEnd) {
      return const AlertDialog(
        content: Text(
          'GOOD JOB   \u{1F44D}',
          style: TextStyle(color: Color.fromARGB(255, 5, 0, 0), fontSize: 50),
        ),
        surfaceTintColor: Colors.amberAccent,
        // backgroundColor: Color.fromARGB(255, 26, 179, 6),
        shadowColor: Color.fromARGB(255, 253, 253, 253),
      );
    } else {
      if (isCorrect!) {
        player.play(AssetSource('sounds/correct.mp3'));
        return AlertDialog(
          surfaceTintColor: Colors.amber,
          content: const Text(
            'Correct',
            style: TextStyle(
                color: Color.fromARGB(255, 5, 0, 0),
                fontWeight: FontWeight.bold,
                fontSize: 30),
          ),
          backgroundColor: Colors.green,
          shadowColor: const Color.fromARGB(255, 235, 216, 216),
          actions: [
            ElevatedButton.icon(
                label: const Text("Next"),
                onPressed: () {
                  next?.call();
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_forward))
          ],
        );
      } else {
        player.play(AssetSource('sounds/wrong.mp3'));
        return AlertDialog(
            content: const Text(
              'Incorrect! Try again.',
              style:
                  TextStyle(color: Color.fromARGB(255, 5, 0, 0), fontSize: 30),
            ),
            backgroundColor: const Color.fromARGB(255, 241, 85, 85),
            shadowColor: const Color.fromARGB(255, 235, 216, 216),
            actions: [
              // SizedBox(width: 80),
              ElevatedButton.icon(
                  label: const Text("Next"),
                  onPressed: () {
                    next?.call();
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_forward))
            ]);
      }
    }
  }

  
}

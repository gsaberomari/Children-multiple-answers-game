import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../shared/result_page.dart';
import '../manage_questions/questions_manager.dart';
import '../shared/end_alert_dialog.dart';

class MathematicsPage extends StatefulWidget {
  final bool sourecFile;

  const MathematicsPage({super.key, required this.sourecFile});
  @override
  _MathematicsPageState createState() => _MathematicsPageState();
}

class _MathematicsPageState extends State<MathematicsPage> {
  int _questionIndex = 0;
  int attempts = 3;
  bool isLoading = true;
  int score = 0;
  late AudioPlayer player;

  List<Map<String, dynamic>> _questions = [];

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    loadMathQuestions();
  }

  void loadMathQuestions() async {
    _questions = await AppQuestions.getMathQuestions(widget.sourecFile);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mathmatics'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    'assets/background/math.jpg',
                  ),
                ),
              ),
              child: Center(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: _questionIndex < _questions.length
                          ? buildQuestion(context)
                          : ResultsPage(
                              score: score,
                              totalQuestions: _questions.length))),
            ),
    );
  }

  Widget equationImages(String question, String image) {
    RegExp regExp = RegExp(r'(\d+)\s*([+\-*/])\s*(\d+)');

    Iterable<RegExpMatch> matches = regExp.allMatches(question);

    List<String>? operands = [];
    for (RegExpMatch match in matches) {
      String operand1 = match.group(1)!;
      String operator = match.group(2)!;
      String operand2 = match.group(3)!;

      operands.addAll([operand1, operator, operand2]);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ImagesOfOperand(image: image, operand: operands[0]),
        Expanded(
          child: SizedBox(
            width: 100,
            height: 150,
            child: Transform.translate(
              offset: const Offset(7, 0),
              child: Text(
                ' ${operands[1]}',
                style: const TextStyle(fontSize: 70),
              ),
            ),
          ),
        ),
        ImagesOfOperand(image: image, operand: operands[2]),
      ],
    );
  }

  Widget buildQuestion(BuildContext context) {
    Map<String, dynamic> questionData = _questions[_questionIndex];
    String question = questionData['question'];
    List<String> options = List<String>.from(questionData['options']);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          equationImages(question, questionData['image']),
          Text(
            question,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          for (String option in options)
            ElevatedButton(
              onPressed: () {
                _checkAnswer(option);
              },
              child: Text(option),
            ),
        ],
      ),
    );
  }

  void goToNextQuestion() {
    player.release();
    setState(() {
      _questionIndex++;
    });
  }

  void _checkAnswer(String selectedAnswer) {
    // CORRECT ANSWER
    if (selectedAnswer == _questions[_questionIndex]['correctAnswer']) {
      score++;
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return EndCorrectIncorrectAlertDialog(
                isEnd: false,
                isCorrect: true,
                player: player,
                next: goToNextQuestion);
          });
    } else {
      showDialog(
          // WRONG ANSWER
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return EndCorrectIncorrectAlertDialog(
                isEnd: false,
                isCorrect: false,
                player: player,
                next: goToNextQuestion);
          });
    }
  }
}

class ImagesOfOperand extends StatelessWidget {
  const ImagesOfOperand(
      {super.key, required this.operand, required this.image});
  final String operand;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: 100,
        height: 200,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 0.5,
            mainAxisSpacing: 1,
          ),
          itemCount: int.parse(operand),
          itemBuilder: (context, index) {
            return SizedBox(
              width: 20,
              height: 20,
              child: image.startsWith('assets/')
                  ? Image.asset(
                      image,
                      fit: BoxFit.fill,
                    )
                  : Image.file(
                      File(image),
                      fit: BoxFit.fill,
                    ),
            );
          },
        ),
      ),
    );
  }
}

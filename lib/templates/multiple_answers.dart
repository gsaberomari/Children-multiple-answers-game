import 'dart:io';


import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'package:my_code/shared/end_alert_dialog.dart';
import 'package:my_code/manage_questions/questions_manager.dart';

import '../shared/result_page.dart';

class QuestionsTemplate extends StatefulWidget {
const  QuestionsTemplate({super.key,required this.sourecFile, required this.title, required this.backgroundImage, required this.topic});
final bool sourecFile;
final String title;
final String backgroundImage;
final String topic;
  @override
  QuestionsTemplateState createState() => QuestionsTemplateState();
}

class QuestionsTemplateState extends State<QuestionsTemplate> {
  int _questionIndex = 0;

  bool isLoading=true;
 int score=0;   

  List<Map<String, dynamic>> _questions = [];
 

 late AudioPlayer player;

 @override
void initState() {
  super.initState();
   player = AudioPlayer();
  loadQuestions();
  
}

void loadQuestions() async {

  switch (widget.topic) {
    case 'Arabic':
       _questions = await AppQuestions.getArabicQuestions(widget.sourecFile);
      break;
      case 'English':
       _questions = await AppQuestions.getEnglishQuestions(widget.sourecFile);
      break;
    default:
  }
   
    setState(() {
      isLoading=false;
    });
   
  
}

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:isLoading?const Center(child: CircularProgressIndicator()) : Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(
             widget.backgroundImage),
        )),
        child: Center(
            child: _questionIndex < _questions.length
                ? _buildQuestion(_questions[_questionIndex])
                : ResultsPage(score: score, totalQuestions: _questions.length) 
               ),
      ),
    );
  }

  bool isNetworkImage(String imageUrl) {
  Uri uri = Uri.tryParse(imageUrl)!; 

  
  return uri.scheme == 'http' || uri.scheme == 'https';
}

  Widget _buildQuestion(Map<String, dynamic> questionData) {
   //  precacheImage(cachePictures[_questionIndex], context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
       
        Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: LimitedBox(
              maxHeight: 150,
              maxWidth: 150,  //cachePictures[_questionIndex]
              child: 
              isNetworkImage(questionData['image'])?  ///
              Image.network(
                questionData['image'],
                fit: BoxFit.fill,
              ):Image.file(File(
                questionData['image']),
                fit: BoxFit.fill,
              )),
        ),
        Text(
          questionData['question'],
          style:const TextStyle(fontSize: 20),
        ),
      const  SizedBox(height: 20),
        ...(questionData['options']).map((option) {
          return ElevatedButton(
            onPressed: () {
              _checkAnswer(option);
            },
            child: Text(option),
          );
        }).toList(),
      ],
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
                isEnd: false, isCorrect: false,player: player, next: goToNextQuestion);
          });
    
    }
  }
}

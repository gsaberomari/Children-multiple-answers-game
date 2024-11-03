

import 'package:flutter/material.dart';

import '../game_engine/game_engine.dart';



class TeacherScreen extends StatelessWidget {
  const TeacherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher Page'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(.0),
        child: Center(
          child: Column(
            children: [
              Text(
                'Choose Subject :',
                style: TextStyle(fontSize: 30),
              ),

              HomeButton(
                  buttonColor: [255, 126, 33, 9],
                  edge: [8.0, 170, 8.0, 0],
                  text: 'Mathmatics',
                  textColor: Colors.black,
                  topicName: 'Math'),

              //-------------------------------

              HomeButton(
                  buttonColor: [255, 248, 248, 247],
                  edge: [8, 60, 8, 55],
                  text: 'عربي',
                  textColor: Colors.black,
                  topicName: 'Arabic'),

              //-----------------------------------------

              HomeButton(
                  buttonColor: [255, 15, 2, 2],
                  edge: [8.0, 0, 8, 35],
                  text: 'English',
                  textColor: Colors.white,
                  topicName: 'English'),

              //-----------------------------------------
            ],
          ),
        ),
      ),
    );
  }
}

class HomeButton extends StatelessWidget {
  const HomeButton(
      {super.key,
      required this.edge,
      required this.buttonColor,
      required this.text,
      required this.textColor,
      required this.topicName});

  final List<double> edge;
  final List<int> buttonColor;
  final String text;
  final Color textColor;
  final String topicName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(edge[0], edge[1], edge[2], edge[3]),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(160, 80),
            backgroundColor: Color.fromARGB(buttonColor[0], buttonColor[1],
                    buttonColor[2], buttonColor[3])
                .withOpacity(0.5)),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => GameEngine(topic: topicName)));
        },
        child: Text(
          text,
          style: TextStyle(fontSize: 20, color: textColor),
        ),
      ),
    );
  }
}

//--------------------------------


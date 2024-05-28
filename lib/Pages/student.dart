import 'package:flutter/material.dart';

import '../quiz_page.dart';




class StudentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dominto'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                  "assets/background/bears.gif")),
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 8, right: 8, top: 20),
                child: Text('Dominto',
                    style: TextStyle(
                        fontSize: 40,
                        color: Color.fromARGB(255, 77, 126, 218))),
              ),

              //----------------------------------

              HomeButton(
                buttonColor: [255, 126, 33, 9],
                edge: [8.0, 170, 8.0, 0],
                text: 'Mathmatics',
                textColor: Colors.black,
                topicName: 'math',
              ),

              //-------------------------------

              HomeButton(
                  buttonColor: [255, 248, 248, 247],
                  edge: [8, 60, 8, 55],
                  text: 'عربي',
                  textColor: Colors.black,
                  topicName: 'arabic'),

              //-----------------------------------------

              HomeButton(
                  buttonColor: [255, 15, 2, 2],
                  edge: [8.0, 0, 8, 35],
                  text: 'English',
                  textColor: Colors.white,
                  topicName: 'english' 
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeButton extends StatelessWidget {
  HomeButton(
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
            fixedSize: Size(160, 80),
            backgroundColor: Color.fromARGB(buttonColor[0], buttonColor[1],
                    buttonColor[2], buttonColor[3])
                .withOpacity(0.5)),
        onPressed: () async {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => QuizesPage(testPage: topicName)),
          ); 
        },
        child: Text(
          text,
          style: TextStyle(fontSize: 20, color: textColor),
        ),
      ),
    );
  }
}

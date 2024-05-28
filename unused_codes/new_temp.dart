// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/widgets.dart';
// import 'package:my_code/endAlertDialog.dart';
// import 'package:my_code/questions.dart';



// // #     #                                                                     
// // #     # #    #  ####   ####  #    # #####  #      ###### ##### ###### ##### 
// // #     # ##   # #    # #    # ##  ## #    # #      #        #   #      #    #
// // #     # # #  # #      #    # # ## # #    # #      #####    #   #####  #    #
// // #     # #  # # #      #    # #    # #####  #      #        #   #      #    #
// // #     # #   ## #    # #    # #    # #      #      #        #   #      #    #
// //  #####  #    #  ####   ####  #    # #      ###### ######   #   ###### ##### 


// class NewTemp extends StatefulWidget {
//   @override
//   _NewTempState createState() => _NewTempState();
// }

// class _NewTempState extends State<NewTemp> {
//   int _questionIndex = 0;

//   List<Map<String, dynamic>> _questions = [
//     {
//       'correctAnswer': 'arabic',
//       'image':
//           'https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExdWljNjdwNXFqeW1zMzJ3dW9pdTJ2Y3RkcXp2NncyZjF0djdvdXl1cSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9cw/XAxJJFihRVjRxr529J/giphy.gif'
//     },
//   ];

//   @override
//   void initState() {
//     _questions.shuffle();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('NEW'),
//       ),
//       body: Container(
//         /*
//         decoration: BoxDecoration(
//             image: DecorationImage(
//           fit: BoxFit.fill,
//           image: NetworkImage(
//               'https://i.pinimg.com/originals/7f/10/5e/7f105e4d0bbece23e323740bac9e40bf.gif'),
//         )),*/
//         child: Center(
//             child: _questionIndex < _questions.length
//                 ? PlayingProcess(questionData: _questions[_questionIndex])
//                 : Container(
//                     decoration: BoxDecoration(
//                         image: DecorationImage(
//                             fit: BoxFit.fill,
//                             image: NetworkImage(
//                                 'https://res.cloudinary.com/dflbd2qdv/image/upload/v1710506612/cel_ov1gr1.gif'))),
//                     child: Center(
//                         child: EndCorrectIncorrectAlertDialog(isEnd: true)),
//                   )),
//       ),
//     );
//   }

// /*


//   void goToNextQuestion() {
//     setState(() {
//       Navigator.of(context).pop();
//       _questionIndex++;
//       attempts = 3;
//     });
//   }

//   void _checkAnswer(String selectedAnswer) {
//     // CORRECT ANSWER
//     if (selectedAnswer == _questions[_questionIndex]['correctAnswer']) {
//       showDialog(
//           barrierDismissible: false,
//           context: context,
//           builder: (context) {
//             return EndCorrectIncorrectAlertDialog(
//                 isEnd: false,
//                 isCorrect: true,
//                 numOfStars: attempts,
//                 next: goToNextQuestion);
//           });

//       if (_questionIndex == _questions.length) {
//         // END OF THE QUESTIONS
//         showDialog(
//             context: context,
//             builder: (context) {
//               return EndCorrectIncorrectAlertDialog(isEnd: true);
//             });
//       }
//     } else {
//       showDialog(
//           // WRONG ANSWER
//           context: context,
//           builder: (context) {
//             return EndCorrectIncorrectAlertDialog(
//                 isEnd: false, isCorrect: false);
//           });
//       setState(() {
//         attempts--;
//       });
//     }
//   }

// */
// }



// class PlayingProcess extends StatefulWidget {
//   PlayingProcess({super.key, required this.questionData});
//   Map<String, dynamic> questionData;
//   int attempts = 3;

//   @override
//   State<PlayingProcess> createState() => _PlayingProcessState();
// }

// class _PlayingProcessState extends State<PlayingProcess> {
//   late List<CharacterButton> answerSection;
//   late List<CharacterButton> options;

//   @override
//   void initState() {
//     super.initState();
//     int wordLength = widget.questionData['correctAnswer'].length;

//     options = [
//       for (int i = 0; i < wordLength; i++)
//         CharacterButton(
//           text: widget.questionData['correctAnswer'][i],
//           index: i,
//           change: changePlace,
//           listLoc: false,
//           isEnable: true,
//         )
//     ];
//     // options.shuffle();
//     answerSection = List.generate(
//         wordLength,
//         (i) => CharacterButton(
//               index: i,
//               change: changePlace,
//               listLoc: true,
//               isEnable: false,
//             ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     int optionsLength = options.length;
//     int guessLength = answerSection.length;

//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: <Widget>[
//         //Hearts
//         Row(mainAxisAlignment: MainAxisAlignment.start, children: [
//           for (int i = 0; i < widget.attempts; i++)
//             Icon(
//               Icons.favorite,
//               color: Colors.redAccent,
//             ),
//           for (int i = 0; i < (3 - widget.attempts); i++)
//             Icon(
//               Icons.favorite,
//               color: Colors.grey,
//             )
//         ]),

//         //Image
//         Padding(
//           padding: const EdgeInsets.only(bottom: 80),
//           child: LimitedBox(
//               maxHeight: 150,
//               maxWidth: 150,
//               child: Image.network(
//                 widget.questionData['image'],
//                 fit: BoxFit.fill,
//               )),
//         ),

        

//         Container(
//             width: MediaQuery.of(context).size.width - 50,
//             child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: answerSection)),

//         SizedBox(
//           height: 30,
//         ),



//         Expanded(
//             child: LimitedBox(
//           maxHeight: 200, // Set a fixed height for the GridView
//           child: GridView.count(
//             mainAxisSpacing: 20,
//             crossAxisSpacing: 20,
//             crossAxisCount: 3,
//             children: List.generate(
//               optionsLength,
//               (index) {
//                 return options[index];
//               },
//             ),
//           ),
//         )),

// /*

//         Container(
//           height: 200,
//           width: MediaQuery.of(context).size.width,
//           margin: EdgeInsets.symmetric(horizontal: 10),
//           child: GridView.builder(
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 3,
//               crossAxisSpacing: 80,
//               mainAxisSpacing: 30,
//             ),
//             itemCount: optionsLength,
//             itemBuilder: (context, index) {
//               if (options[index] != null)
//                 return options[index];
//               else
//                 Container(color: Colors.red);
//             },
//           ),
//         ),

// */
//       ],
//     );
//   }

// //
// //    ####  #    #   ##   #    #  ####  ######
// //   #    # #    #  #  #  ##   # #    # #
// //   #      ###### #    # # #  # #      #####
// //   #      #    # ###### #  # # #  ### #
// //   #    # #    # #    # #   ## #    # #
// //    ####  #    # #    # #    #  ####  ######

//   void changePlace(int buttonIndex, bool location) {
   

//     setState(() {
//       if (!location) {
//         int emptyIndex =
//             answerSection.indexWhere((element) => element.text == '_');
//         answerSection[emptyIndex] = options[buttonIndex];
//         answerSection[emptyIndex].index = emptyIndex;
//         answerSection[emptyIndex].listLoc = true;

//         options.removeAt(buttonIndex);
//         changeIndices();
//       } else {

//         CharacterButton newInList1 = CharacterButton(
//           text: answerSection[buttonIndex].text,
//           index: options.length,
//           change: changePlace,
//           listLoc: false,
//           isEnable: true,
//         );

//          CharacterButton newInList2 = CharacterButton(
         
//           index: buttonIndex,
//           change: changePlace,
//           listLoc: true,
//           isEnable: false,
//         );



//         options.add(newInList1);
//         answerSection.removeAt(buttonIndex);
//          answerSection.insert(buttonIndex,newInList2);
      
//   }});
//   }

//   void changeIndices() {
//     for (int i = 0; i < options.length; i++) options[i].index = i;
//   }
// }

// class CharacterButton extends StatelessWidget {
//   CharacterButton(
//       {super.key,
//       this.text = '_',
//       required this.listLoc,
//       required this.index,
//       required this.change,
//       required this.isEnable});
//   int index;
//   String text;
//   bool listLoc;
//   bool isEnable;

//   final Function(int, bool) change;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 40,
//       width: 40,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(5),
//           ),
//         ),
//         onPressed: !isEnable
//             ? null
//             : () {
//                 change(index, listLoc);
//               },
//         child: Text(
//           text,
//           style: TextStyle(color: Colors.red, fontSize: 20),
//         ),
//       ),
//     );

 
//   }
// }

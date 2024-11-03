import 'dart:io';

import 'package:flutter/material.dart';


import 'manage_questions/files_manager.dart';
import 'templates/math_page.dart';
import 'templates/multiple_answers.dart';

@override
class QuizesPage extends StatelessWidget {
  const QuizesPage({super.key, required this.testPage});
  final String testPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quizes Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                fixedSize: const Size(200, 200),
                backgroundColor: Colors.amber,
                shadowColor: const Color.fromARGB(255, 118, 161, 89),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(testPage);
              },
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.person,
                    size: 50,
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Questions',
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                fixedSize: const Size(200, 200),
                backgroundColor: Colors.redAccent,
                shadowColor: const Color.fromARGB(255, 118, 161, 89),
              ),
              onPressed: () async {
                String fileName =
                    testPage[0].toUpperCase() + testPage.substring(1);
                final File questionFile =
                    await FilesManager.getFile('${fileName}Questions.json');
                if (!await questionFile.exists()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('There\'s no questions')),
                  );
                } else {
                  switch (testPage) {
                    case 'english':
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const QuestionsTemplate(
              sourecFile: true,
              backgroundImage:
                  'https://i.pinimg.com/564x/56/a6/81/56a68117e221e1e018aca73bfe4160ba.jpg',
              title: 'English',
              topic: 'English',
            )));
                      break;
                    case 'arabic':
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const QuestionsTemplate(
              sourecFile: true,
              backgroundImage:
                  'https://i.pinimg.com/564x/fa/d2/5d/fad25d9aee26e276f1932cac5747e0dc.jpg',
              title: 'عربي',
              topic: 'Arabic',
            )));
                      break;
                    case 'math':
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const MathematicsPage(sourecFile: true,)));
                      break;
                    default:
                  }
                }
              },
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.person,
                      size: 50, color: Color.fromARGB(255, 36, 112, 65)),
                  SizedBox(height: 2),
                  Text(
                    'Teacher quiz',
                    style: TextStyle(
                        fontSize: 30, color: Color.fromARGB(255, 36, 112, 65)),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                 String fileName =
                    testPage[0].toUpperCase() + testPage.substring(1);
                String message =
                    await FilesManager.deleteFile('${fileName}Questions.json');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(message)),
                );
              },
              child: const Text('Delete the file'),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Pages/login.dart';
import 'Pages/student.dart';
import 'Pages/teacher.dart';
import 'templates/multiple_answers.dart';

import 'templates/math_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Define a function to generate routes for subjects
  Widget generateSubjectRoute(
      String topic, String backgroundImage, String title) {
    return QuestionsTemplate(
      backgroundImage: backgroundImage,
      title: title,
      topic: topic,
      sourecFile: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "english": (context) => generateSubjectRoute(
            "English", "assets/background/english.jpg", "English"),
        'math': (context) => const MathematicsPage(sourecFile: false),
        'arabic': (context) => generateSubjectRoute(
            'Arabic', 'assets/background/arabic.jpg', 'عربي'),
      },
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${MediaQuery.of(context).size.width}'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/background/home.jpg')),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    top: 20,
                    left: MediaQuery.of(context).size.width * 0.05,
                    right: MediaQuery.of(context).size.width *
                        0.05), // Combined padding
                child: Column(
                  // Wrap with a Column for vertical arrangement
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 72), // Adjust spacing as needed
                        const Text('D',
                            style: TextStyle(
                                fontSize: 50,
                                color: Color.fromARGB(255, 77, 126, 218))),
                        const Text('o',
                            style: TextStyle(
                                fontSize: 50,
                                color: Color.fromARGB(230, 196, 22, 22))),
                        const Text('m',
                            style: TextStyle(
                                fontSize: 50,
                                color: Color.fromARGB(255, 238, 235, 56))),
                        const Text('i',
                            style: TextStyle(
                                fontSize: 50,
                                color: Color.fromARGB(255, 238, 113, 10))),
                        const Text('n',
                            style: TextStyle(
                                fontSize: 50,
                                color: Color.fromARGB(232, 26, 172, 39))),
                        const Text('t',
                            style: TextStyle(
                                fontSize: 50,
                                color: Color.fromARGB(255, 116, 21, 116))),
                        const Text('o',
                            style: TextStyle(
                                fontSize: 50,
                                color: Color.fromARGB(255, 199, 22, 9))),
                        SizedBox(
                          height: 60,
                          width: 60,
                          child: Image.asset('assets/background/pencil.webp',
                              fit: BoxFit.fill),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              //----------------------------------
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                    shape: const CircleBorder(),
                    fixedSize: const Size(200, 200),
                    backgroundColor: const Color.fromARGB(255, 144, 170, 209)),
                onPressed: () async {
                  SharedPreferences teacher =
                      await SharedPreferences.getInstance();
                  final isLoggedIn = teacher.getBool('name1') ?? false;

                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => isLoggedIn
                        ? const TeacherScreen()
                        : LoginPage(), // Navigate based on login status
                  ));
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
                      'Teacher',
                      style: TextStyle(fontSize: 30),
                    ),
                  ],
                ),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  shape: const CircleBorder(),
                  fixedSize: const Size(200, 200),
                  backgroundColor: const Color.fromARGB(255, 150, 199, 117),
                  shadowColor: const Color.fromARGB(255, 118, 161, 89),
                ),
                onPressed: () {
                  // Navigate to the Student Screen using Navigator.of(context).push
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const StudentScreen(),
                  ));
                },
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.person,
                        size: 50, color: Color.fromARGB(255, 36, 112, 65)),
                    SizedBox(height: 2),
                    Text(
                      'Student',
                      style: TextStyle(
                          fontSize: 30,
                          color: Color.fromARGB(255, 36, 112, 65)),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}

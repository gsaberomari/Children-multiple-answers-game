import 'package:flutter/material.dart';
import 'package:my_code/state/quiz_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'Pages/login.dart';
import 'Pages/student.dart';
import 'Pages/teacher.dart';
import 'templates/multiple_answers.dart';

import 'templates/math_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => QuizState(), // Provide QuizState
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Define a function to generate routes for subjects
  Widget generateSubjectRoute(
      String topic, String backgroundImage, String title) {
    return ChangeNotifierProvider(
      create: (context) => QuizState(), // Provide QuizState for each subject
      child: QuestionsTemplate(
        backgroundImage: backgroundImage,
        title: title,
        topic: topic,
        sourecFile: false,
      ),
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
        title: const Text('Dominto'),
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
                  // Get SharedPreferences instance
                  final prefs = await SharedPreferences.getInstance();

                  // Check if the user is logged in (e.g., using a key like 'isLoggedIn')
                  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

                  // Use Navigator.pushReplacement to avoid back button issue
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            isLoggedIn ? const TeacherScreen() : LoginPage()),
                  );
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
                  // Use Navigator.pushReplacement to avoid back button issue
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
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

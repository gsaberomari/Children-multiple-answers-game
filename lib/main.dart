import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Pages/login.dart';
import 'Pages/student.dart';
import 'Pages/teacher.dart';
import 'templates/multiple_answers.dart';

import 'templates/math_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      
      routes: {
        'english': (context) =>const QuestionsTemplate(
              sourecFile: false,
              backgroundImage:
                  'assets/background/english.jpg',
              title: 'English',
              topic: 'English',
            ),
        'arabic': (context) =>const QuestionsTemplate(
              sourecFile: false,
              backgroundImage:
                  'assets/background/arabic.jpg',
              title: 'عربي',
              topic: 'Arabic',
            ),
        'math': (context) => MathematicsPage(sourecFile: false,)
      },
      home:HomePage()  //Garbage()//TeacherScreen() //HomePage()
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
        decoration:const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                  'assets/background/home.jpg')),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding:const EdgeInsets.only(left: 8, right: 8, top: 20),
                child: Row(
                  children: [
                  const  SizedBox(
                      width: 30,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            //------------------
                          const  SizedBox(
                              width: 72,
                            ),
                            //--------------------
                          const  Text('D',
                                style: TextStyle(
                                    fontSize: 50,
                                    color: Color.fromARGB(255, 77, 126, 218))),
                            //------------------
                           const SizedBox(
                              width: 0,
                            ),
                            //--------------------
                          const  Text('o',
                                style: TextStyle(
                                    fontSize: 50,
                                    color: Color.fromARGB(230, 196, 22, 22))),
                            //--------------------
                           const SizedBox(
                              width: 0,
                            ),
                            //----------------------
                         const   Text('m',
                                style: TextStyle(
                                    fontSize: 50,
                                    color: Color.fromARGB(255, 238, 235, 56))),
                            //-----------------------------
                          const  SizedBox(
                              width: 0,
                            ),
                            //-----------------------------
                         const   Text('i',
                                style: TextStyle(
                                    fontSize: 50,
                                    color: Color.fromARGB(255, 238, 113, 10))),
                            //-----------------------------
                           const SizedBox(
                              width: 0,
                            ),
                            //-----------------------------
                         const   Text('n',
                                style: TextStyle(
                                    fontSize: 50,
                                    color: Color.fromARGB(232, 26, 172, 39))),
                            //-----------------------------
                         const   SizedBox(
                              width: 0,
                            ),
                            //-----------------------------
                         const   Text('t',
                                style: TextStyle(
                                    fontSize: 50,
                                    color: Color.fromARGB(255, 116, 21, 116))),
                            //-----------------------------
                        const    SizedBox(
                              width: 0,
                            ),
                            //-----------------------------
                       const     Text('o',
                                style: TextStyle(
                                    fontSize: 50,
                                    color: Color.fromARGB(255, 199, 22, 9))),
                            //-----------------------------
                        const    SizedBox(
                              width: 0,
                            ),
                            //-----------------------------
                            SizedBox(
                                height: 60,
                                width: 60,
                                child: Image.asset(
                                  'assets/background/pencil.webp',
                                  fit: BoxFit.fill,
                                ))
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),

              //----------------------------------
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding:const EdgeInsets.all(10),
                    shape:const CircleBorder(),
                    fixedSize:const Size(200, 200),
                    backgroundColor:const Color.fromARGB(255, 144, 170, 209)),
                onPressed: () async{
                    SharedPreferences teacher = await SharedPreferences.getInstance();
          bool? isLoggedIn  =teacher.getBool('name1');
          isLoggedIn==null || !isLoggedIn ?
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) =>  LoginPage())):
                  
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const TeacherScreen()),
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
                  padding:const EdgeInsets.all(10),
                  shape:const CircleBorder(),
                  fixedSize:const Size(200, 200),
                  backgroundColor:const Color.fromARGB(255, 150, 199, 117),
                  shadowColor:const Color.fromARGB(255, 118, 161, 89),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => StudentScreen()),
                  );
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
           const   SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}

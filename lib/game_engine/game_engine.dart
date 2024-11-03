import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../Pages/teacher.dart';
import 'images_library_page.dart';
import '../manage_questions/files_manager.dart';

class GameEngine extends StatefulWidget {
  const GameEngine({super.key, required this.topic});
  final String topic;

  @override
  State<GameEngine> createState() => _GameEngineState();
}

class _GameEngineState extends State<GameEngine> {
  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
String _imageLink='';
  String question = '';
  String option1 = '';
  String option2 = '';
  String option3 = '';
  late String correctAnswer = option1;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Create a question'),
          leading: BackButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const TeacherScreen()),
              );
            },
          )),
      body: Container(
        color: Colors.amber[100],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  children: <Widget>[
                    const SizedBox(height: 10),
                    const Center(
                      child: Text(
                        'Create a question',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      '- Choose the image of the question:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 30),
                    questionImage() , const SizedBox(height: 30),
                  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const BeveledRectangleBorder(),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () { showModalBottomSheet(
                  context: context,
                  builder: (context) => bottomSheet(),
                );
                // Add your onPressed logic here
              },
              child: const Text('Device'),
            ),
            const SizedBox(width: 16), // Adds spacing between the buttons
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const BeveledRectangleBorder(),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ImageSelectionScreen(topic: widget.topic,onValueChange: imageFromLibrary)));
              },
              child: const Text('App Images'),
            ),
          ],),
                    
                    const SizedBox(height: 30),
                    TextField(
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Question",
                      ),
                      onChanged: (value) => question = value,
                    ),
                    const SizedBox(height: 20),
                    buildOptionTextField(
                        "Option 1", (value) => option1 = value),
                    const SizedBox(height: 20),
                    buildOptionTextField(
                        "Option 2", (value) => option2 = value),
                    const SizedBox(height: 20),
                    buildOptionTextField(
                        "Option 3", (value) => option3 = value),
                    const SizedBox(height: 20),
                    const Text(
                      '- Choose the correct answer of the question:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    (option1.isEmpty || option2.isEmpty || option3.isEmpty)
                        ? const Text('Fill all of the options first !',
                            style: TextStyle(
                                color: Color.fromARGB(255, 163, 22, 22)))
                        : DropdownButton<String>(
                            value: correctAnswer,
                            onChanged: (newValue) {
                              setState(() {
                                correctAnswer = newValue!;
                              });
                            },
                            items:
                                [option1, option2, option3].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100),
                      child: Row(
                        children: [


                          ElevatedButton(
                            onPressed: () {
                              if (validateInput()) {
                                isLoading = true;
                                saveQuestion(true);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Question submitted successfully!')),
                                );
                                setState(() {});
                              }
                            },
                            child: const Text('Save'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (validateInput()) {
                                isLoading = true;
                                saveQuestion(false);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Add another question')),
                                );
                                setState(() {});
                              }
                            },
                            child: const Text('Add more'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }



 void imageFromLibrary(String newValue) {
    setState(() {
      _imageLink = newValue;
     _imageFile = null;
     
      
    });
  }




  Widget questionImage() {
    ImageProvider<Object> imageProvider;

    if (_imageFile != null) {
      imageProvider = FileImage(File(_imageFile!.path));
    } else if (_imageLink.isNotEmpty) {
      imageProvider =_imageLink.startsWith('assets/')?AssetImage(_imageLink): NetworkImage(_imageLink) as ImageProvider<Object>;
    } 
   
      
      



    
    else {
      imageProvider = const NetworkImage('https://addlogo.imageonline.co/image.jpg');
    }
    return Center(
      child: 
          CircleAvatar(
            radius: 80,
            backgroundImage:imageProvider
          )
         
       
     
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          const Text('Choose the image', style: TextStyle(fontSize: 20)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                icon: const Icon(Icons.camera),
                label: const Text("Camera"),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
              ),
              TextButton.icon(
                icon: const Icon(Icons.image),
                label: const Text("Gallery"),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      _imageFile = PickedFile(pickedFile!.path);
      _imageLink='';
       Navigator.pop(context);
    });
  }

  Future<String> saveImageToAssetFile(PickedFile? pickedFile) async {
    final File imageFile = File(pickedFile!.path);
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String assetFilePath = '${appDocDir.path}/image.png';
    await imageFile.copy(assetFilePath);
    print('\n\n\t\t$assetFilePath\n\n');/////////
    return assetFilePath;
  }

  Widget buildOptionTextField(String labelText, Function(String) onchanged) {
    return TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
        ),
        onChanged: onchanged);
  }

  bool validateInput() {
    if (question.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the question')),
      );
      return false;
    }
    if (option1.isEmpty || option2.isEmpty || option3.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter all options')),
      );
      return false;
    }
    if (correctAnswer.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please choose the correct answer')),
      );
      return false;
    }
     if (_imageLink.isEmpty && _imageFile==null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please choose an image')),
      );
      return false;
    }
    return true;
  }


  void saveQuestion(bool done) async {
    File questionFile =
        await FilesManager.getFile('${widget.topic}Questions.json');
    List<Map<String, dynamic>> questions = [];
    if (await questionFile.exists()) {
      final String data = await questionFile.readAsString();
      if (data.isNotEmpty) {
        questions = List<Map<String, dynamic>>.from(json.decode(data));
      }
    } else {
      await questionFile.create();
    }
 
String imagePath;
  
  if (_imageFile != null) {
    imagePath = await saveImageToAssetFile(_imageFile!);
  } else if (_imageLink.isNotEmpty) {
    imagePath = _imageLink;
  } else {
    imagePath = '';
  }
    // Add new question
    questions.add({
      'question': question,
      'correctAnswer': correctAnswer,
      'options': [option1, option2, option3],
      'image':imagePath ,
    });

    // Save updated questions to file

    await questionFile.writeAsString(json.encode(questions));
    if (done) {
      Navigator.pop(context);
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => GameEngine(topic: widget.topic)));
    }
  }
}

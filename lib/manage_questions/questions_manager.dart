import 'dart:convert';
import 'dart:io';

import 'dart:math';

import 'package:flutter/services.dart';


import 'files_manager.dart';




class AppQuestions {


static Future<List<Map<String, dynamic>>> getArabicQuestions(bool sourecFile) async {
  if(!sourecFile){
String data = await rootBundle.loadString('assets/questions.json');
 Map<String, dynamic> jsonData = json.decode(data);
return pickRandomElements(List<Map<String, dynamic>>.from(jsonData['Arabic']),5);
}
else
{

    
 final File questionFile = await FilesManager.getFile('ArabicQuestions.json');

    String data = await questionFile.readAsString();

    List<dynamic> jsonData = json.decode(data);    

    
      return  List<Map<String, dynamic>>.from(jsonData);

}


   }
 static Future<List<Map<String, dynamic>>> getMathQuestions(bool sourecFile) async {
  if(!sourecFile){
String data = await rootBundle.loadString('assets/questions.json');
 Map<String, dynamic> jsonData = json.decode(data);
return pickRandomElements(List<Map<String, dynamic>>.from(jsonData['Math']),5);
}
else
{

    
 final File questionFile = await FilesManager.getFile('MathQuestions.json');

    String data = await questionFile.readAsString();

    List<dynamic> jsonData = json.decode(data);    

    
      return  List<Map<String, dynamic>>.from(jsonData);

}


   }


   static Future<List<Map<String, dynamic>>> getEnglishQuestions(bool sourecFile) async {
  if(!sourecFile){
String data = await rootBundle.loadString('assets/questions.json');
 Map<String, dynamic> jsonData = json.decode(data);
return pickRandomElements(List<Map<String, dynamic>>.from(jsonData['English']),5);
}
else
{

    
 final File questionFile = await FilesManager.getFile('EnglishQuestions.json');

    String data = await questionFile.readAsString();

    List<dynamic> jsonData = json.decode(data);    

    
      return  List<Map<String, dynamic>>.from(jsonData);

}


   }


}

List<T> pickRandomElements<T>(List<T> list, int n) {
  if (n >= list.length) {
    return List.from(list);
  }
  
  final random = Random();
  final selectedElements = <T>[];
  final selectedIndexes = <int>{};

  while (selectedElements.length < n) {
    final index = random.nextInt(list.length);
    if (!selectedIndexes.contains(index)) {
      selectedIndexes.add(index);
      selectedElements.add(list[index]);
    }
  }

  return selectedElements;
}




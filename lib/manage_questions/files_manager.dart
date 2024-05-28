
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FilesManager {
  static Future<String> get getFilepPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> getFile(String fileName) async {
    final appPath = await getFilepPath;
    return File('$appPath/$fileName');
  }

  static Future<File> saveToFile(String data, String fileName) async {
    final file = await getFile(fileName);
    return file.writeAsString(data);
  }

  static Future<String> readFromFile(String fileName) async {
    try {
      final file = await getFile(fileName);
      String fileContents = await file.readAsString();
      return fileContents;
    } catch (e) {
      return '';
    }
  }

static   Future<String> deleteFile(String fileName) async {
    try {
      final file =await getFile(fileName);
      if ( await file.exists()) {
        await file.delete();
        return ('File deleted');
      } else {
        return('File does not exist');
      }
    } catch (e) {
      return('Error deleting file: $e');
    }
  }
}




import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImageSelectionScreen extends StatefulWidget {
  final String topic;

  const ImageSelectionScreen(
      {super.key, required this.topic, required this.onValueChange});
  final ValueChanged<String> onValueChange;

  @override
  _ImageSelectionScreenState createState() => _ImageSelectionScreenState();
}

class _ImageSelectionScreenState extends State<ImageSelectionScreen> {
  List<String> imageLinks = [];

  @override
  void initState() {
    super.initState();
    _loadJson();
  }

  Future<void> _loadJson() async {
    final String response =
        await rootBundle.loadString('assets/questions.json');
    final data = json.decode(response);
    List<String> links = [];
    switch (widget.topic) {
      case 'English':
        for (var item in data['English']) {
          links.add(item['image']);
        }

        break;

      case 'Arabic':
        for (var item in data['Arabic']) {
          links.add(item['image']);
        }
        break;
         case 'Math':
      for (var item in data['Math']) {
       
          links.add(item['image']);
      }
    }

    setState(() {
      imageLinks = links;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select an Image'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: imageLinks.isEmpty
            ? Center(child: CircularProgressIndicator())
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: imageLinks.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      widget.onValueChange(imageLinks[index]);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Selected: ${imageLinks[index]}')),
                      );
                      Navigator.pop(context);
                    },
                    child:widget.topic!='Math'? Image.network(imageLinks[index]):Image.asset(imageLinks[index]),
                  );
                },
              ),
      ),
    );
  }

}

import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';

class ImageSelectionScreen extends StatefulWidget {
  final String topic;

  const ImageSelectionScreen(
      {super.key, required this.topic, required this.onValueChange});

  final ValueChanged<String> onValueChange;

  @override
  ImageSelectionScreenState createState() => ImageSelectionScreenState();
}

class ImageSelectionScreenState extends State<ImageSelectionScreen> {
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
    final List<dynamic> topicData = data[widget.topic];

    final List<String> links =
        topicData.map((item) => item['image'] as String).toList();

    setState(() {
      imageLinks = links;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select an Image'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: imageLinks.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: imageLinks.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      widget.onValueChange(imageLinks[index]);
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text('Selected: ${imageLinks[index]}'),
                          ),
                        );
                      Navigator.pop(context);
                    },
                    child: widget.topic == 'Math'
                        ? Image.asset(imageLinks[index])
                        : Image.network(imageLinks[index]),
                  );
                },
              ),
      ),
    );
  }
}

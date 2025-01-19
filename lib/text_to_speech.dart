import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeech extends StatelessWidget {
  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController textEditingController = TextEditingController();

  TextToSpeech({super.key});

  speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text to Speech'),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(50),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(50), // Add padding here
                  child: TextFormField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                      hintText: "Type something to hear it aloud",
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: -65.9),
                    ),
                  )),
              ElevatedButton(
                child: const Text("Start to begin text to speech"),
                onPressed: () => speak(textEditingController.text),
              ),
            ],
          ),
        ),
      ),
      // FloatingActionButton for the back arrow button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: const Color(0xffccdefe),
        child: const Icon(Icons.arrow_back),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

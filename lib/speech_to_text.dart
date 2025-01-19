import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechText extends StatefulWidget {
  const SpeechText({super.key});

  @override
  State<SpeechText> createState() => _SpeechtextState();
}

class _SpeechtextState extends State<SpeechText> {
  bool isListening = false;
  late stt.SpeechToText _speechToText;
  String text = "Press the button & start speaking";
  double confidence = 1.0;

  @override
  void initState() {
    _speechToText = stt.SpeechToText();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //title: Text("Confidence: ${(confidence * 100).toStringAsFixed(1)}%"),
          ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: isListening,
        glowColor: Colors.blue,
        duration: const Duration(milliseconds: 1000),
        repeat: true,
        child: FloatingActionButton(
          backgroundColor: Colors.blue, // Correct parameter for FAB
          onPressed: _captureVoice,
          child: Icon(
            isListening ? Icons.mic : Icons.mic_none,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Text(
                text,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.blue, // Correct parameter for ElevatedButton
                  ),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: text));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Successfully copied text"),
                      ),
                    );
                  },
                  child: const Text(
                    "Copy Text",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _captureVoice() async {
    if (!isListening) {
      bool available = await _speechToText.initialize();
      if (available) {
        setState(() => isListening = true);
        _speechToText.listen(
          onResult: (result) => setState(() {
            text = result.recognizedWords;
            if (result.hasConfidenceRating && result.confidence > 0) {
              confidence = result.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => isListening = false);
      _speechToText.stop();
    }
  }
}

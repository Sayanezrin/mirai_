import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'speech_to_text.dart';
import 'theme_notifier.dart';
import 'text_to_speech.dart';
import 'alertsetting.dart';
import 'chat_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  bool _showWelcomeNote = true;

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final isDarkTheme = themeNotifier.themeData.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: PopupMenuButton<String>(
          icon: const Icon(Icons.menu),
          onSelected: (String value) {
            _handleMenuSelection(value);
          },
          itemBuilder: (BuildContext context) {
            return _buildPopupMenuItems();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              isDarkTheme ? Icons.wb_sunny : Icons.nights_stay,
            ),
            onPressed: () {
              themeNotifier.toggleTheme();
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              _showSettingsDialog(context);
            },
          ),
        ],
      ),
      body: Container(
        color: isDarkTheme ? Colors.black : Colors.white,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Visibility(
              visible: _showWelcomeNote,
              child: Center(
                child: Text(
                  'Welcome to Mirai! Your communication companion.',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDarkTheme ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildAnimatedServiceBox(
              context,
              title: 'Speech to Text',
              isDarkTheme: isDarkTheme,
              onTap: () {
                _onServiceTap(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SpeechText()),
                  );
                });
              },
            ),
            const SizedBox(height: 20),
            _buildAnimatedServiceBox(
              context,
              title: 'Text to Speech',
              isDarkTheme: isDarkTheme,
              onTap: () {
                _onServiceTap(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TextToSpeech()),
                  );
                });
              },
            ),
            const SizedBox(height: 20),
            _buildAnimatedServiceBox(
              context,
              title: 'Alert Settings',
              isDarkTheme: isDarkTheme,
              onTap: () {
                _onServiceTap(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SoundAlertScreen()),
                  );
                });
              },
            ),
            const SizedBox(height: 20),
            _buildAnimatedServiceBox(
              context,
              title: 'MiraiAssist',
              isDarkTheme: isDarkTheme,
              onTap: () {
                _onServiceTap(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatPage()),
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  // Method to handle service selection and hide welcome note
  void _onServiceTap(VoidCallback onTap) {
    setState(() {
      _showWelcomeNote =
          false; // Hide the welcome note once a service is tapped
    });
    onTap();
  }

  // Method to build a reusable service box widget with animation
  Widget _buildAnimatedServiceBox(
    BuildContext context, {
    required String title,
    required bool isDarkTheme,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDarkTheme ? Colors.grey[800] : Colors.blue[200],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color: isDarkTheme ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  void _handleMenuSelection(String value) {
    if (value == 'Alert Setting') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SoundAlertScreen()),
      );
    } else if (value == 'Gemini Chat') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChatPage()),
      );
    }
  }

  List<PopupMenuEntry<String>> _buildPopupMenuItems() {
    return [
      const PopupMenuItem<String>(
        value: 'Alert Setting',
        child: Text('Alert Setting'),
      ),
      const PopupMenuItem<String>(
        value: 'Gemini Chat',
        child: Text('Gemini Chat'),
      ),
    ];
  }

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Settings'),
          content: const Text('Settings options go here.'),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

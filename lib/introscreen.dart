import 'dart:async'; // Import the Timer class
import 'package:flutter/material.dart';
import 'menu_page.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final List<String> images = [
    'assets/screen1new.png',
    'assets/screen2new.png',
    'assets/screen3new.png',
  ];
  int _currentIndex = 0;
  Timer? _timer; // Declare a Timer variable

  @override
  void initState() {
    super.initState();
    _startImageLoop();
  }

  void _startImageLoop() {
    // Start a periodic timer that updates the image index
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (!mounted) {
        timer.cancel(); // Cancel the timer if the widget is not mounted
        return;
      }
      setState(() {
        _currentIndex = (_currentIndex + 1) % images.length;
      });
    });

    // Navigate to the MenuPage after displaying images for a certain time
    Future.delayed(Duration(seconds: images.length * 3), () {
      if (mounted) {
        _navigateToMenuPage();
      }
    });
  }

  void _navigateToMenuPage() {
    _timer?.cancel(); // Cancel the timer before navigating
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MenuPage()),
    );
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer if it exists
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            AnimatedSwitcher(
              duration: Duration(seconds: 1),
              child: Image.asset(
                images[_currentIndex],
                key: ValueKey<int>(_currentIndex),
                fit: BoxFit
                    .contain, // Adjust this to BoxFit.cover or other as needed
                width: MediaQuery.of(context).size.width *
                    0.9, // 80% of screen width
                height: MediaQuery.of(context).size.height *
                    0.9, // 60% of screen height
              ),
            ),
            _buildDotIndicator(), // Add the dot indicator here
          ],
        ),
      ),
    );
  }

  Widget _buildDotIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(images.length, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentIndex == index ? Colors.blue : Colors.grey,
          ),
        );
      }),
    );
  }
}

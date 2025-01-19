import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'menu_page.dart';
import 'introscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() {
    _controller = VideoPlayerController.asset('assets/mirailogo.mp4')
      ..initialize().then((_) {
        print("Video initialized successfully");
        setState(() {
          _controller.play();
          _controller.setLooping(false);
        });

        // Navigate to MenuPage after a minimum duration of 8 seconds
        Future.delayed(const Duration(seconds: 5), () {
          if (_controller.value.isInitialized) {
            _controller.pause(); // Pause if the video is still playing
          }
          _navigateToHome();
        });

        // Additional listener to handle when the video finishes
        _controller.addListener(() {
          if (_controller.value.position == _controller.value.duration) {
            print("Video finished playing");
          }
        });
      }).catchError((error) {
        print("Error initializing video: $error");
        setState(() {
          _isError = true;
        });
      });
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => IntroScreen()),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffebf9ff),
      body: Center(
        child: _isError
            ? const Text(
                'Error loading video',
                style: TextStyle(color: Colors.red),
              )
            : _controller.value.isInitialized
                ? Container(
                    width: MediaQuery.of(context).size.width, // Full width
                    height: MediaQuery.of(context).size.height, // Full height
                    child: VideoPlayer(_controller),
                  )
                : const CircularProgressIndicator(), // Loading indicator
      ),
    );
  }
}

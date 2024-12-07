import 'package:flutter/material.dart';

class AnimationProvider with ChangeNotifier {
  late AnimationController _controller;
  late Animation<Color?> colorAnimation1;
  late Animation<Color?> colorAnimation2;

  AnimationController get controller => _controller;
  Animation<Color?> get colorAnimation1Value => colorAnimation1;
  Animation<Color?> get colorAnimation2Value => colorAnimation2;

  // Initialize the animations
  void initializeAnimation(TickerProvider vsync) {
    _controller = AnimationController(
      duration: const Duration(seconds: 1), // Increased speed
      vsync: vsync,
    )..repeat(reverse: true);

    colorAnimation1 =
        ColorTween(begin: Colors.green, end: Colors.green).animate(_controller);
    colorAnimation2 =
        ColorTween(begin: Colors.white, end: Colors.blue).animate(_controller);
    notifyListeners();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';

class AudioPlayerModel with ChangeNotifier {
  bool _playing = false;

  AnimationController _controller;

  bool get playing => _playing;

  set playing(bool value) {
    _playing = value;
    notifyListeners();
  }

  AnimationController get controller => _controller;

  set controller(AnimationController value) {
    _controller = value;
  }
}

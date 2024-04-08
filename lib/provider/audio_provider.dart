import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_streaming_app/models/api_base_response.dart';

class AudioProvider with ChangeNotifier {

  bool shouldMiniPlayerBeVisible = false;
  ApiBaseResponse miniPlayerApi = ApiBaseResponse();
  AudioPlayer? myPlayer;
  int? currentIndex;

  setVisible(bool value) {
    shouldMiniPlayerBeVisible = value;
    notifyListeners();
  }

  setData(ApiBaseResponse apiBaseResponse, int index) {
    miniPlayerApi = apiBaseResponse;
    currentIndex = index;
    setVisible(true);
    notifyListeners();
  }
}

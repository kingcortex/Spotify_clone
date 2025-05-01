import 'package:get/get.dart';

class Lyric {
  final Duration time;
  final String text;

  Lyric({required this.time, required this.text});
}

class LyricsController extends GetxController {
  var lyrics = <Lyric>[].obs;
  var currentLyricIndex = 0.obs;

  void loadLyrics(List<Lyric> newLyrics) {
    lyrics.value = newLyrics;
  }

  void updateCurrentLyric(Duration position) {
    for (int i = 0; i < lyrics.length; i++) {
      if (position < lyrics[i].time) {
        currentLyricIndex.value = (i - 1).clamp(0, lyrics.length - 1);
        return;
      }
    }
    currentLyricIndex.value = lyrics.length - 1;
  }
}

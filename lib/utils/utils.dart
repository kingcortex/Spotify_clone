import 'dart:ui';

import 'package:flutter/material.dart';

import '../controller/lyrics_controller.dart';

class Utils {
  static ColorFilter getColorFilter(Color color) {
    return ColorFilter.mode(
      color,
      BlendMode.srcIn,
    );
  }

  static List<Lyric> parseLrc(String lrcContent) {
    final regex = RegExp(r'\[(\d{2}):(\d{2})\.(\d{2})\](.*)');
    final lines = lrcContent.split('\n');
    List<Lyric> lyrics = [];

    for (var line in lines) {
      final match = regex.firstMatch(line);
      if (match != null) {
        final minutes = int.parse(match.group(1)!);
        final seconds = int.parse(match.group(2)!);
        final hundredths = int.parse(match.group(3)!);
        final text = match.group(4)!.trim();

        final time = Duration(
          minutes: minutes,
          seconds: seconds,
          milliseconds: hundredths * 10,
        );

        lyrics.add(Lyric(time: time, text: text.isEmpty ? "♪" : text));
      }
    }

    return lyrics;
  }

  static String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  static String formatRemaining(Duration position, Duration duration) {
    final remaining = duration - position;
    final minutes =
        remaining.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds =
        remaining.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "-$minutes:$seconds";
  }

  static double calculateSliderValue(Duration position, Duration duration) {
    if (duration.inMilliseconds == 0) {
      return 0;
    }
    return position.inMilliseconds / duration.inMilliseconds;
  }

  static bool canScroll(ScrollController scrollController) {
    return scrollController.position.maxScrollExtent >
        scrollController.position.minScrollExtent;
  }
}

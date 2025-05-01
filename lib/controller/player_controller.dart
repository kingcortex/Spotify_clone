import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify_clone/controller/lyrics_controller.dart';
import 'package:spotify_clone/models/music.dart';

import '../utils/utils.dart';

class PlayerController extends GetxController {
  final LyricsController lyricsController;
  final AudioPlayer audioPlayer = AudioPlayer(maxSkipsOnError: 3);

  var isPlaying = false.obs;
  var position = Duration.zero.obs;
  var duration = Duration.zero.obs;
  var currentIndex = 0.obs;
  List<Music> playlist = [];
  Music? music;

  PlayerController({required this.lyricsController});

  Future<String> loadLrcFromAssets(String path) async {
    return await rootBundle.loadString(path);
  }

  void loadLyrics(Music music) async {
    try {
      final lrcContent = await loadLrcFromAssets(music.lyricsPath);
      final lyrics = Utils.parseLrc(lrcContent);
      lyricsController.loadLyrics(lyrics);
    } catch (e) {
      print('Erreur lors du chargement des paroles : $e');
    }
  }

  Future<void> setPlaylist(List<Music> titres, {int startIndex = 0}) async {
    playlist = titres;

    final List<AudioSource> sources = playlist
        .map(
          (music) => AudioSource.asset(music.audioPath),
        )
        .toList();

    try {
      await audioPlayer.setAudioSources(
        sources,
        initialIndex: startIndex,
      );
    } catch (e) {
      print('Erreur lors du chargement de la playlist : $e');
    }

    music = playlist[startIndex];
    if (music != null) {
      loadLyrics(music!);
    }
    currentIndex.value = startIndex;
    update();
  }

  void play() {
    audioPlayer.play();
    isPlaying.value = true;
  }

  void pause() {
    audioPlayer.pause();
    isPlaying.value = false;
  }

  void seek(double value) {
    final newPosition = duration.value * value;
    audioPlayer.seek(newPosition);
  }

  void seekByDuration(Duration value) {
    audioPlayer.seek(value);
  }

  Future<void> next() async {
    await audioPlayer.seekToNext();
  }

  Future<void> previous() async {
    await audioPlayer.seekToPrevious();
  }

  Music? getNextMusic() {
    if (currentIndex.value + 1 < playlist.length) {
      return playlist[currentIndex.value + 1];
    }
    return null;
  }

  Music? getPreviousMusic() {
    if (currentIndex.value > 0) {
      return playlist[currentIndex.value - 1];
    }
    return null;
  }

  @override
  void onInit() {
    super.onInit();

    audioPlayer.positionStream.listen((newPosition) {
      position.value = newPosition;
    });

    audioPlayer.durationStream.listen((newDuration) {
      if (newDuration != null) {
        duration.value = newDuration;
      }
    });

    audioPlayer.playerStateStream.listen((state) {
      isPlaying.value = state.playing;
    });

    audioPlayer.currentIndexStream.listen((newIndex) {
      if (newIndex != null && newIndex < playlist.length) {
        currentIndex.value = newIndex;
        music = playlist[newIndex];
        if (music != null) {
          loadLyrics(music!);
        }
        update();
      }
    });
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }
}

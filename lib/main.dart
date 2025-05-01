import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify_clone/pages/splash.dart';
import 'package:spotify_clone/theme/app_theme.dart';

import 'controller/lyrics_controller.dart';
import 'controller/player_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AudioPlayer.clearAssetCache();
  var lyricsController = Get.put(LyricsController());
  Get.put(PlayerController(lyricsController: lyricsController));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spotify clone',
      theme: AppTheme.darkTheme,
      home: const Splash(),
    );
  }
}

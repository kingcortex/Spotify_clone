import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:spotify_clone/controller/player_controller.dart';
import 'package:spotify_clone/pages/main_page.dart';
import 'package:spotify_clone/theme/app_colors.dart';
import 'package:spotify_clone/utils/utils.dart';

import '../models/music.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _loadPlaylistAndNavigate();
  }

  void _loadPlaylistAndNavigate() {
    Get.find<PlayerController>()
        .setPlaylist(playlyst.reversed.toList())
        .whenComplete(() => Future.delayed(
              Durations.extralong4,
              _navigateToMainPage,
            ));
  }

  void _navigateToMainPage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MainPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Center(
        child: SvgPicture.asset(
          "assets/svgs/Logo.svg",
          width: 130,
          colorFilter: Utils.getColorFilter(AppColors.primary),
        ),
      ),
    );
  }
}

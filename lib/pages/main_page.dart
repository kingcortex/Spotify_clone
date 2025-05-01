import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_clone/pages/home.dart';
import 'package:spotify_clone/utils/utils.dart';

import '../theme/app_colors.dart';
import '../utils/assets.dart';
import '../widgets/now_playing_bar_widget.dart';

var safePaddingTop = 0.0;

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _indexPage = 0;
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    safePaddingTop = MediaQuery.viewPaddingOf(context).top;
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: [
              Home(),
              Container(),
              Container(),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: NowPlayingBarWidget(),
          )
        ],
      ),
      bottomNavigationBar: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
          child: NavigationBar(
            selectedIndex: _indexPage,
            backgroundColor: Colors.transparent,
            onDestinationSelected: (index) {
              setState(() {
                _indexPage = index;
              });
              _pageController.jumpToPage(index);
            },
            destinations: [
              NavigationDestination(
                icon: svgNavigationBarIcon(
                  AppIcons.home,
                ),
                label: "Home",
                selectedIcon:
                    svgNavigationBarIcon(AppIcons.homeFilled, selected: true),
              ),
              NavigationDestination(
                icon: svgNavigationBarIcon(AppIcons.search),
                label: "Search",
                selectedIcon:
                    svgNavigationBarIcon(AppIcons.searchFilled, selected: true),
              ),
              NavigationDestination(
                icon: svgNavigationBarIcon(AppIcons.library),
                label: "Library",
                selectedIcon: svgNavigationBarIcon(AppIcons.libraryFilled,
                    selected: true),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget svgNavigationBarIcon(String path, {bool selected = false}) {
    return SvgPicture.asset(
      width: 21,
      path,
      colorFilter:
          Utils.getColorFilter(selected ? AppColors.white : Color(0xff777777)),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

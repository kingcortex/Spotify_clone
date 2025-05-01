import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:spotify_clone/controller/lyrics_controller.dart';
import 'package:spotify_clone/controller/player_controller.dart';
import 'package:spotify_clone/pages/lyrics_page.dart';
import 'package:spotify_clone/utils/assets.dart';
import 'package:spotify_clone/utils/extention.dart';

import '../theme/app_colors.dart';
import '../utils/const.dart';
import 'circle_icon_button.dart';

class LyricsPreviewWidget extends StatefulWidget {
  final List<Lyric> lyrics;
  final PlayerController playerController;

  const LyricsPreviewWidget(
      {super.key, required this.lyrics, required this.playerController});

  @override
  State<LyricsPreviewWidget> createState() => _LyricsPreviewWidgetState();
}

class _LyricsPreviewWidgetState extends State<LyricsPreviewWidget> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener =
      ScrollOffsetListener.create();
  StreamSubscription? streamSubscription;
  int lastScrollIndex = -1;

  @override
  void dispose() {
    streamSubscription?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    streamSubscription = widget.playerController.position.listen((position) {
      DateTime dt = DateTime(1970, 1, 1).copyWith(
        hour: position.inHours,
        minute: position.inMinutes.remainder(60),
        second: position.inSeconds.remainder(60),
      );

      for (int index = 0; index < widget.lyrics.length; index++) {
        if (index > 4 && widget.lyrics[index].time.isAfter(dt)) {
          if (lastScrollIndex != index) {
            lastScrollIndex = index;
            itemScrollController.scrollTo(
              index: index - 2,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
            );
          }
          break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          _toLyricsPage(context, widget.playerController, widget.lyrics),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppConstant.containerRaduis),
        child: Scaffold(
          backgroundColor: widget.playerController.music!.lyricsBgColor,
          appBar: LyricsPreviewBar(widget: widget),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0)
                    .copyWith(bottom: 20),
                child: Column(
                  children: [
                    Expanded(
                      child: StreamBuilder<Duration>(
                        stream: widget.playerController.position.stream,
                        builder: (context, snapshot) {
                          return ScrollablePositionedList.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: widget.lyrics.length,
                            itemBuilder: (context, index) {
                              Duration duration =
                                  snapshot.data ?? const Duration(seconds: 0);
                              DateTime dt = DateTime(1970, 1, 1).copyWith(
                                hour: duration.inHours,
                                minute: duration.inMinutes.remainder(60),
                                second: duration.inSeconds.remainder(60),
                              );
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: Text(
                                  widget.lyrics[index].text,
                                  style: TextStyle(
                                    color: widget.lyrics[index].time.isAfter(dt)
                                        ? AppColors.bg
                                        : Colors.white,
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            },
                            itemScrollController: itemScrollController,
                            scrollOffsetController: scrollOffsetController,
                            itemPositionsListener: itemPositionsListener,
                            scrollOffsetListener: scrollOffsetListener,
                          );
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            widget.playerController.music!.lyricsBgColor,
                            widget.playerController.music!.lyricsBgColor
                                .withValues(alpha: .0),
                            widget.playerController.music!.lyricsBgColor
                                .withValues(alpha: .0),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LyricsPreviewBar extends StatelessWidget implements PreferredSizeWidget {
  const LyricsPreviewBar({
    super.key,
    required this.widget,
  });

  final LyricsPreviewWidget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.playerController.music!.lyricsBgColor,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Row(
        children: [
          Text(
            "Lyrics",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
          Spacer(),
          CircleIconButton(
            backgroundColor: widget.playerController.music!.playNowColor
                .withValues(alpha: .6),
            size: 35,
            icon: Icons.ios_share,
            onTap: () {}, // Replace with actual functionality
          ),
          14.horizontalSpace,
          CircleIconButton(
            backgroundColor: widget.playerController.music!.playNowColor
                .withValues(alpha: .6),
            size: 35,
            widgetIcon: SvgPicture.asset(AppIcons.more),
            icon: Icons.ios_share,
            onTap: () => _toLyricsPage(context, widget.playerController,
                widget.lyrics), // Replace with actual functionality
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}

Future<dynamic> _toLyricsPage(
    BuildContext context, PlayerController controller, List<Lyric> lyrics) {
  return Navigator.of(context).push(
    PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) => LyricsPage(
        lyrics: lyrics,
        playerController: controller,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween<Offset>(
          begin: Offset(.0, 1.0), // Du bas vers le haut
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeOut));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    ),
  );
}

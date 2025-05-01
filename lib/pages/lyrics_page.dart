import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:spotify_clone/controller/lyrics_controller.dart';
import 'package:spotify_clone/theme/app_colors.dart';
import 'package:spotify_clone/theme/text_theme.dart';
import 'package:spotify_clone/utils/extention.dart';
import 'package:spotify_clone/widgets/player_controller_widget.dart';

import '../controller/player_controller.dart';

class LyricsPage extends StatefulWidget {
  final List<Lyric> lyrics;
  final PlayerController playerController;

  const LyricsPage(
      {super.key, required this.lyrics, required this.playerController});

  @override
  State<LyricsPage> createState() => _LyricsPageState();
}

class _LyricsPageState extends State<LyricsPage> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
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
      final currentLyricTime = DateTime(1970, 1, 1).copyWith(
        hour: position.inHours,
        minute: position.inMinutes.remainder(60),
        second: position.inSeconds.remainder(60),
      );

      for (int index = 0; index < widget.lyrics.length; index++) {
        if (index > 4 && widget.lyrics[index].time.isAfter(currentLyricTime)) {
          if (lastScrollIndex != index) {
            lastScrollIndex = index;
            itemScrollController.scrollTo(
              index: index - 3,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
            );
          }
          break;
        }
      }
    });
  }

  Widget _buildLyricText(String text, DateTime time, DateTime currentTime) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        text,
        style: TextStyle(
          color: time.isAfter(currentTime) ? AppColors.bg : Colors.white,
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.playerController.music!.lyricsBgColor;

    return GetBuilder<PlayerController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          surfaceTintColor: bgColor,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Row(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 50,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.expand_more,
                    size: 35,
                  ),
                ),
              ),
              Spacer(),
              Column(
                children: [
                  Text(
                    widget.playerController.music!.name,
                    style: context.bodyMedium
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    widget.playerController.music!.artistName.toUpperCase(),
                    style: context.bodyMedium,
                  )
                ],
              ),
              Spacer(),
              SizedBox(
                  width: 50,
                  child: IconButton(onPressed: () {}, icon: Icon(Icons.flag))),
            ],
          ),
          // actions: [AppConstant.appPadding.toInt().horizontalSpace],
        ),
        backgroundColor: bgColor,
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0)
                    .copyWith(top: 20, bottom: 20),
                child: Column(
                  children: [
                    Expanded(
                      child: StreamBuilder<Duration>(
                        stream: widget.playerController.position.stream,
                        builder: (context, snapshot) {
                          return ScrollablePositionedList.builder(
                            itemCount: widget.lyrics.length,
                            itemBuilder: (context, index) {
                              Duration duration =
                                  snapshot.data ?? const Duration(seconds: 0);
                              final currentLyricTime =
                                  DateTime(1970, 1, 1).copyWith(
                                hour: duration.inHours,
                                minute: duration.inMinutes.remainder(60),
                                second: duration.inSeconds.remainder(60),
                              );
                              return GestureDetector(
                                onTap: () {
                                  widget.playerController.seekByDuration(
                                      widget.lyrics[index].time);
                                },
                                child: _buildLyricText(
                                  widget.lyrics[index].text,
                                  DateTime(1970, 1, 1)
                                      .add(widget.lyrics[index].time),
                                  currentLyricTime,
                                ),
                              );
                            },
                            itemScrollController: itemScrollController,
                            itemPositionsListener: itemPositionsListener,
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            bgColor,
                            bgColor.withValues(alpha: 0.0),
                            bgColor.withValues(alpha: 0.0),
                          ],
                        ),
                      ),
                      child: PlayerControllerWidget(
                          centerIconColor: bgColor,
                          minimized: true,
                          controller: widget.playerController),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: IgnorePointer(
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          bgColor,
                          bgColor.withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

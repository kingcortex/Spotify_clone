import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:spotify_clone/controller/player_controller.dart';
import 'package:spotify_clone/pages/player_page.dart';
import 'package:spotify_clone/theme/app_colors.dart';
import 'package:spotify_clone/theme/text_theme.dart';
import 'package:spotify_clone/utils/extention.dart';

class NowPlayingBarWidget extends StatelessWidget {
  const NowPlayingBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlayerController>(
      builder: (controller) {
        return GestureDetector(
          onTap: () {
            showPlayerPage(context);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: controller.music!.playNowColor,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: AppColors.containerColor,
                              image: DecorationImage(
                                image: AssetImage(controller.music!.coverPath),
                              ),
                            ),
                          ),
                          7.horizontalSpace,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.music!.name,
                                style: context.bodyMedium.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                controller.music!.artistName,
                                style: context.bodyMedium.copyWith(
                                  fontSize: 13,
                                  color: AppColors.lowWhite,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      Obx(
                        () => GestureDetector(
                          onTap: () {
                            if (!controller.isPlaying.value) {
                              controller.play();
                            } else {
                              controller.pause();
                            }
                          },
                          child: Icon(
                            controller.isPlaying.value
                                ? Icons.pause
                                : Icons.play_arrow,
                            size: 30,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                //Spacer(),
                Obx(
                  () => SizedBox(
                    height: 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        color: Color(0xffB2B2B2),
                        value: controller.position.value.inMilliseconds /
                            controller.duration.value.inMilliseconds,
                        backgroundColor:
                            Color(0xffB2B2B2).withValues(alpha: .2),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class NowPlayingAppBarWidget extends StatelessWidget {
  final double paddingTop;
  final dynamic onTap;
  const NowPlayingAppBarWidget({
    super.key,
    required this.paddingTop,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GetBuilder<PlayerController>(
        builder: (controller) {
          return Container(
            padding: EdgeInsets.only(top: paddingTop, left: 10, right: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: controller.music!.playNowColor,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: AppColors.containerColor,
                          image: DecorationImage(
                            image: AssetImage(controller.music!.coverPath),
                          ),
                        ),
                      ),
                      7.horizontalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.music!.name,
                            style: context.bodyMedium.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            controller.music!.artistName,
                            style: context.bodyMedium.copyWith(
                              fontSize: 13,
                              color: AppColors.lowWhite,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        children: AnimateList(
                          delay: 200.ms,
                          //autoPlay: false,
                          interval: 100.ms,
                          effects: [
                            SlideEffect(
                              duration: 200.ms,
                              begin: Offset(1, 0),
                              end: Offset.zero,
                            )
                          ],
                          children: [
                            Icon(
                              Icons.add_circle_outline,
                              size: 30,
                            ),
                            25.horizontalSpace,
                            Obx(
                              () => GestureDetector(
                                onTap: () {
                                  if (!controller.isPlaying.value) {
                                    controller.play();
                                  } else {
                                    controller.pause();
                                  }
                                },
                                child: Icon(
                                  controller.isPlaying.value
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Obx(
                      () => LinearProgressIndicator(
                        color: Color(0xffB2B2B2),
                        value: controller.duration.value.inMilliseconds == 0
                            ? 0
                            : controller.position.value.inMilliseconds /
                                controller.duration.value.inMilliseconds,
                        backgroundColor:
                            Color(0xffB2B2B2).withValues(alpha: .2),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

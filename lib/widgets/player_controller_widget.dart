import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:spotify_clone/controller/player_controller.dart';
import 'package:spotify_clone/theme/app_colors.dart';
import 'package:spotify_clone/theme/text_theme.dart';
import 'package:spotify_clone/utils/const.dart';
import 'package:spotify_clone/utils/extention.dart';
import 'package:spotify_clone/utils/utils.dart';

import '../utils/assets.dart';

class PlayerControllerWidget extends StatefulWidget {
  final PlayerController controller;
  final bool minimized;
  final Color? centerIconColor;
  const PlayerControllerWidget({
    super.key,
    required this.controller,
    this.minimized = false,
    this.centerIconColor,
  });

  @override
  State<PlayerControllerWidget> createState() => _PlayerControllerWidgetState();
}

class _PlayerControllerWidgetState extends State<PlayerControllerWidget> {
  double _currentSliderValue = 0.0;
  bool _sliding = false;

  @override
  void initState() {
    super.initState();
    _currentSliderValue = Utils.calculateSliderValue(
      widget.controller.position.value,
      widget.controller.duration.value,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 4.0,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.5),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 10.0),
          ),
          child: Obx(
            () {
              if (!_sliding) {
                _currentSliderValue = Utils.calculateSliderValue(
                    widget.controller.position.value,
                    widget.controller.duration.value);
              }
              return Slider(
                value: _currentSliderValue,
                max: 1,
                onChangeStart: (value) {
                  setState(() {
                    _sliding = true;
                  });
                },
                onChanged: (value) {
                  setState(() {
                    _currentSliderValue = value;
                  });
                },
                onChangeEnd: (value) {
                  setState(() {
                    _sliding = false;
                  });
                  widget.controller.seek(value);
                },
                activeColor: Colors.white,
                inactiveColor: Colors.white24,
              );
            },
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: AppConstant.appPadding),
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Utils.formatDuration(widget.controller.position.value),
                  style: context.bodySmall,
                ),
                Text(
                  Utils.formatRemaining(widget.controller.position.value,
                      widget.controller.duration.value),
                  style: context.bodySmall,
                ),
              ],
            ),
          ),
        ),
        if (!widget.minimized) 15.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (widget.minimized)
              Opacity(
                opacity: 0,
                child: IgnorePointer(
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.ios_share_outlined, color: Colors.white),
                  ),
                ),
              ),
            if (!widget.minimized) ...[
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  AppIcons.shuffle,
                  width: 30,
                  colorFilter: Utils.getColorFilter(AppColors.white),
                ),
              ),
              20.horizontalSpace,
              IconButton(
                onPressed: () {
                  widget.controller.previous();
                },
                icon: Icon(Icons.skip_previous, color: Colors.white, size: 36),
              ),
              20.horizontalSpace,
            ],
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Obx(
                () => IconButton(
                  onPressed: () {
                    if (!widget.controller.isPlaying.value) {
                      widget.controller.play();
                    } else {
                      widget.controller.pause();
                    }
                  },
                  icon: Icon(
                      widget.controller.isPlaying.value
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: widget.centerIconColor ?? Color(0xff550A1C),
                      size: 36),
                ),
              ),
            ),
            if (!widget.minimized) ...[
              20.horizontalSpace,
              IconButton(
                onPressed: () {
                  widget.controller.next();
                },
                icon: Icon(Icons.skip_next, color: Colors.white, size: 36),
              ),
              20.horizontalSpace,
            ],
            if (!widget.minimized)
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(AppIcons.repeat),
              )
            else
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.ios_share_outlined,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

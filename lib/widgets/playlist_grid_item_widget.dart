import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_clone/models/media_item.dart';
import 'package:spotify_clone/theme/app_colors.dart';
import 'package:spotify_clone/theme/text_theme.dart';
import 'package:spotify_clone/utils/assets.dart';

class PlaylistGridItemWidget extends StatelessWidget {
  final Playlist item;
  final bool isLikedSongs;
  const PlaylistGridItemWidget({
    super.key,
    required this.isLikedSongs,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.containerColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isLikedSongs ? null : AppColors.primary,
                gradient: isLikedSongs
                    ? LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0, .45, 1.0],
                        colors: [
                          Color(0xff3B06EB),
                          Color(0xff796DE0),
                          Color(0xffCAEDD9)
                        ],
                      )
                    : null,
                image: isLikedSongs
                    ? null
                    : DecorationImage(
                        image: AssetImage(item.coverPath),
                        fit: BoxFit.cover,
                      ),
              ),
              child: isLikedSongs ? SvgPicture.asset(AppIcons.heart) : null,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 10),
              color: AppColors.containerColor,
              child: Text(
                isLikedSongs ? "Liked soungs" : item.name,
                style: context.bodyMedium.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

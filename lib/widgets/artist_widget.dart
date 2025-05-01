import 'package:flutter/material.dart';
import 'package:spotify_clone/models/media_item.dart';
import 'package:spotify_clone/theme/app_colors.dart';
import 'package:spotify_clone/theme/text_theme.dart';
import 'package:spotify_clone/utils/extention.dart';

class ArtistWidget extends StatelessWidget {
  final Artist artist;
  const ArtistWidget({
    super.key,
    required this.artist,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Container(
            height: 155,
            width: 155,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.containerColor,
                image: artist.coverPath.isEmpty
                    ? null
                    : DecorationImage(image: AssetImage(artist.coverPath))),
          ),
          5.verticalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(artist.name, style: context.titleSmall),
              ],
            ),
          )
        ],
      ),
    );
  }
}

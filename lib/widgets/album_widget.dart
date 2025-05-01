import 'package:flutter/material.dart';
import 'package:spotify_clone/models/media_item.dart';
import 'package:spotify_clone/theme/app_colors.dart';
import 'package:spotify_clone/theme/text_theme.dart';
import 'package:spotify_clone/utils/extention.dart';

class AlbumWidget extends StatelessWidget {
  final Album album;
  const AlbumWidget({
    super.key,
    required this.album,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 155,
            width: 155,
            decoration: BoxDecoration(
                color: AppColors.containerColor,
                borderRadius: BorderRadius.circular(5),
                image: album.coverPath.isEmpty
                    ? null
                    : DecorationImage(image: AssetImage(album.coverPath))),
          ),
          5.verticalSpace,
          Expanded(
            child: SizedBox(
              width: 155,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(),
                  if (album.name.isNotEmpty) ...[
                    Text(
                        overflow: TextOverflow.ellipsis,
                        album.name.toUpperCase(),
                        style: context.titleSmall),
                    2.verticalSpace,
                  ],
                  Text(
                    overflow: TextOverflow.ellipsis,
                    album.artistName,
                    style: context.bodySmall,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

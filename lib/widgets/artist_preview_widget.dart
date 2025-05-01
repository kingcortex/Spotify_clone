import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:spotify_clone/models/media_item.dart';
import 'package:spotify_clone/theme/app_colors.dart';
import 'package:spotify_clone/theme/text_theme.dart';
import 'package:spotify_clone/utils/const.dart';
import 'package:spotify_clone/utils/extention.dart';

class ArtistPreviewWidget extends StatelessWidget {
  final Artist artist;
  const ArtistPreviewWidget({
    super.key,
    required this.artist,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: AppConstant.appPadding * 1.5, vertical: 10),
      height: 370,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppConstant.containerRaduis),
        child: Column(
          children: [
            Expanded(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        artist.coverPath,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.all(AppConstant.appPadding),
                color: AppColors.containerColor,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              artist.name.toUpperCase(),
                              style: context.titleLarge,
                            ),
                            Text(
                              "42.9 mounthly listeners",
                              style: context.bodySmall.copyWith(
                                fontSize: 13,
                              ),
                            )
                          ],
                        ),
                        Spacer(),
                        OutlinedButton(
                            onPressed: () {},
                            child: Text(
                              "Follow",
                              style: context.bodyMedium,
                            ))
                      ],
                    ),
                    10.verticalSpace,
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          text:
                              "Usher's position at the forefront of R&B spans the post-new jack swing mid-'90s through the genre's flirtations with Afrobeats and amapiano. ",
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: 'see more',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

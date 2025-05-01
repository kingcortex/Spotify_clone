import 'package:flutter/material.dart';
import 'package:spotify_clone/models/media_item.dart';
import 'package:spotify_clone/theme/app_colors.dart';
import 'package:spotify_clone/theme/text_theme.dart';
import 'package:spotify_clone/utils/const.dart';
import 'package:spotify_clone/utils/extention.dart';
import 'package:spotify_clone/widgets/album_widget.dart';
import 'package:spotify_clone/widgets/artist_widget.dart';
import 'package:spotify_clone/widgets/playlist_grid_item_widget.dart';

final int _selectedFilter = 0;
List<MediaItem> _jumpBackList = [
  Album(coverPath: 'assets/images/muse.jpg', name: 'Muse', artistName: 'Bamby'),
  Artist(coverPath: 'assets/images/travis_pp.jpeg', name: 'Travis Scott'),
  Album(
      coverPath: 'assets/images/utopia.jpg',
      name: 'UTOPIA',
      artistName: 'Travis Scott'),
  Artist(coverPath: 'assets/images/ameka_zrai_pp.jpg', name: 'Ameka zrai'),
  Album(coverPath: 'assets/images/utopia.jpg', name: '', artistName: '')
];
List<Playlist> _playlistItems = [
  Playlist(coverPath: "assets/images/utopia.jpg", name: "UTOPIA"),
  Playlist(
      coverPath: "assets/images/Travis_Scott_SKELETONS.jpg",
      name: "ASTROWORLD"),
  Playlist(coverPath: "assets/images/ameka_zrai_pp.jpg", name: "Ameka Zrai"),
  Playlist(coverPath: "assets/images/pnl_pp.jpg", name: "PNL"),
  Playlist(coverPath: 'assets/images/did_pp.jpg', name: 'Didi B'),
  Playlist(coverPath: "assets/images/smoki_pp.jpg", name: "SMOKI DOOMS"),
  Playlist(coverPath: "assets/images/kid_cudi_pp.jpeg", name: "Kid Cudi"),
  Playlist(
      coverPath: "assets/images/Travis_Scott_SKELETONS.jpg",
      name: "ASTROWORLD"),
];

List<MediaItem> _uniquelyYoursList = [
  Album(
      coverPath: 'assets/images/big_aka_for.jpg',
      name: 'BIG AKA 4 AKA KAI',
      artistName: 'Himra'),
  Artist(coverPath: 'assets/images/smoki_pp.jpg', name: 'Smoki dooms'),
  Album(
      coverPath: 'assets/images/did_pp.jpg',
      name: 'DIYILEM & BAZARHOFF : GENIUS',
      artistName: 'Didi B'),
  Artist(coverPath: 'assets/images/kid_cudi_pp.jpeg', name: 'Kid Cudi'),
  Album(coverPath: '', name: '', artistName: '')
];

List<MediaItem> _editorPicks = [
  Album(
      coverPath: 'assets/images/piks_1.png',
      name: '',
      artistName: 'Ed Sheeran, Big Sean,\nJuice WRLD, Post Malone'),
  Album(
      coverPath: 'assets/images/piks_2.png',
      name: '',
      artistName: 'Mitski, Tame Impala,\nGlass Animals, Charli XCX'),
  Album(coverPath: 'assets/images/piks_3.png', name: '', artistName: '')
];

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppConstant.appPadding),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpace,
              SizedBox(
                height: MediaQuery.sizeOf(context).height * .3,
                child: _PlaylistGridView(),
              ),
              10.verticalSpace,
              ..._buildSectionWidget(context,
                  title: "Jump back in", medias: _jumpBackList),
              10.verticalSpace,
              ..._buildSectionWidget(context,
                  title: "Uniquely yours", medias: _uniquelyYoursList),
              10.verticalSpace,
              ..._buildSectionWidget(context,
                  title: "Editor’s picks", medias: _editorPicks),
              59.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildSectionWidget(
    BuildContext context, {
    required String title,
    required List<MediaItem> medias,
  }) {
    return [
      Text(
        title,
        style: context.headlineSmall,
      ),
      10.verticalSpace,
      SizedBox(
        height: 205,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final item = medias[index];
            if (item is Album) {
              return AlbumWidget(album: item);
            } else {
              return ArtistWidget(artist: item as Artist);
            }
          },
          separatorBuilder: (context, index) => 10.horizontalSpace,
          itemCount: medias.length,
        ),
      ),
    ];
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leadingWidth: 18 * 2,
      leading: UnconstrainedBox(
        child: CircleAvatar(
          radius: 18,
          child: Text(
            "S",
            style: context.bodyMedium
                .copyWith(color: AppColors.bg, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      title: Row(
        spacing: 8,
        children: List.generate(
          3,
          (index) => Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            alignment: Alignment.center,
            height: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: _selectedFilter == index
                  ? AppColors.primary
                  : AppColors.containerColor,
            ),
            child: Text(
              ["All", "Music", "Podcast"][index],
              style: context.bodyMedium.copyWith(
                color:
                    _selectedFilter == index ? AppColors.bg : AppColors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PlaylistGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: _playlistItems.length,
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 3.2,
      ),
      itemBuilder: (context, index) {
        return PlaylistGridItemWidget(
          isLikedSongs: index == 1,
          item: _playlistItems[index],
        );
      },
    );
  }
}

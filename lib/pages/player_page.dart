import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:spotify_clone/controller/lyrics_controller.dart';
import 'package:spotify_clone/controller/player_controller.dart';
import 'package:spotify_clone/theme/text_theme.dart';
import 'package:spotify_clone/utils/assets.dart';
import 'package:spotify_clone/utils/extention.dart';
import 'package:spotify_clone/widgets/artist_preview_widget.dart';
import 'package:spotify_clone/widgets/lyrics_preview_widget.dart';
import 'package:spotify_clone/widgets/now_playing_bar_widget.dart';
import 'package:spotify_clone/widgets/player_controller_widget.dart';
import '../theme/app_colors.dart';
import '../utils/const.dart';
import 'main_page.dart';

const kAnimationDuration = Duration(milliseconds: 300);

void showPlayerPage(BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) => const PlayerPage(),
  );
}

class PlayerPage extends StatefulWidget {
  const PlayerPage({super.key});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  bool _isPlayNowAppBar = false;
  bool _showBar = false;
  final ScrollController _scrollController = ScrollController();
  final _lyricsController = Get.find<LyricsController>();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    if (_scrollController.position.pixels > 400 && !_isPlayNowAppBar) {
      setState(() {
        _isPlayNowAppBar = true;
        _showBar = true;
      });
    } else if (_scrollController.position.pixels < 400 && _isPlayNowAppBar) {
      setState(() {
        _isPlayNowAppBar = false;
      });
      Future.delayed(kAnimationDuration, () {
        setState(() {
          _showBar = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          const BorderRadiusDirectional.vertical(top: Radius.circular(10)),
      child: GetBuilder<PlayerController>(builder: (controller) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: controller.music!.gradiantColor,
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Stack(
            children: [
              _buildContent(context, controller),
              _buildAnimatedAppBar(),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildContent(BuildContext context, PlayerController controller) {
    return ListView(
      controller: _scrollController,
      children: [
        safePaddingTop.toInt().verticalSpace,
        _buildAppBar(context, controller),
        30.verticalSpace,
        _buildAlbumArtAndInfo(context, controller),
        14.verticalSpace,
        _buildPlayerControls(controller),
        20.verticalSpace,
        _buildBottomActions(),
        _buildLyricsPreview(controller),
        18.verticalSpace,
        ArtistPreviewWidget(artist: controller.music!.artist),
      ],
    );
  }

  Widget _buildAppBar(BuildContext context, PlayerController controller) {
    return AppBar(
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: const Icon(Icons.expand_more, size: 35),
      ),
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Text(controller.music!.artistName.toUpperCase()),
      actions: [
        const Icon(Icons.more_horiz),
        AppConstant.appPadding.toInt().horizontalSpace,
      ],
    );
  }

  Widget _buildAlbumArtAndInfo(
      BuildContext context, PlayerController controller) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppConstant.appPadding * 1.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height * .42,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.containerColor,
              borderRadius: BorderRadius.circular(AppConstant.containerRaduis),
              image: DecorationImage(
                image: AssetImage(controller.music!.coverPath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          40.verticalSpace,
          Text(
            controller.music!.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          2.verticalSpace,
          Row(
            children: [
              _buildExplicitTag(controller),
              Text(
                controller.music!.artistName.toUpperCase(),
                style: const TextStyle(fontSize: 16, color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExplicitTag(PlayerController controller) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      alignment: Alignment.center,
      width: 15,
      height: 15,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: .3),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        "E",
        style: context.bodySmall.copyWith(
          color: controller.music!.playNowColor,
          height: -.1,
        ),
      ),
    );
  }

  Widget _buildPlayerControls(PlayerController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConstant.appPadding),
      child: PlayerControllerWidget(
        centerIconColor: controller
            .music!.gradiantColor[controller.music!.gradiantColor.length - 2],
        controller: controller,
      ),
    );
  }

  Widget _buildBottomActions() {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppConstant.appPadding + 10)
              .copyWith(bottom: 20),
      child: Row(
        children: [
          SvgPicture.asset(AppIcons.devices),
          const Spacer(),
          Icon(
            Icons.ios_share_outlined,
            size: 21,
            color: AppColors.white.withValues(alpha: .7),
          ),
          25.horizontalSpace,
          SvgPicture.asset(AppIcons.listPlaying, width: 26),
        ],
      ),
    );
  }

  Widget _buildLyricsPreview(PlayerController controller) {
    return Obx(
      () => _lyricsController.lyrics.isEmpty
          ? const SizedBox.shrink()
          : Container(
              padding: EdgeInsets.symmetric(
                  horizontal: AppConstant.appPadding * 1.5),
              height: MediaQuery.sizeOf(context).height * .38,
              child: LyricsPreviewWidget(
                playerController: controller,
                lyrics: _lyricsController.lyrics,
              ),
            ),
    );
  }

  Widget _buildAnimatedAppBar() {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      child: AnimatedSlide(
        offset: _isPlayNowAppBar ? Offset.zero : const Offset(0, -1),
        duration: kAnimationDuration,
        child: _showBar
            ? AnimatedOpacity(
                opacity: _isPlayNowAppBar ? 1.0 : 0.0,
                duration: kAnimationDuration,
                child: NowPlayingAppBarWidget(
                  onTap: () {
                    _scrollController.animateTo(
                      0.0,
                      duration: kAnimationDuration,
                      curve: Curves.easeInOut,
                    );
                  },
                  paddingTop: safePaddingTop,
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }
}

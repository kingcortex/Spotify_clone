import 'dart:ui';

import 'package:spotify_clone/models/media_item.dart';

class Music extends MediaItem {
  final String artistName;
  final String audioPath;
  final String lyricsPath;
  final Color playNowColor;
  final Color lyricsBgColor;
  final List<Color> gradiantColor;
  final Artist artist;

  Music({
    required super.coverPath,
    required this.artist,
    required super.name,
    required this.artistName,
    required this.audioPath,
    required this.lyricsPath,
    required this.playNowColor,
    required this.lyricsBgColor,
    required this.gradiantColor,
  });
}

var playlyst = [
  Music(
    artist:
        Artist(coverPath: 'assets/images/travis_pp.jpeg', name: 'Travis Scott'),
    playNowColor: Color(0xff1e384f),
    lyricsBgColor: Color(0xff3579b6),
    coverPath: 'assets/images/Travis_Scott_SKELETONS.jpg',
    name: 'SKELETONS',
    artistName: 'Travis Scott',
    audioPath: 'assets/audios/Travis_Scott_SKELETONS.mp3',
    lyricsPath: 'assets/lyrics/travis_scott_skeletons.lrc',
    gradiantColor: [Color(0xff1b2d3e), Color(0xff1f3d57), Color(0xff28557e)],
  ),
  Music(
    artist: Artist(coverPath: 'assets/images/pnl_pp.jpg', name: 'Pnl'),
    playNowColor: Color(0xff45102c),
    lyricsBgColor: Color(0xffd2378b),
    coverPath: 'assets/images/Jusquau_dernier_gramme.jpg',
    name: 'Jusquau dernier gramme',
    artistName: 'Pnl',
    audioPath: 'assets/audios/Jusquau_dernier_gramme.mp3',
    lyricsPath: 'assets/lyrics/Jusquau_dernier_gramme.lrc',
    gradiantColor: [Color(0xff351526), Color(0xff481832), Color(0xff631b42)],
  ),
  Music(
    artist: Artist(
        coverPath: 'assets/images/Tiken_Jah_Fakoly.jpg',
        name: 'Tiken Jah Fakoly'),
    playNowColor: Color(0xff60141e),
    lyricsBgColor: Color(0xffe71f3c),
    coverPath: 'assets/images/Africain__Paris.jpg',
    name: 'Africain à Paris',
    artistName: 'Tiken Jah Fakoly',
    audioPath: 'assets/audios/Tiken_Jah_Fakoly_Africain__Paris.mp3',
    lyricsPath: 'assets/lyrics/Tiken_Jah_Fakoly_Africain__Paris.lrc',
    gradiantColor: [Color(0xff45131a), Color(0xff60141e), Color(0xff901527)],
  ),
];

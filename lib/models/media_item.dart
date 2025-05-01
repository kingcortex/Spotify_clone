class MediaItem {
  final String coverPath;
  final String name;

  MediaItem({required this.coverPath, required this.name});
}

class Playlist extends MediaItem {
  Playlist({required super.coverPath, required super.name});
}

class Artist extends MediaItem {
  Artist({required super.coverPath, required super.name});
}

class Album extends MediaItem {
  final String artistName;

  Album(
      {required super.coverPath,
      required super.name,
      required this.artistName});
}

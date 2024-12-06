class SongModel {
  String? id;
  String? title;
  String? artist;

  num? duration;

  bool? favorite;
  String? releasedate;
  String? songfile;
  String? image;

  SongModel(
    this.id,
    this.title,
    this.artist,
    this.duration,
    this.favorite,
    this.releasedate,
    this.songfile,
    this.image,
  );

  factory SongModel.fromMapJson(Map<String, dynamic> jsonObject) {
    return SongModel(
      jsonObject['id'],
      jsonObject['title'],
      jsonObject['artist'],
      jsonObject['duration'],
      jsonObject['favorite'],
      jsonObject['releasedate'],
      'https://mpm.chbk.app/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['songfile']}',
      'https://mpm.chbk.app/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['image']}',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'duration': duration,
      'favorite': favorite,
      'releasedate': releasedate,
      'songfile': songfile,
      'image': image,
    };
  }
}

class SongModel {
  String? title;
  String? artist;

  num? duration;

  String? releasedate;
  String? songfile;
  String? image;

  SongModel(this.title, this.artist, this.duration, this.releasedate,
      this.songfile, this.image);

  factory SongModel.fromMapJson(Map<String, dynamic> jsonObject) {
    return SongModel(
      jsonObject['title'],
      jsonObject['artist'],
      jsonObject['duration'],
      jsonObject['releasedate'],
      'https://mpm.chbk.app/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['songfile']}',
      'https://mpm.chbk.app/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['image']}',
    );
  }
}

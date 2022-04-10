class Song {
  final int id;
  final String title;
  final int authorId;
  final String descriptionAuthor;
  String tone;
  String lyrics;
  final String mp3;
  //final List<int> files;

  Song({
    required this.id,
    required this.title,
    required this.authorId,
    required this.descriptionAuthor,
    required this.tone,
    required this.lyrics,
    required this.mp3,
    //required this.files,
  });

  factory Song.fromDynamic(dynamic data) {
    return Song(
      id: int.parse(data['id']),
      title: data['title'],
      authorId: int.parse(data['author']),
      descriptionAuthor: data['description_author'],
      tone: data['tone'],
      lyrics: data['lyric'],
      mp3: data['mp3'],
      //files: data['files'],
    );
  }
}

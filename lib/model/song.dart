class Song {
  final int id;
  final String title;
  final int authorId;
  final String descriptionAuthor;
  final String tone;
  final String lyrics;
  final String mp3;

  Song({
    required this.id,
    required this.title,
    required this.authorId,
    required this.descriptionAuthor,
    required this.tone,
    required this.lyrics,
    required this.mp3,
  });

  factory Song.fromDynamic(dynamic data) {
    return Song(
        id: int.parse(data['id']),
        title: data['title'],
        authorId: int.parse(data['author']),
        descriptionAuthor: data['description_author'],
        tone: data['tone'],
        lyrics: data['lyric'],
        mp3: data['mp3']);
  }
}

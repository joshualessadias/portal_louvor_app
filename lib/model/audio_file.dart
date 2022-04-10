class AudioFile {
  String id;
  String description;
  String mp3;
  Duration duration;

  AudioFile(this.id, this.description, this.mp3, this.duration);
}

class AudioFileResponse {
  int id;
  int idMusic;
  String description;
  String mp3;

  AudioFileResponse(this.id, this.idMusic, this.description, this.mp3);
}

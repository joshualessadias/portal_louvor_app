import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_louvor_app/components/constants.dart';
import 'package:portal_louvor_app/model/audio_file.dart';

abstract class AudioState {}

class AudioInitialState extends AudioState {}

class AudioLoadingState extends AudioState {}

class AudioSuccessState extends AudioState {
  final List<AudioPlayer> audioPlayerList;
  final List<AudioFile> audioFileList;

  AudioSuccessState(this.audioPlayerList, this.audioFileList);
}

class AudioFailState extends AudioState {}

class AudioBloc extends Cubit<AudioState> {
  AudioBloc() : super(AudioInitialState());

  void loadAudios(List<AudioFileResponse> _mockAudioFileResponse) async {
    emit(AudioLoadingState());

    final List<AudioPlayer> _audioPlayerList = [];
    final List<AudioFile> _audioFileList = [];

    final audioResponse = _mockAudioFileResponse.map((fileResponse) async {
      log('comecou a procurar');
      var mp3Path = fileResponse.mp3;

      if (mp3Path.isNotEmpty) {
        var url = '$kBaseUrl$mp3Path';
        AudioPlayer audioPlayer = AudioPlayer();
        var audioPlayerId = audioPlayer.playerId;

        try {
          int res = await audioPlayer.setUrl(url);

          if (res == 1) {
            _audioPlayerList.add(audioPlayer);

            _audioPlayerList.last.onDurationChanged.listen((duration) {
              _audioFileList.add(AudioFile(
                audioPlayerId,
                fileResponse.description,
                fileResponse.mp3,
                duration,
              ));
            });
          } else {
            return emit(AudioFailState());
          }
          return Future.value();
        } catch (_) {
          return emit(AudioFailState());
        }
      }
    });

    await Future.wait(audioResponse);

    log('acabou');

    return emit(AudioSuccessState(_audioPlayerList, _audioFileList));
  }

  void disposeAudioPlayer() async {
    if (state is! AudioSuccessState) return;

    await Future.wait(
        (state as AudioSuccessState).audioPlayerList.map((audioPlayer) async {
      await audioPlayer.dispose();
      return audioPlayer;
    }).toList());

    emit(AudioSuccessState([], (state as AudioSuccessState).audioFileList));
  }
}

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:portal_louvor_app/model/song.dart';
import 'package:portal_louvor_app/modules/home_page/songs_body/song_detail/audio_expansion/index.dart';
import 'package:portal_louvor_app/modules/home_page/songs_body/song_detail/blocs/audio_bloc.dart';
import 'package:portal_louvor_app/modules/home_page/songs_body/song_detail/font_size_expansion/index.dart';
import 'package:portal_louvor_app/modules/home_page/songs_body/song_detail/tone_expansion/index.dart';

class SongPageDrawer extends StatefulWidget {
  const SongPageDrawer({
    Key? key,
    required this.statusBarHeight,
    required this.song,
    required this.fontSize,
    required this.audioBloc,
  }) : super(key: key);

  final double statusBarHeight;
  final Song song;
  final double fontSize;
  final AudioBloc audioBloc;

  @override
  State<SongPageDrawer> createState() => _SongPageDrawerState();
}

class _SongPageDrawerState extends State<SongPageDrawer> {
  void _onAudioTileTap(String fileAudioPlayerId) {
    Navigator.pop(context);

    AudioPlayer.players.forEach((audioPlayerId, audioPlayer) {
      audioPlayer.stop();

      if (audioPlayerId == fileAudioPlayerId) {
        // var audioFileToPlay = _getAudioFromPlayer(audioPlayer);

        setState(() {
          // _audioPlayerToPlay = audioPlayer;
          // _audioTitle = audioFileToPlay.description;
          // _audioTotalDuration = audioFileToPlay.duration;
        });

        audioPlayer.resume();
      }
    });

    // if (!_isPlayerOpened) {
    //   setState(() {
    //     _audioPlayerYPosition = 0;
    //     _isPlayerOpened = true;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(height: widget.statusBarHeight),
          ToneExpansionWidget(
            tone: widget.song.tone,
            onToneDown: () {
              // _handleOnToneDown();
            },
            onToneUp: () {
              // _handleOnToneUp();
            },
            onToneRestore: () {
              // _handleOnToneRestore();
            },
            onChangeTone: (newTone) {
              // _handleOnChangeTone(newTone);
            },
          ),
          FontSizeExpansionWidget(
            onIncreaseFontSize: () {
              if (widget.fontSize < 30.0) {
                // _incrementFontSize();
              }
            },
            onDecreaseFontSize: () {
              if (widget.fontSize > 6.0) {
                // _decrementFontSize();
              }
            },
            onRestoreFontSize: () {
              // _restoreFontSize();
            },
          ),
          AudioExpansionWidget(
            audioBloc: widget.audioBloc,
            onAudioTap: (fileAudioPlayerId) {
              _onAudioTileTap(fileAudioPlayerId);
            },
          ),
        ],
      ),
    );
  }
}

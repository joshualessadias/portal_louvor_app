import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:portal_louvor_app/components/constants.dart';
import 'package:portal_louvor_app/utils/duration.dart';

class MyAudioPlayer extends StatefulWidget {
  const MyAudioPlayer({
    Key? key,
    required this.playerHeight,
    required this.audioPlayerYPosition,
    required this.closeAudioPlayer,
    required this.audioPlayer,
    required this.audioTitle,
    required this.audioTotalDuration,
  }) : super(key: key);

  final double playerHeight;
  final double audioPlayerYPosition;
  final VoidCallback? closeAudioPlayer;
  final AudioPlayer audioPlayer;
  final String audioTitle;
  final Duration audioTotalDuration;

  @override
  State<MyAudioPlayer> createState() => _MyAudioPlayerState();
}

class _MyAudioPlayerState extends State<MyAudioPlayer> {
  var _isPlaying = true;
  var _audioPosition = const Duration();

  void _audioPlayerSetup(AudioPlayer audioPlayer) {
    if (mounted) {
      audioPlayer.onAudioPositionChanged.listen((Duration newPosition) {
        setState(() {
          _audioPosition = newPosition;
        });
      });

      audioPlayer.onPlayerCompletion.listen((event) {
        audioPlayer.stop();

        setState(() {
          _isPlaying = false;
        });
      });
    }
  }

  void _listenAudioPlayerState(AudioPlayer audioPlayer) {
    audioPlayer.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.PLAYING) {
        setState(() {
          _isPlaying = true;
        });
      } else {
        setState(() {
          _isPlaying = false;
        });
      }
    });
  }

  void _stopAudio(AudioPlayer audioPlayer) {
    audioPlayer.stop();

    setState(() {
      _audioPosition = const Duration();
    });

    _listenAudioPlayerState(audioPlayer);
  }

  void _playAudio(AudioPlayer audioPlayer) {
    audioPlayer.resume();
  }

  void _pauseAudio(AudioPlayer audioPlayer) {
    audioPlayer.pause();
  }

  void _playPauseAudio(AudioPlayer audioPlayer) {
    if (_isPlaying) {
      _pauseAudio(audioPlayer);
    } else {
      _playAudio(audioPlayer);
    }

    _listenAudioPlayerState(audioPlayer);
  }

  @override
  Widget build(BuildContext context) {
    _audioPlayerSetup(widget.audioPlayer);

    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
      transform: Matrix4.translationValues(0, widget.audioPlayerYPosition, 0),
      height: widget.playerHeight,
      decoration: const BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.audioTitle,
                  style: TextStyle(
                      color: kWhite, fontSize: 15, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 20,
                  width: 20,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.close,
                    ),
                    iconSize: 20,
                    color: kWhite,
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    disabledColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      _stopAudio(widget.audioPlayer);
                      widget.closeAudioPlayer?.call();
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                  ),
                  iconSize: 45,
                  color: kWhite,
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  disabledColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    _playPauseAudio(widget.audioPlayer);
                  },
                ),
                Text(
                  DurationUtils.toFormattedString(_audioPosition),
                  style: TextStyle(color: kWhite),
                ),
                Expanded(
                  child: Slider.adaptive(
                    min: 0.0,
                    value: _audioPosition.inSeconds.toDouble(),
                    max: widget.audioTotalDuration.inSeconds.toDouble(),
                    onChanged: (double newValue) {
                      setState(() {
                        widget.audioPlayer
                            .seek(Duration(seconds: newValue.toInt()));
                      });
                    },
                    activeColor: kWhite,
                    inactiveColor: kWhite.withOpacity(0.3),
                  ),
                ),
                Text(
                  DurationUtils.toFormattedString(widget.audioTotalDuration),
                  style: TextStyle(color: kWhite),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

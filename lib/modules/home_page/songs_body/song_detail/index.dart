import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:portal_louvor_app/components/constants.dart';
import 'package:portal_louvor_app/model/audio_file.dart';
import 'package:portal_louvor_app/model/song.dart';
import 'package:portal_louvor_app/utils/duration.dart';
import 'audio_expansion/index.dart';
import 'package:flutter_chord/flutter_chord.dart';
import 'package:chord_transposer/chord_transposer.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:portal_louvor_app/utils/snackbar.dart';

import 'font_size_expansion/index.dart';
import 'tone_expansion/index.dart';

class SongDetailPage extends StatefulWidget {
  const SongDetailPage(this._originalSong, {Key? key}) : super(key: key);

  final Song _originalSong;

  @override
  State<SongDetailPage> createState() => _SongDetailPageState();
}

class _SongDetailPageState extends State<SongDetailPage> {
//   final Song _mockOriginalSong = Song(
//     id: 0,
//     title: 'VIVO EM NÓS',
//     authorId: 1,
//     descriptionAuthor: 'DIANTE DO TRONO',
//     tone: 'G',
//     lyrics: '''
// [C     ][G     ][Em7     ][C]
// [G]Teu grande amor, Todos vão ca[Em7]ntar
// Todos vão cant[D]ar, [G]Vieste aqui
// Esperança [Em7]dar, Forças renov[D]ar

// Só Tu, Senh[C]or, És O [Em7]caminho[D]
// Só Tu, Senh[C]or, És O [Em7]caminho[D]

// Tu [C]és Jesu[G]s, o S[Em7]alvador[D]
// És [C]Rei, S[G]enhor, [Em7]És Venc[D]edor
// Teu [G]nome [C]vamos[Em7] exalt[D]ar
// [G]Cristo, [C]Cristo
// [Em7]Vivo em [D]nós

// [C     ][G     ][Em7     ][C]
// [G]Brilhas mais que o Sol
// Glorioso [Em7]És, Glorioso [D]És
// Senhor e [G]Rei, Tudo vem de Ti[Em7]
// És nova vida em [D]mim

// Em tudo [C]És e[Em7]xalta[D]do
// Em tudo [C]És [Em7]exalta[D]do

// Tu [C]és Jesu[G]s, o S[Em7]alvador[D]
// És [C]Rei, S[G]enhor, [Em7]És Venc[D]edor
// Teu [G]nome v[C]amos[Em7] exalt[D]ar
// [G]Cristo, [C]Cristo
// [Em7]Vivo em [D]nós

// [C     ][G     ][Em7     ][D]
// Vie[C]ste o inimigo p[G]isar
// E nos li[Em7]vrar, e nos livr[D]ar
// O Am[C]or venceu a morte na [G]cruz
// És Venced[Em7]or, és Venced[D]or!

// Tu [C]és Jesu[G]s, o S[Em7]alvador[D]
// És [C]Rei, S[G]enhor, [Em7]És Venc[D]edor
// Teu [G]nome v[C]amos [Em7]exalta[D]r
// [G]Cristo, [C]Cristo
// [Em7]Vivo em [D]nós  2X

// [G]Cristo, [C]Cristo
// [Em7]Vivo em [D]nós [C]
// ''',
//     mp3: '',
//   );
  final List<AudioFileResponse> _mockAudioFileResponse = [
    AudioFileResponse(
      1,
      1,
      'Principal',
      '/files/mp3/247/d3f73c71b0393d5964a95909a6251e1d.mp3',
    ),
    AudioFileResponse(
      2,
      2,
      'Tenor',
      '/files/mp3/13/a3f8e5da50c25f89e4228d792e93d3b1.mp3',
    ),
  ];
  final List<AudioFile> _mockAudioFileList = [];
  final List<AudioPlayer> _audioPlayerList = [];

  late Song _songToShow;
  late double _fontSize;
  late double _audioPlayerYPosition;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final transposer = ChordTransposer();
  final _playerHeight = 105.0;

  var _isPlayerOpened = false;
  var _isPlaying = false;
  var _audioPosition = const Duration();
  var _audioTotalDuration = const Duration();
  var _audioTitle = '';

  var _audioPlayerToPlay = AudioPlayer();

  void _getAudioInfo() async {
    _audioPlayerList.clear();

    for (var fileResponse in _mockAudioFileResponse) {
      var mp3Path = fileResponse.mp3;

      if (mp3Path.isNotEmpty) {
        var url = '$kBaseUrl$mp3Path';
        AudioPlayer audioPlayer = AudioPlayer();
        var audioPlayerId = audioPlayer.playerId;

        var result = await audioPlayer.setUrl(url);

        if (result == 1) {
          _audioPlayerList.add(audioPlayer);

          _audioPlayerList.last.onDurationChanged.listen((duration) {
            _mockAudioFileList.add(AudioFile(
              audioPlayerId,
              fileResponse.description,
              fileResponse.mp3,
              duration,
            ));
          });
        } else {
          var description = fileResponse.description;
          SnackBarUtils.myShowSnackBar(
              context, 'Ocorreu um erro ao baixar áudio "$description"');
          return;
        }
      } else {
        SnackBarUtils.myShowSnackBar(context, 'Áudio não encontrado');
        return;
      }
    }
  }

  void _handleOnToneDown() {
    String _newTone =
        transposer.chordDown(chord: _songToShow.tone, semitones: 1);
    if (_newTone == 'Gb') {
      _newTone = 'F#';
    }
    setState(() {
      _songToShow.lyrics =
          transposer.lyricsDown(lyrics: _songToShow.lyrics, semitones: 1);
      _songToShow.tone = _newTone;
    });
  }

  void _handleOnToneUp() {
    String _newTone = transposer.chordUp(chord: _songToShow.tone, semitones: 1);
    if (_newTone == 'Gb') {
      _newTone = 'F#';
    }
    setState(() {
      _songToShow.lyrics =
          transposer.lyricsUp(lyrics: _songToShow.lyrics, semitones: 1);
      _songToShow.tone = _newTone;
    });
  }

  void _handleOnToneRestore() {
    String _newTone = transposer.chordToKey(
        chord: _songToShow.tone,
        fromKey: _songToShow.tone,
        toKey: widget._originalSong.tone);
    if (_newTone == 'Gb') {
      _newTone = 'F#';
    }
    setState(() {
      _songToShow.lyrics = transposer.lyricsToKey(
          lyrics: _songToShow.lyrics,
          fromKey: _songToShow.tone,
          toKey: _newTone);
      _songToShow.tone = _newTone;
    });
  }

  void _handleOnChangeTone(String _newTone) {
    if (_newTone == 'Gb') {
      _newTone = 'F#';
    }
    setState(() {
      _songToShow.lyrics = transposer.lyricsToKey(
          lyrics: _songToShow.lyrics,
          fromKey: _songToShow.tone,
          toKey: _newTone);
      _songToShow.tone = _newTone;
    });
  }

  void _playAudio(AudioPlayer audioPlayer) {
    log('play');
    audioPlayer.resume();

    setState(() {
      _isPlaying = true;
    });
  }

  void _pauseAudio(AudioPlayer audioPlayer) {
    log('pause');
    audioPlayer.pause();

    setState(() {
      _isPlaying = false;
    });
  }

  void _playPauseAudio(AudioPlayer audioPlayer) {
    log('play/pause');
    if (_isPlaying) {
      _pauseAudio(audioPlayer);
    } else {
      _playAudio(audioPlayer);
    }

    audioPlayer.onAudioPositionChanged.listen((Duration newPosition) {
      setState(() {
        _audioPosition = newPosition;
      });
    });

    audioPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        audioPlayer.stop();
        _isPlaying = false;
      });
    });
  }

  AudioFile _getAudioFromPlayer(AudioPlayer _audioPlayerToPlay) {
    var audioFileToReturn = _mockAudioFileList.first;

    for (var audioFile in _mockAudioFileList) {
      if (audioFile.id == _audioPlayerToPlay.playerId) {
        audioFileToReturn = audioFile;
      }
    }

    return audioFileToReturn;
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_rounded),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Text(
        widget._originalSong.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15.0),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            _scaffoldKey.currentState?.openEndDrawer();
          },
          icon: const Icon(Icons.menu_rounded),
        ),
      ],
    );
  }

  AnimatedContainer _buildAudioPlayer() {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
      transform: Matrix4.translationValues(0, _audioPlayerYPosition, 0),
      height: _playerHeight,
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
                  _audioTitle,
                  style: TextStyle(
                      color: kWhite, fontSize: 15, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 20,
                  width: 20,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      setState(() {
                        _isPlaying = false;
                        _audioPlayerYPosition = _playerHeight + 1.0;
                        _isPlayerOpened = false;
                        _audioPlayerToPlay.stop();
                      });
                    },
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
                    _playPauseAudio(_audioPlayerToPlay);
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
                    max: _audioTotalDuration.inSeconds.toDouble(),
                    onChanged: (double newValue) {
                      setState(() {
                        _audioPlayerToPlay
                            .seek(Duration(seconds: newValue.toInt()));
                      });
                    },
                    activeColor: kWhite,
                    inactiveColor: kWhite.withOpacity(0.3),
                  ),
                ),
                Text(
                  DurationUtils.toFormattedString(_audioTotalDuration),
                  style: TextStyle(color: kWhite),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 8.0,
            right: 8.0,
            top: 8.0,
            bottom: _isPlayerOpened ? _playerHeight : 0.0,
          ),
          child: LyricsRenderer(
            lyrics: _songToShow.lyrics,
            textStyle: TextStyle(fontSize: _fontSize, color: Colors.black),
            chordStyle: TextStyle(
              fontSize: _fontSize + 1,
              color: kSecondaryColor,
            ),
            onTapChord: () {},
            transposeIncrement: 0,
            showChord: true,
            scrollSpeed: 0,
            widgetPadding: 47,
          ),
        ),
        _buildAudioPlayer(),
      ],
    );
  }

  void _onAudioTileTap(String fileAudioPlayerId) {
    Navigator.pop(context);

    AudioPlayer.players.forEach((audioPlayerId, audioPlayer) {
      if (audioPlayerId == fileAudioPlayerId) {
        var audioFileToPlay = _getAudioFromPlayer(audioPlayer);

        _playPauseAudio(audioPlayer);

        setState(() {
          _audioPlayerToPlay = audioPlayer;
          _audioTitle = audioFileToPlay.description;
          _audioTotalDuration = audioFileToPlay.duration;
        });
      }
    });

    if (!_isPlayerOpened) {
      setState(() {
        _audioPlayerYPosition = 0;
        _isPlayerOpened = true;
      });
    }
  }

  Drawer _buildDrawer() {
    double _staturBarHeight = MediaQuery.of(context).padding.top;

    return Drawer(
      child: Column(
        children: [
          SizedBox(height: _staturBarHeight),
          ToneExpansionWidget(
            tone: _songToShow.tone,
            onToneDown: () {
              _handleOnToneDown();
            },
            onToneUp: () {
              _handleOnToneUp();
            },
            onToneRestore: () {
              _handleOnToneRestore();
            },
            onChangeTone: (newTone) {
              _handleOnChangeTone(newTone);
            },
          ),
          FontSizeExpansionWidget(
            onIncreaseFontSize: () {
              if (_fontSize < 30.0) {
                setState(() {
                  _fontSize++;
                });
              }
            },
            onDecreaseFontSize: () {
              if (_fontSize > 6.0) {
                setState(() {
                  _fontSize--;
                });
              }
            },
            onRestoreFontSize: () {
              setState(() {
                _fontSize = 16.0;
              });
            },
          ),
          AudioExpansionWidget(
            files: _mockAudioFileList,
            onAudioTap: (fileAudioPlayerId) {
              _onAudioTileTap(fileAudioPlayerId);
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    for (var audioPlayer in _audioPlayerList) {
      audioPlayer.dispose();
    }
    _audioPlayerList.clear();
    super.dispose();
  }

  @override
  initState() {
    _songToShow = widget._originalSong;
    _fontSize = 16.0;
    _audioPlayerYPosition = _playerHeight + 1.0;
    _getAudioInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(context),
      body: _buildBody(),
      endDrawer: _buildDrawer(),
      endDrawerEnableOpenDragGesture: false,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:portal_louvor_app/components/constants.dart';
import 'package:portal_louvor_app/model/song.dart';
import 'audio_list/index.dart';
import 'package:flutter_chord/flutter_chord.dart';
import 'package:chord_transposer/chord_transposer.dart';

import 'font_size_expansion/index.dart';
import 'tone_expansion/index.dart';

class SongDetailPage extends StatefulWidget {
  const SongDetailPage(this._originalSong, {Key? key}) : super(key: key);

  final Song _originalSong;

  @override
  State<SongDetailPage> createState() => _SongDetailPageState();
}

class _SongDetailPageState extends State<SongDetailPage> {
  final Song _mockOriginalSong = Song(
      id: 0,
      title: 'VIVO EM NÓS',
      authorId: 1,
      descriptionAuthor: 'DIANTE DO TRONO',
      tone: 'G',
      lyrics: '''
[C     ][G     ][Em7     ][C]
[G]Teu grande amor, Todos vão ca[Em7]ntar
Todos vão cant[D]ar, [G]Vieste aqui
Esperança [Em7]dar, Forças renov[D]ar

Só Tu, Senh[C]or, És O [Em7]caminho[D]
Só Tu, Senh[C]or, És O [Em7]caminho[D]

Tu [C]és Jesu[G]s, o S[Em7]alvador[D]
És [C]Rei, S[G]enhor, [Em7]És Venc[D]edor
Teu [G]nome [C]vamos[Em7] exalt[D]ar
[G]Cristo, [C]Cristo
[Em7]Vivo em [D]nós

[C     ][G     ][Em7     ][C]
[G]Brilhas mais que o Sol
Glorioso [Em7]És, Glorioso [D]És
Senhor e [G]Rei, Tudo vem de Ti[Em7]
És nova vida em [D]mim

Em tudo [C]És e[Em7]xalta[D]do
Em tudo [C]És [Em7]exalta[D]do

Tu [C]és Jesu[G]s, o S[Em7]alvador[D]
És [C]Rei, S[G]enhor, [Em7]És Venc[D]edor
Teu [G]nome v[C]amos[Em7] exalt[D]ar
[G]Cristo, [C]Cristo
[Em7]Vivo em [D]nós

[C     ][G     ][Em7     ][D]
Vie[C]ste o inimigo p[G]isar
E nos li[Em7]vrar, e nos livr[D]ar
O Am[C]or venceu a morte na [G]cruz
És Venced[Em7]or, és Venced[D]or!

Tu [C]és Jesu[G]s, o S[Em7]alvador[D]
És [C]Rei, S[G]enhor, [Em7]És Venc[D]edor
Teu [G]nome v[C]amos [Em7]exalta[D]r
[G]Cristo, [C]Cristo
[Em7]Vivo em [D]nós  2X

[G]Cristo, [C]Cristo
[Em7]Vivo em [D]nós [C]
''',
      mp3: 'mp3');

  late Song _songToShow;
  late double _fontSize;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final transposer = ChordTransposer();

  void _showAudioListModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return const BottomAudioList();
      },
    );
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
        ]);
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
      child: LyricsRenderer(
        lyrics: _songToShow.lyrics,
        textStyle: TextStyle(fontSize: _fontSize, color: Colors.black),
        chordStyle: TextStyle(fontSize: _fontSize + 1, color: kSecondaryColor),
        onTapChord: () {},
        transposeIncrement: 0,
        showChord: true,
        scrollSpeed: 0,
        widgetPadding: 47,
      ),
    );
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
          )
        ],
      ),
    );
  }

  @override
  initState() {
    super.initState();
    _songToShow = _mockOriginalSong;
    _fontSize = 16.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(context),
      body: _buildBody(),
      endDrawer: _buildDrawer(),
      endDrawerEnableOpenDragGesture: true,
    );
  }
}

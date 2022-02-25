import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portal_louvor_app/components/constants.dart';
import 'package:portal_louvor_app/model/song.dart';
import 'package:portal_louvor_app/modules/home_page/songs_body/index.dart';

class SongSearchPage extends StatefulWidget {
  const SongSearchPage({Key? key}) : super(key: key);

  @override
  State<SongSearchPage> createState() => _SongSearchPageState();
}

TextEditingController editingController = TextEditingController();

class _SongSearchPageState extends State<SongSearchPage> {
  final List<Song> _mockSongs = [
    Song(0, 'Lugar Seguro', 'Puresound', 'A', ''),
    Song(1, 'Persevere', 'Puresound', 'B', ''),
    Song(2, 'Por onde eu for', 'Puresound', 'C', ''),
    Song(3, 'Voltar', 'Puresound', 'D', ''),
    Song(4, 'Voltar', 'Puresound', 'A', ''),
    Song(5, 'Outubro', 'Puresound', 'B', ''),
    Song(6, 'Voltar', 'Puresound', 'C', ''),
    Song(7, 'Amor e Verdade', 'Puresound', 'D', ''),
    Song(8, 'Voltar', 'Puresound', 'A', ''),
    Song(9, 'Outubro', 'Puresound', 'B', ''),
    Song(10, 'Voltar', 'Puresound', 'C', ''),
    Song(11, 'Além do Horizonte', 'Puresound', 'D', ''),
    Song(12, 'Voltar', 'Puresound', 'A', ''),
    Song(13, 'Outubro', 'Puresound', 'B', ''),
    Song(14, 'Voltar', 'Puresound', 'C', ''),
    Song(15, 'Paradoxo', 'Puresound', 'D', ''),
  ];

  final List<Song> _songsToShow = <Song>[];

  @override
  initState() {
    _songsToShow.addAll(_mockSongs);
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Song> foundSongs = <Song>[];

    if (enteredKeyword.isNotEmpty) {
      for (var item in _mockSongs) {
        if (item.title.toLowerCase().contains(enteredKeyword.toLowerCase())) {
          foundSongs.add(item);
        }
      }

      setState(() {
        _songsToShow.clear();
        _songsToShow.addAll(foundSongs);
      });
    } else {
      setState(() {
        _songsToShow.clear();
        _songsToShow.addAll(_mockSongs);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context, editingController),
      body: SongsBody(songList: _songsToShow),
    );
  }

  AppBar _buildAppBar(
      BuildContext context, TextEditingController editingController) {
    return AppBar(
      elevation: 0.0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_rounded),
        onPressed: () {
          Navigator.maybePop(context);
        },
      ),
      title: TextField(
        maxLines: 1,
        autofocus: true,
        controller: editingController,
        style: TextStyle(color: kWhite),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(35)),
          ),
          filled: true,
          fillColor: Colors.grey.shade700.withOpacity(0.7),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: kWhite,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.clear_rounded,
              color: kWhite,
            ),
            onPressed: editingController.clear,
          ),
          hintText: 'Pesquisar...',
          hintStyle: TextStyle(color: Colors.grey.shade400),
        ),
        onChanged: (value) => _runFilter(value),
      ),
    );
  }
}

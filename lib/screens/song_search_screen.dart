import 'package:flutter/material.dart';
import 'package:portal_louvor_app/components/constants.dart';
import 'package:portal_louvor_app/components/mock_songs.dart';
import 'package:portal_louvor_app/model/song.dart';
import 'package:portal_louvor_app/widgets/songs_list.dart';

class SongSearchScreen extends StatefulWidget {
  const SongSearchScreen({Key? key}) : super(key: key);

  @override
  State<SongSearchScreen> createState() => _SongSearchScreenState();
}

TextEditingController editingController = TextEditingController();

class _SongSearchScreenState extends State<SongSearchScreen> {
  final List<Song> _mockSongs = kMockSongs;

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
      body: SongsList(songList: _songsToShow),
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

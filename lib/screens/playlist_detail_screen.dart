import 'package:flutter/material.dart';
import 'package:portal_louvor_app/model/playlist.dart';
import 'package:portal_louvor_app/widgets/songs_list.dart';

class PlaylistDetailScreen extends StatelessWidget {
  const PlaylistDetailScreen(this.playlist, {Key? key}) : super(key: key);

  final Playlist playlist;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          playlist.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.0),
          ),
        ),
      ),
      body: SongsList(songList: playlist.songs),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:portal_louvor_app/model/playlist.dart';
import 'package:portal_louvor_app/modules/home_page/songs_body/index.dart';

class PlaylistDetailPage extends StatelessWidget {
  const PlaylistDetailPage(this.playlist, {Key? key}) : super(key: key);

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
      body: SongsBody(songList: playlist.songs),
    );
  }
}

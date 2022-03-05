import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:portal_louvor_app/model/song.dart';
import 'package:portal_louvor_app/modules/home_page/songs_body/song_detail/song_list/index.dart';

class SongDetailPage extends StatelessWidget {
  const SongDetailPage(this.song, {Key? key}) : super(key: key);

  final Song song;

  void _showSongListModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BottomSongList();
      },
    );
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
          song.title + ' - Tom: ' + song.tone,
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
              _showSongListModal(context);
            },
            icon: Icon(Icons.queue_music_rounded),
          )
        ]);
  }

  SingleChildScrollView _buildBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Html(
          shrinkWrap: true,
          data: song.lyrics,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }
}

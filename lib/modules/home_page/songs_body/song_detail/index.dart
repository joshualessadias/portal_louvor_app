import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portal_louvor_app/model/song.dart';

class SongDetailPage extends StatelessWidget {
  const SongDetailPage(this.song, {Key? key}) : super(key: key);

  final Song song;

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
          song.title,
          maxLines: 2,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
          ),
        ),
      ),
    );
  }
}

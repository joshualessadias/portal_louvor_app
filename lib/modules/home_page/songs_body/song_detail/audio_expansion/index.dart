import 'package:flutter/material.dart';
import 'package:portal_louvor_app/model/audio_file.dart';
import 'package:portal_louvor_app/modules/home_page/songs_body/song_detail/tone_expansion/index.dart';
import 'package:portal_louvor_app/utils/duration.dart';

class AudioExpansionWidget extends StatelessWidget {
  const AudioExpansionWidget({
    Key? key,
    required this.onAudioTap,
    required this.files,
  }) : super(key: key);

  final StringToVoidFunc onAudioTap;
  final List<AudioFile> files;

  List<ListTile> _getChildren() {
    var children = <ListTile>[];

    for (var file in files) {
      children.add(_buildAudioTile(file));
    }

    if (children.isEmpty) {
      children.add(_emptyTile());
    }

    return children;
  }

  ListTile _emptyTile() {
    return ListTile(
      leading: const Icon(Icons.error_rounded),
      title: const Text('Sem dados'),
      onTap: () {},
    );
  }

  ListTile _buildAudioTile(AudioFile file) {
    return ListTile(
      leading: const Icon(Icons.play_arrow_rounded),
      title: Text(file.description),
      trailing: Text(DurationUtils.toFormattedString(file.duration)),
      onTap: () {
        onAudioTap(file.id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: const Icon(Icons.queue_music_rounded),
      title: const Text(
        'Áudios',
        style: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      children: _getChildren(),
    );
  }
}

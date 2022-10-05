import 'package:flutter/material.dart';
import 'package:portal_louvor_app/model/audio_file.dart';
import 'package:portal_louvor_app/widgets/tone_expansion.dart';
import 'package:portal_louvor_app/utils/duration.dart';

class AudioExpansionWidget extends StatelessWidget {
  const AudioExpansionWidget({
    Key? key,
    required this.onAudioTap,
    required this.files,
    required this.isSearchingFile,
  }) : super(key: key);

  final StringToVoidFunc onAudioTap;
  final List<AudioFile> files;
  final bool isSearchingFile;

  ListTile _searchingTile() {
    return ListTile(
      leading: const Icon(Icons.error_rounded),
      title: const Text('Procurando áudios...'),
      onTap: () {},
    );
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

  List<ListTile> _getChildren() {
    var children = <ListTile>[];

    if (isSearchingFile) {
      children.add(_searchingTile());
    } else {
      for (var file in files) {
        children.add(_buildAudioTile(file));
      }

      if (children.isEmpty) {
        children.add(_emptyTile());
      }
    }

    return children;
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

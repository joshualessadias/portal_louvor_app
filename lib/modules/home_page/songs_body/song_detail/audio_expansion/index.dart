import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_louvor_app/model/audio_file.dart';
import 'package:portal_louvor_app/modules/home_page/songs_body/song_detail/blocs/audio_bloc.dart';
import 'package:portal_louvor_app/modules/home_page/songs_body/song_detail/tone_expansion/index.dart';
import 'package:portal_louvor_app/utils/duration.dart';

class AudioExpansionWidget extends StatelessWidget {
  const AudioExpansionWidget({
    Key? key,
    required this.onAudioTap,
    required this.audioBloc,
  }) : super(key: key);

  final StringToVoidFunc onAudioTap;
  final AudioBloc audioBloc;

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

  List<ListTile> _getChildren(AudioState state) {
    if (state is AudioLoadingState) {
      return [_searchingTile()];
    }

    if (state is! AudioSuccessState) {
      return [_emptyTile()];
    }

    return state.audioFileList.map((file) => _buildAudioTile(file)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioBloc, AudioState>(
        bloc: audioBloc,
        builder: (context, state) {
          log(state.toString());
          return ExpansionTile(
            leading: const Icon(Icons.queue_music_rounded),
            title: const Text(
              'Áudios',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            children: _getChildren(state),
          );
        });
  }
}

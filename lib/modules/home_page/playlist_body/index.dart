import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portal_louvor_app/model/song.dart';
import 'package:portal_louvor_app/model/playlist.dart';
import 'package:portal_louvor_app/modules/home_page/playlist_body/create_playlist/index.dart';
import 'package:portal_louvor_app/modules/home_page/playlist_body/playlist_detail/index.dart';

class PlaylistBody extends StatelessWidget {
  PlaylistBody({Key? key}) : super(key: key);

  final List<Playlist> mockPlaylists = [
    Playlist(0, 'CULTO DOMINGO MATUTINO - 13/02/2022', [
      Song(0, 'Voltar', 'Puresound', 'A', ''),
      Song(1, 'Outubro', 'Puresound', 'B', ''),
      Song(0, 'Voltar', 'Puresound', 'C', ''),
      Song(0, 'Voltar', 'Puresound', 'D', ''),
    ]),
    Playlist(1, 'CULTO DOMINGO NOTURNO - 13/02/2022', [
      Song(0, 'Voltar', 'Puresound', 'E', ''),
      Song(1, 'Outubro', 'Puresound', 'F', ''),
      Song(0, 'Voltar', 'Puresound', 'G', ''),
      Song(0, 'Voltar', 'Puresound', 'A', ''),
      Song(0, 'Voltar', 'Puresound', 'B', ''),
      Song(0, 'Voltar', 'Puresound', 'C', ''),
      Song(0, 'Voltar', 'Puresound', 'D', ''),
    ]),
  ];

  void _onClickCard(BuildContext context, int playlistIndex) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            PlaylistDetailPage(mockPlaylists[playlistIndex])));
  }

  void _onClickAdd(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => CreatePlaylistPage()));
  }

  @override
  Widget build(BuildContext context) {
    const cardHeight = 90.0;
    ShapeBorder cardShape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    );

    return Stack(
      children: [
        ListView.builder(
          itemBuilder: (_, playlistIndex) => SizedBox(
            height: cardHeight,
            child: Card(
              margin: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
              clipBehavior: Clip.antiAlias,
              shape: cardShape,
              elevation: 0.0,
              color: Theme.of(context).colorScheme.surface,
              child: InkWell(
                onTap: () {
                  _onClickCard(context, playlistIndex);
                },
                child: ListTile(
                  title: Text(
                    mockPlaylists[playlistIndex].name,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  subtitle: const Text('Toque para ver todas as informações'),
                  trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                ),
              ),
            ),
          ),
          itemCount: mockPlaylists.length,
        ),
        Align(
          alignment: FractionalOffset.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: () {
                _onClickAdd(context);
              },
              tooltip: 'Adicionar Playlist',
              child: const Icon(Icons.add_rounded),
            ),
          ),
        ),
      ],
    );
  }
}

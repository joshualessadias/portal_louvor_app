import 'package:flutter/material.dart';
import 'package:portal_louvor_app/components/mock_songs.dart';
import 'package:portal_louvor_app/model/playlist.dart';
import 'package:portal_louvor_app/screens/playlist_detail_screen.dart';

class PlaylistList extends StatelessWidget {
  PlaylistList({Key? key}) : super(key: key);

  final List<Playlist> mockPlaylists = [
    Playlist(0, 'Culto Domingo Matutino - 13/02/2022', kMockSongs),
    Playlist(1, 'Culto Domingo Noturno - 13/02/2022', kMockSongs),
  ];

  void _onClickCard(BuildContext context, int playlistIndex) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            PlaylistDetailScreen(mockPlaylists[playlistIndex])));
  }

  @override
  Widget build(BuildContext context) {
    const cardHeight = 90.0;
    double titleFontSize = 16.0;
    double subTitleFontSize = 12.0;

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
                      fontSize: titleFontSize,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  subtitle: RichText(
                    text: TextSpan(
                      text: 'Toque para ver todas as informações',
                      style: TextStyle(
                        fontSize: subTitleFontSize,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                ),
              ),
            ),
          ),
          itemCount: mockPlaylists.length,
        ),
      ],
    );
  }
}

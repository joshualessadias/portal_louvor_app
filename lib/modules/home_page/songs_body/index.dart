import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portal_louvor_app/model/playlist.dart';
import 'package:portal_louvor_app/model/song.dart';
import 'package:portal_louvor_app/modules/home_page/songs_body/song_detail/index.dart';
import 'package:portal_louvor_app/modules/home_page/songs_body/songs_search/index.dart';

class SongsBody extends StatelessWidget {
  SongsBody({Key? key, this.playlist}) : super(key: key);

  final Playlist? playlist;

  final List<Song> mockSongs = [
    Song(0, 'Lugar Seguro', 'Puresound', 'A', ''),
    Song(1, 'Persevere', 'Puresound', 'B', ''),
    Song(2, 'Por onde eu for', 'Puresound', 'C', ''),
    Song(3, 'Voltar', 'Puresound', 'D', ''),
    Song(4, 'Voltar', 'Puresound', 'A', ''),
    Song(5, 'Outubro', 'Puresound', 'B', ''),
    Song(6, 'Voltar', 'Puresound', 'C', ''),
    Song(7, 'Amor e Verdade', 'Puresound', 'D', ''),
    Song(8, 'Voltar', 'Puresound', 'A', ''),
    Song(9, 'Outubro', 'Puresound', 'B', ''),
    Song(10, 'Voltar', 'Puresound', 'C', ''),
    Song(11, 'Além do Horizonte', 'Puresound', 'D', ''),
    Song(12, 'Voltar', 'Puresound', 'A', ''),
    Song(13, 'Outubro', 'Puresound', 'B', ''),
    Song(14, 'Voltar', 'Puresound', 'C', ''),
    Song(15, 'Paradoxo', 'Puresound', 'D', ''),
  ];

  void _onClickSearch(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SongSearchPage()));
  }

  void _onClickCard(BuildContext context, int songIndex) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SongDetailPage(playlist != null
            ? playlist!.songs[songIndex]
            : mockSongs[songIndex])));
  }

  @override
  Widget build(BuildContext context) {
    const cardHeight = 90.0;

    ShapeBorder cardShape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    );

    mockSongs.sort((a, b) => a.title.compareTo(b.title));

    return Stack(
      children: [
        ListView.builder(
          itemCount:
              playlist != null ? playlist!.songs.length : mockSongs.length,
          itemBuilder: (_, songIndex) => SizedBox(
            height: cardHeight,
            child: Card(
              margin: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
              clipBehavior: Clip.antiAlias,
              shape: cardShape,
              elevation: 0.0,
              color: Theme.of(context).colorScheme.surface,
              child: InkWell(
                onTap: () {
                  _onClickCard(context, songIndex);
                },
                child: ListTile(
                  title: Text(
                    playlist != null
                        ? playlist!.songs[songIndex].title
                        : mockSongs[songIndex].title,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  subtitle: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Autor: ' +
                              (playlist != null
                                  ? playlist!.songs[songIndex].author
                                  : mockSongs[songIndex].author),
                          style: const TextStyle(
                            color: Colors.black54,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const TextSpan(
                          text: '\nTom: ',
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                        TextSpan(
                          text: playlist != null
                              ? playlist!.songs[songIndex].tone
                              : mockSongs[songIndex].tone,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                  isThreeLine: true,
                ),
              ),
            ),
          ),
        ),
        (playlist == null
            ? Align(
                alignment: FractionalOffset.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    onPressed: () {
                      _onClickSearch(context);
                    },
                    tooltip: 'Buscar Música',
                    child: const Icon(Icons.search_rounded),
                  ),
                ),
              )
            : const SizedBox()),
      ],
    );
  }
}

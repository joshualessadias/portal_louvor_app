import 'package:flutter/material.dart';
import 'package:portal_louvor_app/model/song.dart';
import 'package:portal_louvor_app/screens/song_detail_screen.dart';
import 'package:portal_louvor_app/screens/song_search_screen.dart';
import 'package:portal_louvor_app/components/mock_songs.dart';

class SongsList extends StatelessWidget {
  SongsList({Key? key, this.songList}) : super(key: key);

  final List<Song>? songList;

  final List<Song> mockSongs = kMockSongs;

  void _onClickSearch(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const SongSearchScreen()));
  }

  void _onClickCard(BuildContext context, int songIndex) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SongDetailScreen(
            songList != null ? songList![songIndex] : mockSongs[songIndex])));
  }

  @override
  Widget build(BuildContext context) {
    const cardHeight = 90.0;
    double titleFontSize = 16.0;
    double subTitleFontSize = 12.0;

    ShapeBorder cardShape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    );

    if (songList != null) {
      songList!.sort((a, b) => a.title.compareTo(b.title));
    } else {
      mockSongs.sort((a, b) => a.title.compareTo(b.title));
    }

    return Stack(
      children: [
        ListView.builder(
          itemCount: songList != null ? songList!.length : mockSongs.length,
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
                    songList != null
                        ? songList![songIndex].title
                        : mockSongs[songIndex].title,
                    style: TextStyle(
                      fontSize: titleFontSize,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  subtitle: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Autor: ' +
                              (songList != null
                                  ? songList![songIndex].descriptionAuthor
                                  : mockSongs[songIndex].descriptionAuthor),
                          style: TextStyle(
                            fontSize: subTitleFontSize,
                            color: Colors.black54,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        TextSpan(
                          text: '\nTom: ',
                          style: TextStyle(
                            fontSize: subTitleFontSize,
                            color: Colors.black54,
                          ),
                        ),
                        TextSpan(
                          text: songList != null
                              ? songList![songIndex].tone
                              : mockSongs[songIndex].tone,
                          style: TextStyle(
                            fontSize: subTitleFontSize + 1.0,
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
        (songList != null
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

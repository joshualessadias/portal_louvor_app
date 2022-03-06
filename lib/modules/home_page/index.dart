import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:portal_louvor_app/components/constants.dart';
import 'package:portal_louvor_app/components/custom_tab_bar.dart';
import 'package:portal_louvor_app/model/song.dart';
import 'package:portal_louvor_app/modules/home_page/playlist_body/index.dart';
import 'package:portal_louvor_app/modules/home_page/songs_body/index.dart';
import 'package:portal_louvor_app/services/song_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin, RestorationMixin {
  late TabController _tabController;

  final RestorableInt tabIndex = RestorableInt(0);

  List<Song> songList = [];

  void _buildSongList(Response response) {
    Map<String, dynamic> jsonMap = jsonDecode(response.body);
    List<dynamic> data = jsonMap['data'];

    for (var dataValue in data) {
      songList.add(Song.fromDynamic(dataValue));
    }
  }

  void _getSongList() {
    findAllSongs().then((response) => {
          if (response.statusCode == 200)
            {_buildSongList(response)}
          else
            {throw Exception('Failed to load Song List')}
        });
  }

  @override
  String? get restorationId => 'home_page';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tabIndex');
    _tabController.index = tabIndex.value;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        tabIndex.value = _tabController.index;
      });
    });

    _getSongList();
  }

  @override
  void dispose() {
    _tabController.dispose();
    tabIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const SizedBox.shrink(),
        toolbarHeight: 0.0,
      ),
      body: Stack(children: [
        Container(
          height: double.infinity,
          color: kBackground,
        ),
        Column(
          children: [
            SizedBox(
              height: screenSize.height * 0.2,
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 16.0,
                    ),
                    height: screenSize.height * 0.2 - 27,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Ministério de Louvor',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              color: kWhite,
                              fontFamily: 'Roboto-Regular',
                              fontWeight: FontWeight.w500,
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(
                            height: 45,
                            child: Image(
                              image: AssetImage(
                                  'images/logo_siao_white_minimal.png'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0.0,
                    right: 0.0,
                    bottom: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: TabBar(
                        controller: _tabController,
                        indicatorColor: Colors.transparent,
                        tabs: [
                          Tab(
                            child: CustomTabBar(
                              tabLabel: 'Playlists',
                              isSelectedTab:
                                  _tabController.index == 0 ? true : false,
                            ),
                          ),
                          Tab(
                            child: CustomTabBar(
                              tabLabel: 'Músicas',
                              isSelectedTab:
                                  _tabController.index == 1 ? true : false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  PlaylistBody(),
                  SongsBody(
                    songList: songList,
                  ),
                ],
              ),
            )
          ],
        ),
      ]),
    );
  }
}

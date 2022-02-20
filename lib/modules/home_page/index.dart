import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portal_louvor_app/components/constants.dart';
import 'package:portal_louvor_app/components/custom_tab_bar.dart';
import 'package:portal_louvor_app/modules/home_page/playlist_body/index.dart';
import 'package:portal_louvor_app/modules/home_page/songs_body/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin, RestorationMixin {
  late TabController _tabController;

  final RestorableInt tabIndex = RestorableInt(0);

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
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded),
          onPressed: () {},
        ),
      ),
      body: Stack(children: [
        Container(
          height: double.infinity,
          color: kWhite,
        ),
        Column(
          children: [
            SizedBox(
              height: screenSize.height * 0.18,
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 16.0,
                    ),
                    height: screenSize.height * 0.18 - 27,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      ),
                    ),
                    child: Text(
                      'Olá, Joshua',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: kWhite,
                        fontFamily: 'Roboto-Regular',
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
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
                  SongsBody(),
                ],
              ),
            )
          ],
        ),
      ]),
    );
  }
}

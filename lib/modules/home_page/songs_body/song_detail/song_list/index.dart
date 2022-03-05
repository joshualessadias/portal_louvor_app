import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomSongList extends StatelessWidget {
  const BottomSongList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        children: [
          const SizedBox(
            height: 50,
            child: Center(
              child: Text(
                'Músicas',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const Divider(thickness: 1),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return const ListTile(
                  leading: Icon(Icons.play_arrow_rounded),
                  title: Text('Principal'),
                  trailing: Text('4:06'),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

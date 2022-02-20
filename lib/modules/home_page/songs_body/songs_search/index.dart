import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SongSearchPage extends StatelessWidget {
  const SongSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.maybePop(context);
          },
        ),
        title: Container(
          width: double.infinity,
          height: 40.0,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(35),
          ),
          child: Center(
            child: TextField(
              autofocus: true,
              controller: _controller,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear_rounded),
                  onPressed: _controller.clear,
                ),
                hintText: 'Pesquisar...',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

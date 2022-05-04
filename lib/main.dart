import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_louvor_app/components/constants.dart';
import 'package:portal_louvor_app/modules/home_page/songs_body/song_detail/blocs/audio_bloc.dart';

import 'modules/login_page/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AudioBloc(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              scaffoldBackgroundColor: kBackground,
              fontFamily: 'Roboto-Regular',
              colorScheme: ColorScheme(
                primary: const Color(0xFF00ADA7),
                secondary: const Color(0xFFF9732A),
                surface: Colors.grey.shade300,
                background: Colors.white,
                error: Colors.red,
                onPrimary: Colors.white,
                onSecondary: Colors.white,
                onSurface: Colors.black,
                onBackground: Colors.black,
                onError: Colors.white,
                brightness: Brightness.light,
              )),
          home: const LoginPage()),
    );
  }
}

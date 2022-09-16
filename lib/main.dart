import 'package:flutter/material.dart';

import 'package:simple_music_app/screens/start_page.dart';
import 'package:simple_music_app/utils/pages.dart';
import 'package:simple_music_app/utils/theme.dart';

void main() {
  runApp(const MyMusicApp());
}

class MyMusicApp extends StatelessWidget {
  const MyMusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: myTheme(),
      home: const StartPage(),
      onGenerateRoute: (settings) => generateRoute(settings),
    );
  }
}

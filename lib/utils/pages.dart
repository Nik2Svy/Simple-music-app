import 'package:flutter/material.dart';
import 'package:simple_music_app/models/my_playlist.dart';
import 'package:simple_music_app/screens/favorites_page.dart';
import 'package:simple_music_app/screens/home_page.dart';
import 'package:simple_music_app/screens/playlist_page.dart';
import 'package:simple_music_app/screens/setting_page.dart';
import 'package:simple_music_app/screens/start_page.dart';

// Страницы всего приложения

const String startPage = '/startPage';
const String homePage = '/homePage';
const String playlistPage = '/playlistPage';
const String favoritesPage = '/favoritesPage';
const String settingsPage = '/settingsPage';

final listOfMyWigetPages = [];

generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case homePage:
      return MaterialPageRoute(builder: (context) => const HomePage());
    case startPage:
      return MaterialPageRoute(builder: (context) => const StartPage());
    case playlistPage:
      MyPlaylist playlist = settings.arguments as MyPlaylist;
      return MaterialPageRoute(
          builder: (context) => MyPlaylistPage(
                playlist: playlist,
              ));
    case favoritesPage:
      return MaterialPageRoute(builder: (context) => const MyFavoritesPage());
    case settingsPage:
      return MaterialPageRoute(builder: (context) => MySettingsPage());
  }
}

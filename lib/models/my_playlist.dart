import 'package:assets_audio_player/assets_audio_player.dart';

class MyPlaylist {
  final String header;
  final String subtitle;
  final String
      duration; //// заменить int и сделать перевод времени в словесное выражение
  final String
      trackAmount; //// сделать, что бы количество трэков переводилось в строку и добавлялось нужное слово (Track/Tracks)
  final String backgroundImage;

  MyPlaylist({
    required this.header,
    required this.subtitle,
    required this.duration,
    required this.trackAmount,
    required this.backgroundImage,
  });

  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();

//// сделать так, чтобы это было полем класса
  createPlaylist() {
    return Playlist(audios: [
      Audio('assets/audio/Aisuru.mp3',
          metas: Metas(
            title: 'Aisuru',
            artist: 'Dani Sogen',
          )),
      Audio('assets/audio/Flowing.mp3',
          metas: Metas(
            title: 'Flowing',
            artist: 'Dani Sogen',
          )),
      Audio('assets/audio/Magic Rain.mp3',
          metas: Metas(
            title: 'Magic Rain',
            artist: 'Dani Sogen',
          )),
    ]);
  }

  void setupPlaylist() async {
    audioPlayer.open(createPlaylist(),
        autoStart: false, loopMode: LoopMode.playlist);
  }
}

MyPlaylist playlist_01 = MyPlaylist(
  header: 'All About Summer',
  subtitle: 'Bright Encounters',
  duration: '1 hour',
  trackAmount: '12 Tracks',
  backgroundImage: 'assets/images/Playlist_backgroundImage_01.png',
);
MyPlaylist playlist_02 = MyPlaylist(
  header: 'Funk Gets A Groove',
  subtitle: 'Feel the Bass',
  duration: '1 hour',
  trackAmount: '12 Tracks',
  backgroundImage: 'assets/images/Playlist_backgroundImage_02.png',
);
MyPlaylist playlist_03 = MyPlaylist(
  header: 'Feeling Arty Farty',
  subtitle: 'Bright Encounters',
  duration: '35 min',
  trackAmount: '12 Tracks',
  backgroundImage: 'assets/images/Playlist_backgroundImage_03.png',
);
MyPlaylist playlist_04 = MyPlaylist(
  header: 'Feeling Arty Farty',
  subtitle: 'Bright Encounters',
  duration: '35 min',
  trackAmount: '12 Tracks',
  backgroundImage: 'assets/images/Playlist_backgroundImage_04.png',
);

List<MyPlaylist> myPlaylists = [
  playlist_01,
  playlist_02,
  playlist_03,
  playlist_04
];

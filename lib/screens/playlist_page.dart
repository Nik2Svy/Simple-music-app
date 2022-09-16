import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_music_app/models/my_playlist.dart';
import 'package:simple_music_app/utils/constants.dart';
import 'package:simple_music_app/utils/pages.dart';
import 'package:simple_music_app/widget/my_down_arr_buttom.dart';

class MyPlaylistPage extends StatefulWidget {
  MyPlaylist playlist;
  MyPlaylistPage({
    Key? key,
    required this.playlist,
  }) : super(key: key);

  @override
  _MyPlaylistPageState createState() => _MyPlaylistPageState();
}

class _MyPlaylistPageState extends State<MyPlaylistPage> {
  double imageHeight = 530;

  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();

  double screenWidth = 0;
  double screenHeight = 0;
  MyPlaylist playlistBuild = playlist_02;

  @override
  void initState() {
    super.initState();
    setupPlaylist();
  }

  void setupPlaylist() {
    widget.playlist.setupPlaylist();
  }

  ////////////////
  /// прерываие потока выполнения
  // @override
  // void dispose() {
  //   super.dispose();
  //   audioPlayer.dispose();
  // }
  ////////////////

// изображение плэйлиста и кнопка возврата
  playlistImage() {
    return SizedBox(
      height: screenHeight * 0.6,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            playlistBuild.backgroundImage,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  myButtomDown(context, homePage, kMainTextColorLM, kColorLM),
                  Container(
                    decoration: BoxDecoration(
                      color: kColorLM.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'Art by francisca pageo',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: kAdditionalTextColorLM),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isMoreHorizTap = false;

  void _onMoreHorizTapped() {
    setState(() {
      isMoreHorizTap = !isMoreHorizTap;
    });
  }

// описание плэйлиста
  aboutPlaylist() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              playlistBuild.header,
              style: Theme.of(context).textTheme.headline3,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  playlistBuild.duration,
                  style: Theme.of(context).textTheme.caption,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  playlistBuild.trackAmount,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ],
        ),
        IconButton(
          splashRadius: 25,
          iconSize: 40,
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) => popUpMenu());
          },
          icon: const Icon(
            Icons.more_horiz,
          ),
        ),
      ],
    );
  }

  songTitleAndArtist(RealtimePlayingInfos realtimePlayingInfos) {
    return Center(
      child: Text(
        '${realtimePlayingInfos.current?.audio.audio.metas.title} — ${realtimePlayingInfos.current?.audio.audio.metas.artist}',
      ),
    );
  }

// полоса воспроизведения
  slider(RealtimePlayingInfos realtimePlayingInfos) {
    return Stack(
      children: [
        Positioned.fill(
            child: Container(
          height: screenHeight * 0.03,
        )),
        SliderTheme(
            data: SliderThemeData(
              trackShape: CustomTrackShape(),
              thumbColor: kColorAccent,
              activeTrackColor: kColorAccent,
              inactiveTrackColor: kAdditionalTextColorLM,
              //  overlayColor: Colors.transparent,
            ),
            child: Slider.adaptive(
                value:
                    realtimePlayingInfos.currentPosition.inSeconds.toDouble(),
                max: realtimePlayingInfos.duration.inSeconds.toDouble() + 3,
                min: -3,
                onChanged: (value) {
                  if (value <= 0) {
                    audioPlayer.seek(const Duration(seconds: 0));
                  } else if (value >= realtimePlayingInfos.duration.inSeconds) {
                    audioPlayer.seek(realtimePlayingInfos.duration);
                  } else {
                    audioPlayer.seek(Duration(seconds: value.toInt()));
                  }
                })),
      ],
    );
  }

  playBar(RealtimePlayingInfos realtimePlayingInfos) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.skip_previous_rounded),
          onPressed: () => audioPlayer.previous(),
          iconSize: screenHeight * 0.04,
          splashRadius: screenHeight * 0.03,
          color: kColorAccent,
        ),
        IconButton(
          icon: Icon(realtimePlayingInfos.isPlaying
              ? Icons.pause_circle_filled_rounded
              : Icons.play_circle_fill_rounded),
          onPressed: () => audioPlayer.playOrPause(),
          iconSize: screenHeight * 0.08,
          splashRadius: screenHeight * 0.04,
          color: kColorAccent,
        ),
        IconButton(
          icon: const Icon(Icons.skip_next_rounded),
          onPressed: () => audioPlayer.next(),
          iconSize: screenHeight * 0.04,
          splashRadius: screenHeight * 0.03,
          color: kColorAccent,
        ),
      ],
    );
  }

// всплывающие меню
  popUpMenu() {
    double popUpMenuHeight = screenHeight / 6;
    double popUpMenuWidth = screenWidth / 2;
    int itemCount = 3;

    Map popUpMenuHeders = {
      'Add to Favoites': 'assets/icons/heart.svg',
      'Share': 'assets/icons/share_btn.svg',
      'Cast to Device': 'assets/icons/cast_btn.svg',
    };

    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Dialog(
        alignment: Alignment.center,
        child: Container(
          //margin: const EdgeInsets.only(top: 20),
          height: popUpMenuHeight,
          width: popUpMenuWidth,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0x32000000),
                blurRadius: 12.0,
                offset: Offset(
                  0.0,
                  3.0,
                ),
              ),
            ],
          ),
          child: Column(
              children: List.generate(
            3,
            (index) => Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextButton.icon(
                        style: TextButton.styleFrom(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: SvgPicture.asset(
                          popUpMenuHeders.values.toList().elementAt(index),
                          height: 20,
                        ),
                        label: Text(
                          popUpMenuHeders.keys.toList().elementAt(index),
                          style: Theme.of(context).textTheme.caption,
                        )),
                  ),
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    playlistBuild = widget.playlist;

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    audioPlayer = widget.playlist.audioPlayer;

    return Scaffold(
      body: audioPlayer.builderRealtimePlayingInfos(
          builder: (context, realtimePlayingInfos) {
        if (realtimePlayingInfos != null) {
          return Column(
            children: [
              playlistImage(),
              Flexible(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          aboutPlaylist(),
                          songTitleAndArtist(realtimePlayingInfos),
                          slider(realtimePlayingInfos),
                          playBar(realtimePlayingInfos),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        } else {
          return Column();
        }
      }),
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double? trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

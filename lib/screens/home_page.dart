import 'dart:math';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_music_app/models/my_playlist.dart';
import 'package:simple_music_app/utils/constants.dart';
import 'package:simple_music_app/utils/pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

List<String> listOfSubtitles = [
  'For you',
  'Popular',
  'New',
];

class _HomePageState extends State<HomePage> {
  bool isGridEquipmentCardTapped = false;

  MyPlaylist botNavBarPlaylist = playlist_01;

// изменение состояния при нажатии на плитку
  void _onGridCardTapped(MyPlaylist gridTappedPlaylist) {
    setState(() {});
    botNavBarPlaylist = gridTappedPlaylist;
    if (!isGridEquipmentCardTapped) {
      //setState(() {
      isGridEquipmentCardTapped = !isGridEquipmentCardTapped;
      //});
    }
  }

// позвращает плитку плэйлиста
  gridEquipmentCard(BuildContext context, MyPlaylist gridPlaylist) {
    double imageHeight = 140;
    double imageWigth = 190;
    return TextButton(
      onPressed: () {
        _onGridCardTapped(gridPlaylist);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: imageHeight,
            width: imageWigth,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                gridPlaylist.backgroundImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                gridPlaylist.header,
                style: Theme.of(context).textTheme.subtitle2,
              ),
              Text(
                gridPlaylist.duration,
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          )
        ],
      ),
    );
  }

// нижняя панель навигации. Изменяет размер при нажатии на плитку плэйлиста
  myBottomNavigationBar(bool tapped, MyPlaylist myBotNavBarPlaylist) {
    String search = 'assets/icons/search.svg';
    String heart = 'assets/icons/heart.svg';
    String menu = 'assets/icons/menu.svg';
    String upArrow = 'assets/icons/up_arrow.svg';

    double botNavBarHeight = 58;
    double botNavBarSplashRadius = 26;

    double musicPanelHeight = 88;

    ValueNotifier<bool> isPauseTap = ValueNotifier(false);

    return Container(
      decoration: const BoxDecoration(
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
      height: (() {
        if (tapped) {
          return botNavBarHeight + musicPanelHeight;
        } else {
          return botNavBarHeight;
        }
      }()),
      child: Column(
        children: [
          (() {
            if (tapped) {
              return SizedBox(
                height: musicPanelHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          ExactAssetImage(myBotNavBarPlaylist.backgroundImage),
                      maxRadius: 28,
                      child: ValueListenableBuilder<bool>(
                        valueListenable: isPauseTap,
                        builder: (context, value, child) => IconButton(
                          onPressed: () {
                            isPauseTap.value = !isPauseTap.value;
                          },
                          icon: isPauseTap.value
                              ? const Icon(
                                  Icons.play_arrow,
                                )
                              : const Icon(Icons.pause),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          myBotNavBarPlaylist.header,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(fontSize: 16),
                        ),
                        Text(
                          currentTrack,
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(color: kAdditionalTextColorLM),
                        ),
                      ],
                    ),
                    IconButton(
                      splashRadius: botNavBarSplashRadius,
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          playlistPage,
                          arguments: myBotNavBarPlaylist,
                        );
                      },
                      icon: SvgPicture.asset(upArrow),
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          }()),
          SizedBox(
            height: botNavBarHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  splashRadius: botNavBarSplashRadius,
                  onPressed: () {},
                  icon: SvgPicture.asset(search),
                ),
                IconButton(
                  splashRadius: botNavBarSplashRadius,
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      favoritesPage,
                    );
                  },
                  icon: SvgPicture.asset(heart),
                ),
                IconButton(
                  splashRadius: botNavBarSplashRadius,
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      settingsPage,
                    );
                  },
                  icon: SvgPicture.asset(menu),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverPersistentHeader(
          pinned: false,
          delegate: _SliverAppBarDelegate(),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Padding(
              padding: const EdgeInsets.only(
                left: 36,
                top: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    listOfSubtitles[index],
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  SizedBox(
                    width: size.width,
                    height: 220,
                    child: ListView.custom(
                      scrollDirection: Axis.horizontal,
                      childrenDelegate: SliverChildBuilderDelegate(
                        (context, index) => gridEquipmentCard(
                          context,
                          myPlaylists[index],
                        ),
                        childCount: myPlaylists.length,
                      ),
                    ),
                  )
                ],
              ),
            ),
            childCount: listOfSubtitles.length,
          ),
        ),
      ]),
      bottomNavigationBar:
          myBottomNavigationBar(isGridEquipmentCardTapped, botNavBarPlaylist),
    );
  }
}

// анимация для скрытия большого изображения
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  double scrollAnimationValue(double shrinkOffset) {
    double maxScrollAllowed = maxExtent - minExtent;
    return ((maxScrollAllowed - shrinkOffset) / maxScrollAllowed)
        .clamp(0, 1)
        .toDouble();
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final double visibleMainHeight = max(maxExtent - shrinkOffset, minExtent);
    final double animationVal = scrollAnimationValue(shrinkOffset);

    const double textWidth = 250;

    const double featuredButtomWidth = 88;
    const double featuredButtomHeight = 40;

    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: visibleMainHeight,
      width: size.width,
      child: Swiper(
        autoplay: true,
        duration: 1000,
        autoplayDelay: 5000,
        itemCount: myPlaylists.length,
        itemBuilder: (context, index) {
          return Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Opacity(
                opacity: animationVal,
                child: Image.asset(
                  myPlaylists[index].backgroundImage,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0.0,
                child: Container(
                  height: size.height / 3,
                  width: size.width,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter,
                          colors: [
                        Color(0x0042E4CE),
                        kColorAccent,
                      ],
                          stops: [
                        0.0,
                        1.0
                      ])),
                ),
              ),
              Positioned(
                bottom: size.height * 0.06,
                left: size.width * 0.1,
                child: SizedBox(
                  width: textWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                          style: TextButton.styleFrom(
                            fixedSize: const Size(
                                featuredButtomWidth, featuredButtomHeight),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: const BorderSide(
                                color: kWhiteText,
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: Center(
                            child: Text(
                              'Featured',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(color: kWhiteText),
                            ),
                          )),
                      Text(
                        myPlaylists[index].header,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(fontSize: 48),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            myPlaylists[index].subtitle,
                            style: Theme.of(context).textTheme.caption,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            myPlaylists[index].duration,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  double get maxExtent => 463.0;

  var minHeight = AppBar().preferredSize.height;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_music_app/utils/constants.dart';
import 'package:simple_music_app/utils/pages.dart';
import 'package:simple_music_app/widget/my_down_arr_buttom.dart';

class MyFavoritesPage extends StatefulWidget {
  const MyFavoritesPage({Key? key}) : super(key: key);

  @override
  State<MyFavoritesPage> createState() => _MyFavoritesPageState();
}

class _MyFavoritesPageState extends State<MyFavoritesPage> {
  double screenWidth = 0;
  double screenHeight = 0;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(top: 30, left: 54.1),
          child:
              myButtomDown(context, homePage, kColorLM, kAdditionalTextColorLM),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/heart.svg',
                height: screenHeight / 4,
                color: kColorAccent,
              ),
              SizedBox(
                height: screenHeight * 0.08,
              ),
              Text(
                'No Favorites',
                style: Theme.of(context).textTheme.headline3,
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              SizedBox(
                width: screenWidth * 0.7,
                child: Text(
                  'Start adding moodlists to your favorites by clicking the  icon',
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.08,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Explore moodlists',
                  style: Theme.of(context)
                      .textTheme
                      .button!
                      .copyWith(color: kColorAccent),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:simple_music_app/utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_music_app/utils/pages.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _HomePageState();
}

class _HomePageState extends State<StartPage> {
  int itemCount = 3;

  String startImg = 'assets/images/Background start page.png';

  String logo = 'assets/icons/logo.svg';
  double logoHeight = 100;
  double logoWidth = 328;

  String startTitle = 'Discover Alternative Music';
  String startSubtitle =
      'Lorem Ipsum is simply dummy text of the printing and typesetting.';

  double nextButtomHeight = 47;
  double nextButtomWidth = 186;

  double skipButtomHeight = 23;
  double skipButtomWidth = 35;

  final controller = SwiperController();

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Swiper(
            controller: controller,
            loop: false,
            itemCount: itemCount,
            pagination: const SwiperPagination(
              alignment: Alignment(0.0, 0.5),
              builder:
                  DotSwiperPaginationBuilder(activeColor: kMainTextColorLM),
            ),
            itemBuilder: (context, index) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  SizedBox(
                    child: Image.asset(
                      startImg,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: FractionalOffset.topCenter,
                            end: FractionalOffset.bottomCenter,
                            colors: [
                          Color(0x0F42C9E4),
                          kColorAccent,
                        ],
                            stops: [
                          0.0,
                          1.0
                        ])),
                  ),
                  Positioned(
                    top: deviceSize.height * 0.3,
                    left: (deviceSize.width - logoWidth) / 2,
                    child: SizedBox(
                      height: logoHeight,
                      width: logoWidth,
                      child: SvgPicture.asset(logo),
                    ),
                  ),
                  Positioned(
                    top: deviceSize.height * 0.55,
                    child: SizedBox(
                      width: deviceSize.width,
                      child: Column(
                        children: [
                          Text(
                            startTitle,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: deviceSize.width * 0.7,
                            child: Text(
                              startSubtitle,
                              style: Theme.of(context).textTheme.caption,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: deviceSize.height * 0.8,
                    left: (deviceSize.width - nextButtomWidth) / 2,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: kWhiteText,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(deviceSize.height / 2),
                          ),
                          // добавлять этот параметр, а не оборачивать Text в SizedBox
                          // т.к. у TextButton есть еще свои дополнительные размеры
                          fixedSize: Size(nextButtomWidth, nextButtomHeight)),
                      onPressed: () {
                        if (index == (itemCount - 1)) {
                          Navigator.pushNamed(
                            context,
                            homePage,
                          );
                        } else {
                          controller.move(index + 1);
                        }
                      },
                      child: Center(
                        child: (() {
                          if (index == (itemCount - 1)) {
                            return Text(
                              'Let\'s start',
                              style: Theme.of(context).textTheme.button,
                            );
                          } else {
                            return Text(
                              'Next',
                              style: Theme.of(context).textTheme.button,
                            );
                          }
                        }()),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: TextButton(
                style: TextButton.styleFrom(
                    fixedSize: Size(skipButtomWidth, skipButtomHeight)),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    homePage,
                  );
                },
                child: Center(
                  child: Text(
                    'Skip',
                    style: Theme.of(context).textTheme.caption,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

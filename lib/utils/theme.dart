import 'package:flutter/material.dart';
import 'constants.dart';

// Тема всего сайта
@override
ThemeData myTheme() => ThemeData(
      fontFamily: 'PlayfairDisplay',

      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: kColorAccent,
      ),
      //splashColor: kColorAccent,

      textTheme: const TextTheme(
          subtitle1: TextStyle(
            color: kWhiteText,
            fontSize: 30,
          ),
          subtitle2: TextStyle(
            color: kMainTextColorLM,
            fontSize: 20,
          ),
          caption: TextStyle(
            color: kMainTextColorLM,
            fontSize: 14,
          ),
          button: TextStyle(
            color: kColorAccent,
            fontSize: 24,
          ),
          headline3: TextStyle(
            color: kMainTextColorLM,
            fontSize: 30,
          )),
    );

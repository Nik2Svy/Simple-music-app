import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_music_app/utils/constants.dart';
import 'package:simple_music_app/utils/pages.dart';
import 'package:simple_music_app/widget/my_down_arr_buttom.dart';

class MySettingsPage extends StatefulWidget {
  MySettingsPage({Key? key}) : super(key: key);

  @override
  _MySettingsPageState createState() => _MySettingsPageState();
}

class _MySettingsPageState extends State<MySettingsPage> {
  double screenWidth = 0;
  double screenHeight = 0;

  bool _switchValue = false;

  void _onSwitchChange(bool value) {
    setState(() {
      _switchValue = value;
    });
  }

// всплывающие окно удаления аккаунта
  popUpWindow(BuildContext context) {
    double borderRadius = 20;
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius)),
      child: SizedBox(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Center(
                  child: Text(
                    'Are you sure you want to delete your account?',
                    style: Theme.of(context).textTheme.subtitle2,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: kColorAccent,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(borderRadius))),
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Yes',
                            style: Theme.of(context).textTheme.subtitle2)),
                  ),
                ),
                const VerticalDivider(
                  width: 1,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: kColorAccent,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(borderRadius))),
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('No',
                            style: Theme.of(context).textTheme.subtitle2)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

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
        Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 90, bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    fixedSize: Size.fromWidth(screenWidth)),
                onPressed: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Push Notifications',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Text(
                      'Currently on',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            color: kAdditionalTextColorLM,
                          ),
                    ),
                  ],
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    fixedSize: Size.fromWidth(screenWidth)),
                onPressed: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Account & Privacy',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Text(
                      'Manage password and your account',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            color: kAdditionalTextColorLM,
                          ),
                    ),
                  ],
                ),
              ),
              //// нужно заменить звет фона и брызг
              SwitchListTile(
                // inactiveThumbColor: Colors.red,
                activeTrackColor: kColorAccent.withOpacity(0.4),
                activeColor: kColorAccent,
                hoverColor: kColorAccent,
                contentPadding: const EdgeInsets.all(8),
                title: Text(
                  'Dark Mode',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                subtitle: Text(
                  _switchValue ? 'Currently on' : 'Currently off',
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        color: kAdditionalTextColorLM,
                      ),
                ),
                value: _switchValue,
                onChanged: _onSwitchChange,
              ),
              TextButton(
                style: TextButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    fixedSize: Size.fromWidth(screenWidth)),
                onPressed: () {},
                child: Text(
                  'About',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    fixedSize: Size.fromWidth(screenWidth)),
                onPressed: () {},
                child: Column(
                  children: [
                    Text(
                      'Feedback',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              TextButton(
                style: TextButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    fixedSize: Size.fromWidth(screenWidth)),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => popUpWindow(context));
                },
                child: Column(
                  children: [
                    Text(
                      'Delete Account',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(color: Colors.red),
                    ),
                  ],
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    fixedSize: Size.fromWidth(screenWidth)),
                onPressed: () {},
                child: Column(
                  children: [
                    Text(
                      'Sign Out',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'App version 1.0',
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          color: kAdditionalTextColorLM,
                        ),
                  ),
                  SvgPicture.asset(
                    'assets/icons/logo.svg',
                    height: 26,
                    color: kColorAccent,
                  )
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}

import 'package:chat_app_demo3/screens/calls.dart';
import 'package:chat_app_demo3/screens/chats.dart';
import 'package:chat_app_demo3/screens/people.dart';
import 'package:chat_app_demo3/screens/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  var screens = [Chats(), Calls(), People(), SettingsScreen()];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: CupertinoTabScaffold(
      resizeToAvoidBottomInset: true,
      tabBar: CupertinoTabBar(items: [
        BottomNavigationBarItem(
          label: "Chats",
          icon: Icon(CupertinoIcons.chat_bubble_2_fill),
        ),
        BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.phone), label: "Calls"),
        BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_alt_circle), label: "People"),
        BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings_solid), label: "Settings"),
      ]),
      tabBuilder: (BuildContext context, int index) {
        return screens[index];
      },
    ));
  }
}

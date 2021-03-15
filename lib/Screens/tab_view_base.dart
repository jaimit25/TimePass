import 'package:TimePass/tabs/feed.dart';
import 'package:flutter/material.dart';
import 'AddFeed.dart';
import 'package:TimePass/chat/Chat/Search.dart';

import 'package:TimePass/tabs/tabs.dart';
import 'package:TimePass/Media/playlist.dart';

class TabViewBase extends StatelessWidget {
  final String tabName;

  TabViewBase({@required this.tabName});

  @override
  Widget build(BuildContext context) {
    Tabs_Controller(String tabs) {
      switch (tabs) {
        case "Breakfast":
          return feed();
          break;
        case "Lunch":
          return AddFeed();
          break;
      }
    }

    Size size = MediaQuery.of(context).size;
    return Tabs_Controller(this.tabName);
  }
}

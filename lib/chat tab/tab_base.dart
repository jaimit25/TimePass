import 'package:TimePass/tabs/feed.dart';
import 'package:flutter/material.dart';

import 'package:TimePass/chat/Chat/Search.dart';
import 'package:TimePass/chat/globalchat.dart';
import 'package:TimePass/tabs/tabs.dart';
import 'package:TimePass/Media/playlist.dart';

class tabbase extends StatelessWidget {
  final String tabName;

  tabbase({@required this.tabName});

  @override
  Widget build(BuildContext context) {
    Tabs_Controller(String tabs) {
      switch (tabs) {
        case "Breakfast":
          return Search();
          break;
        case "Lunch":
          return globalchat();
          break;
      }
    }

    Size size = MediaQuery.of(context).size;
    return Tabs_Controller(this.tabName);
  }
}

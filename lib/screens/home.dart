import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:templering/screens/blog/blogs_screen.dart';
import 'package:templering/screens/blog/component/adds.dart';
import 'package:templering/screens/mp3playerwidget.dart';
import 'package:templering/screens/slider.dart';
import 'package:templering/utils/appscaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hasLeadingWidget: false,
      isCenterTitle: true,
      appBarTitle: Text(
        "Temple Ring",
        style:
            primaryTextStyle(color: black, weight: FontWeight.bold, size: 18),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 16),
        children: [
          SliderWidget(),
          BannerAdWidget(
            adUnitId: 'ca-app-pub-3940256099942544/6300978111',
          ),
          MP3PlayerWidget(assetPath: "sound/slow_spring_board.mp3"),
          Blogs(),
        ],
      ),
    );
  }
}

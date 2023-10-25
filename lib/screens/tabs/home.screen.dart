import 'package:flutter/material.dart';
import 'package:mohoro/widgets/headline.slider.dart';
import 'package:mohoro/widgets/hot.news.dart';
import 'package:mohoro/widgets/top.channels.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        HeadlineSliderWidget(),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "Top Channels",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 17.0,
            ),
          ),
        ),
        TopChannels(),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "Hot News",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 17.0,
            ),
          ),
        ),
        HotNews(),
      ],
    );
  }
}

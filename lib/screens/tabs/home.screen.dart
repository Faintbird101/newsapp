import 'package:flutter/material.dart';
import 'package:mohoro/common.libs.dart';
import 'package:mohoro/screens/hot.news.screen.dart';
import 'package:mohoro/screens/tabs/sources.screen.dart';
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
      children: [
        const HeadlineSliderWidget(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
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
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SourceScreen()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(
                  "See all",
                  style: TextStyle(
                    color: $styles.colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                  ),
                ),
              ),
            ),
          ],
        ),
        const TopChannels(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
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
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HotNewsScreen()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(
                  "See all",
                  style: TextStyle(
                    color: $styles.colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                  ),
                ),
              ),
            ),
          ],
        ),
        const HotNews()
      ],
    );
  }
}

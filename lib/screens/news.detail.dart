import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:mohoro/model/article.model.dart';
import 'package:mohoro/style/theme.dart' as style;
// import 'package:timeago/timeago.dart' as timeago;
// import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NewsDetail extends StatefulWidget {
  final ArticleModel article;
  const NewsDetail({super.key, required this.article});

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: GestureDetector(
        onTap: () {
          launchUrlString(widget.article.url);
        },
        child: Container(
          color: Colors.deepPurple.shade300,
          height: 48.0,
          width: width,
          child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Read More",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
              ]),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade300,
        elevation: 0.0,
        title: Text(
          widget.article.title,
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: FadeInImage.assetNetwork(
              placeholder: "assets/error.png",
              image: widget.article.urlToImage!,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(
              10.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  widget.article.publishedAt.substring(0, 10),
                  style: TextStyle(
                    color: Colors.deepPurple.shade300,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  widget.article.title,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  widget.article.description,
                  style: const TextStyle(
                      color: Colors.black,
                      // fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  widget.article.author!,
                  style: TextStyle(
                      color: Colors.deepPurple.shade300,
                      // fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                ),
                // Html(data: widget.article.content),
              ],
            ),
          )
        ],
      ),
    );
  }
}

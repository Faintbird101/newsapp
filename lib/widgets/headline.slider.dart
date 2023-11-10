import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mohoro/bloc/get.hot.news.dart';
import 'package:mohoro/bloc/get.top.headlines.bloc.dart';
// import 'package:mohoro/bloc/get.top.headlines.bloc.dart';
import 'package:mohoro/elements/error.element.dart';
import 'package:mohoro/elements/loader.element.dart';
import 'package:mohoro/model/article.model.dart';
import 'package:mohoro/model/article.response.dart';
import 'package:mohoro/screens/news.detail.dart';
import 'package:timeago/timeago.dart' as timeago;

class HeadlineSliderWidget extends StatefulWidget {
  const HeadlineSliderWidget({super.key});

  @override
  State<HeadlineSliderWidget> createState() => _HeadlineSliderWidgetState();
}

class _HeadlineSliderWidgetState extends State<HeadlineSliderWidget> {
  @override
  void initState() {
    super.initState();
    // getHotNewsBloc.getHotNews();
    getTopHeadlinesBloc.getHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ArticleResponse>(
      stream: getTopHeadlinesBloc.subject.stream,
      // stream: getHotNewsBloc.subject.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != null && snapshot.data!.error.isNotEmpty) {
            return buildErrorWidget(snapshot.data!.error);
          }
          return _buildHeadlineSlider(snapshot.data);
        } else if (snapshot.hasError) {
          return buildErrorWidget(snapshot.data!.error);
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildHeadlineSlider(ArticleResponse? data) {
    List<ArticleModel> articles = data!.articles;
    return CarouselSlider(
      options: CarouselOptions(
        enlargeCenterPage: false,
        height: 200.0,
        viewportFraction: 0.9,
      ),
      items: getExpenseSlider(articles),
    );
  }

  getExpenseSlider(List<ArticleModel> articles) {
    return articles
        .map(
          (article) => GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewsDetail(
                          article: article,
                        )),
              );
              log("clicked on header");
            },
            child: Container(
              padding: const EdgeInsets.only(
                left: 5.0,
                right: 5.0,
                top: 10.0,
                bottom: 10.0,
              ),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: article.urlToImage!,
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: imageProvider,
                          ),
                        ),
                      );
                    },
                    progressIndicatorBuilder: (context, url, progress) {
                      return Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          shape: BoxShape.rectangle,
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                    errorWidget: (context, url, error) {
                      return Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          shape: BoxShape.rectangle,
                        ),
                        child: Center(
                          child: Image.asset("assets/error.png"),
                        ),
                      );
                    },
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0)),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          stops: const [0.1, 0.9],
                          colors: [
                            Colors.black.withOpacity(0.9),
                            Colors.white.withOpacity(0.0)
                          ],
                        )),
                  ),
                  Positioned(
                    bottom: 30.0,
                    child: Container(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      width: 250.0,
                      child: Column(
                        children: [
                          Text(
                            article.title,
                            style: const TextStyle(
                              height: 1.5,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10.0,
                    left: 10.0,
                    child: Text(
                      article.source.name,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 9.0,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10.0,
                    right: 10.0,
                    child: Text(
                      timeAgo(DateTime.parse(article.publishedAt)),
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 9.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        .toList();
  }

  String timeAgo(DateTime date) {
    return timeago.format(date, allowFromNow: true, locale: 'en');
  }
}

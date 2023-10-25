import 'package:flutter/material.dart';
import 'package:mohoro/bloc/get.source.news.bloc.dart';
import 'package:mohoro/common.libs.dart';
import 'package:mohoro/elements/error.element.dart';
import 'package:mohoro/elements/loader.element.dart';
import 'package:mohoro/model/article.model.dart';
import 'package:mohoro/model/article.response.dart';
import 'package:mohoro/model/source.model.dart';
import 'package:mohoro/screens/news.detail.dart';
import 'package:mohoro/style/theme.dart' as style;
import 'package:timeago/timeago.dart' as timeago;

class SourceDetail extends StatefulWidget {
  final SourceModel source;
  const SourceDetail({super.key, required this.source});

  @override
  State<SourceDetail> createState() => _SourceDetailState();
}

class _SourceDetailState extends State<SourceDetail> {
  @override
  void initState() {
    super.initState();
    getSourceNewsBloc.getSourceNews(widget.source.id);
  }

  @override
  void dispose() {
    super.dispose();
    getSourceNewsBloc.drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
        child: AppBar(
          backgroundColor: $styles.colors.greyMedium,
          title: const Text(""),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15.0,
              bottom: 15.0,
            ),
            color: $styles.colors.greyMedium,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Hero(
                  tag: widget.source.id,
                  child: SizedBox(
                    height: 80.0,
                    width: 80.0,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2.0,
                          color: Colors.white,
                        ),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/logos/${widget.source.id}.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  widget.source.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  widget.source.description,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<ArticleResponse?>(
              stream: getSourceNewsBloc.subject.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != null &&
                      snapshot.data!.error.isNotEmpty) {
                    return buildErrorWidget(snapshot.data!.error);
                  }
                  return _buildSourceNews(snapshot.data);
                } else if (snapshot.hasError) {
                  return buildErrorWidget(snapshot.data!.error);
                } else {
                  return buildLoadingWidget();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSourceNews(ArticleResponse? data) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    List<ArticleModel> articles = data!.articles;
    if (articles.isEmpty) {
      return SizedBox(
        width: width,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("No articles"),
          ],
        ),
      );
    } else {
      return ListView.builder(
        // scrollDirection: Axis.horizontal,
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewsDetail(
                          article: articles[index],
                        )),
              );
            },
            child: Container(
              // width: 50.0,
              height: 150.0,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    color: Colors.grey.shade200,
                    width: 1.0,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    width: width * 3 / 5,
                    child: Column(
                      children: [
                        Text(
                          articles[index].title,
                          style: const TextStyle(
                            height: 1.4,
                            color: Colors.black,
                            fontSize: 14.0,
                          ),
                        ),
                        Expanded(
                          child: Align(
                            child: Row(
                              children: [
                                Text(
                                  timeAgo(DateTime.parse(
                                      articles[index].publishedAt)),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 10.0,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(6.0),
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(
                        right: 10.0,
                      ),
                      width: width * 2 / 5,
                      height: 130.0,
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/error.png',
                        image: articles[index].urlToImage!,
                        fit: BoxFit.fitHeight,
                        width: double.maxFinite,
                        height: height * 1 / 3,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    }
  }

  String timeAgo(DateTime date) {
    return timeago.format(date, allowFromNow: true, locale: 'en');
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:mohoro/bloc/get.hot.news.dart';
import 'package:mohoro/bloc/get.top.headlines.bloc.dart';
import 'package:mohoro/common.libs.dart';
import 'package:rxdart/subjects.dart';
import 'package:timeago/timeago.dart' as timeago;

class HotNewsScreen extends StatefulWidget {
  const HotNewsScreen({super.key});

  @override
  State<HotNewsScreen> createState() => _HotNewsScreenState();
}

class _HotNewsScreenState extends State<HotNewsScreen> {
  @override
  void initState() {
    super.initState();
    getHotNewsBloc.getHotNews(selectedValue);
    // getTopHeadlinesBloc.getHeadlines();
  }

  String selectedValue = "General News";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: $styles.colors.deepPurple,
        title: Text(
          "HotNews",
          style: $styles.text.h4.copyWith(
            color: $styles.colors.offWhite,
          ),
        ),
        actions: [
          DropdownButton<String>(
            value: selectedValue,
            items: <String>[
              'Businesss',
              'Education',
              'General News',
              'Health',
              'Politics',
              'Science',
              'Sports',
              'Tech',
              'Travel',
            ].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) async {
              setState(() {
                selectedValue = newValue!;
              });
              await getHotNewsBloc.getHotNews(selectedValue);
            },
          ),
        ],
      ),
      body: StreamBuilder<ArticleResponse>(
        stream: getHotNewsBloc.subject.stream,
        // stream: getTopHeadlinesBloc.subject.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null && snapshot.data!.error.isNotEmpty) {
              return buildErrorWidget(snapshot.data!.error);
            }
            return _buildHotNewsScreen(snapshot.data);
          } else if (snapshot.hasError) {
            return buildErrorWidget(snapshot.data!.error);
          } else {
            return buildLoadingWidget();
          }
        },
      ),
    );
  }

  Widget _buildHotNewsScreen(ArticleResponse? data) {
    List<ArticleModel> articles = data!.articles;
    return Container(
      height: articles.length / 2 * 210.0,
      padding: const EdgeInsets.all(5.0),
      child: GridView.builder(
        itemCount: articles.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.85,
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(
              left: 5.0,
              right: 5.0,
              top: 10.0,
            ),
            child: GestureDetector(
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
                width: 220.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade100,
                      blurRadius: 5.0,
                      spreadRadius: 1.0,
                      offset: const Offset(
                        1.0,
                        1.0,
                      ),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: CachedNetworkImage(
                        imageUrl: articles[index].urlToImage!,
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                topRight: Radius.circular(8.0),
                              ),
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
                      // Container(
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.only(
                      //       topLeft: Radius.circular(5.0),
                      //       topRight: Radius.circular(5.0),
                      //     ),
                      //     // image: DecorationImage(image: image)
                      //   ),
                      // ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        left: 10.0,
                        right: 10.0,
                        top: 10.0,
                        bottom: 15.0,
                      ),
                      color: Colors.grey.shade100,
                      child: Text(
                        articles[index].title,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: const TextStyle(
                          height: 1.3,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        // Container(
                        //   padding: EdgeInsets.only(
                        //     left: 10.0,
                        //     right: 10.0,
                        //   ),
                        //   width: 180.0,
                        //   height: 1.0,
                        //   color: Colors.black12,
                        // ),
                        const Divider(
                          height: 1.0,
                          color: Colors.black45,
                        ),
                        Container(
                          width: 30.0,
                          height: 3.0,
                          color: $styles.colors.deepPurple,
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(
                        10.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            articles[index].source.name,
                            style: TextStyle(
                              color: $styles.colors.deepPurple,
                              fontSize: 9.0,
                            ),
                            maxLines: 2,
                          ),
                          Text(
                            timeAgo(DateTime.parse(articles[index].publishedAt)),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 9.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String timeAgo(DateTime date) {
    return timeago.format(date, allowFromNow: true, locale: 'en');
  }
}

// class GetHotNewsBloc {
//   final NewsRepository _repository = NewsRepository();
//   final BehaviorSubject<ArticleResponse> _subject =
//       BehaviorSubject<ArticleResponse>();

//   getHotNews(String selectedQuery ) async {
//     ArticleResponse response = await _repository.getHotNews(selectedQuery);
//     _subject.sink.add(response);
//   }

//   dispose() {
//     _subject.close();
//   }

//   BehaviorSubject<ArticleResponse> get subject => _subject;
// }

// final getHotNewsBloc = GetHotNewsBloc();


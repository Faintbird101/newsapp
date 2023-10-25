import 'dart:developer';

import 'package:mohoro/common.libs.dart';
import 'package:timeago/timeago.dart' as timeago;

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchBloc.search("");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(
            10.0,
          ),
          child: TextFormField(
            style: const TextStyle(fontSize: 14.0, color: Colors.black),
            controller: _searchCtrl,
            onChanged: (value) {
              searchBloc.search(_searchCtrl.text);
            },
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              fillColor: Colors.grey.shade100,
              suffixIcon: _searchCtrl.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          FocusScope.of(context).requestFocus(
                            FocusNode(),
                          );
                          _searchCtrl.clear();
                          searchBloc.search(_searchCtrl.text);
                        });
                      },
                      icon: const Icon(Icons.backspace_outlined))
                  : Icon(
                      Icons.search_rounded,
                      color: Colors.grey.shade500,
                      size: 16.0,
                    ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: $styles.colors.offWhite,
                  )),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                      color: $styles.colors.deepPurple.withOpacity(0.3))),
              contentPadding: const EdgeInsets.only(
                left: 15.0,
                right: 10.0,
              ),
              labelText: "Search...",
              hintStyle: TextStyle(
                fontSize: 14.0,
                color: $styles.colors.greyStrong,
                fontWeight: FontWeight.w500,
              ),
              labelStyle: TextStyle(
                fontSize: 14.0,
                color: Colors.grey.shade300,
                fontWeight: FontWeight.w500,
              ),
            ),
            autocorrect: false,
          ),
        ),
        Expanded(
          child: StreamBuilder<ArticleResponse>(
            stream: searchBloc.subject.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != null && snapshot.data!.error.isNotEmpty) {
                  return buildErrorWidget(snapshot.data!.error);
                }
                return _buildSearchNews(snapshot.data);
              } else if (snapshot.hasError) {
                log(snapshot.data!.error);
                return buildErrorWidget(snapshot.data!.error);
              } else {
                return buildLoadingWidget();
              }
            },
          ),
        )
      ],
    );
  }

  Widget _buildSearchNews(ArticleResponse? data) {
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

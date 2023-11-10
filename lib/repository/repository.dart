import 'dart:convert';
import 'dart:developer';

import 'package:mohoro/common.libs.dart';

class NewsRepository {
  static String mainUrl = "https://newsapi.org/v2/";
  final String apiKey = "6a9d18fad44e475fbfe072ee01c207bf";
  //  vkinyua3@gmail.com = "79e2c9073b1e47889ea9743f51171e37"

  final Dio _dio = Dio();

  var getSourcesUrl = "$mainUrl/sources";
  var getTopHeadlinesUrl = "$mainUrl/top-headlines";
  var everythingUrl = "$mainUrl/everything";

  Future<SourceResponse> getSources() async {
    var params = {
      "apiKey": apiKey,
      "language": "en",
      "country": "us",
    };
    try {
      Response response = await _dio.get(getSourcesUrl, queryParameters: params);
      return SourceResponse.fromJson(response.data);
    } catch (e, stacktrace) {
      log("Exception in sources occured: $e stackTrace: $stacktrace");
      return SourceResponse.withError("$e");
    }
  }

  // Future<ArticleResponse> getTopHeadlines() async {
  //   var params = {
  //     "apiKey": apiKey,
  //     "country": "us",
  //   };
  //   Response response = await _dio
  //       .get(getTopHeadlinesUrl, queryParameters: params)
  //       .then((value) => value)
  //       .catchError((e) {
  //     ArticleResponse.withError("$e");
  //   });
  //   return ArticleResponse.fromJson(response.data);
  //   // try {
  //   // } catch (e, stacktrace) {
  //   //   log("Exception in topheadlines occured: $e stackTrace: $");
  //   //   return ArticleResponse.withError("$e");
  //   // }
  // }

  Future<ArticleResponse> getTopHeadlines() {
    var params = {
      "apiKey": apiKey,
      "country": "us",
    };

    return _dio.get(getTopHeadlinesUrl, queryParameters: params).then((Response response) {
      log(jsonEncode(response.data));
      final responseModel = responseModelFromJson(jsonEncode(response.data));
      return ArticleResponse.fromJson(response.data);
    }).catchError((e) {
      log("Exception in topheadlines occurred: $e");
      throw e;
    });
  }

  // Future<ArticleResponse> getTopHeadlines() async {
  //   var params = {
  //     "apiKey": apiKey,
  //     "country": "us",
  //     "category": "business",
  //   };

  //   try {
  //     Response response =
  //         await _dio.get(getTopHeadlinesUrl, queryParameters: params);
  //     // List<dynamic> parsedData = jsonDecode(response.data);
  //     // log(jsonEncode(response.data));
  //     return convertResponseToArticleResponse(response);
  //   } catch (e, stacktrace) {
  //     log("Exception in topheadlines occurred: $e stackTrace: $stacktrace");
  //     throw e;
  //   }
  // }

  ArticleResponse convertResponseToArticleResponse(Response response) {
    final responseModel = responseModelFromJson(jsonEncode(response.data));
    return ArticleResponse.fromJson({"articles": responseModel.articles});
  }

  Future<ArticleResponse> getHotNews(selectedQuery) async {
    var params = {
      "apiKey": apiKey,
      "q": selectedQuery,
      "sortBy": "popularity",
    };
    try {
      Response response = await _dio.get(everythingUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    } catch (e, stacktrace) {
      log("Exception in hotnews occured: $e stackTrace: $stacktrace");
      return ArticleResponse.withError("$e");
    }
  }

  Future<ArticleResponse> getSourceNews(String sourceId) async {
    var params = {
      "apiKey": apiKey,
      "sources": sourceId,
    };
    try {
      Response response = await _dio.get(getTopHeadlinesUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    } catch (e, stacktrace) {
      log("Exception in sourcenews occured: $e stackTrace: $stacktrace");
      return ArticleResponse.withError("$e");
    }
  }

  Future<ArticleResponse> search(String searchValue) async {
    var params = {
      "apiKey": apiKey,
      "q": searchValue,
    };
    try {
      Response response = await _dio.get(getTopHeadlinesUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    } catch (e, stacktrace) {
      log("Exception in topheadlines occured: $e stackTrace: $stacktrace");
      return ArticleResponse.withError("$e");
    }
  }
}

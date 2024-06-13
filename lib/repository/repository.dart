import 'dart:convert';
import 'dart:developer';

import 'package:mohoro/common.libs.dart';

class NewsRepository {
  static String mainUrl = "YOUR-MAIN-URL"; //**REPLACE THIS WITH YOUR MAIN URL**//
  static String localUrl = "YOUR-LOCAL-URL"; //**REPLACE THIS WITH YOUR LOCAL URL**//
  final String apiKey = "YOUR-API-KEY"; //**REPLACE THIS WITH YOUR API KEY**//

  final Dio _dio = Dio();

  var getSourcesUrl = "$mainUrl/sources";
  var getTopHeadlinesUrl = "$mainUrl/top-headlines";
  // var everythingUrl = "$mainUrl/everything";
  var everythingUrl = "$localUrl/getData";

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
      // log("ndio hii data:${response.data}");
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

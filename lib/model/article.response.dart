import 'package:mohoro/model/article.model.dart';
// import 'package:mohoro/model/response.model.dart';

class ArticleResponse {
  final List<ArticleModel> articles;
  final String error;

  ArticleResponse(
    this.articles,
    this.error,
  );

  ArticleResponse.fromJson(Map<String, dynamic> json)
      : articles = (json["articles"] as List)
            .map((i) => ArticleModel.fromJson(i))
            .toList(),
        error = "";

  ArticleResponse.withError(String errorValue)
      : articles = List<ArticleModel>.empty(),
        error = errorValue;
}


// class ArticleResponse {
//   final ResponseModel responseModel;
//   final List<ArticleModel> articles;
//   final String error;

//   ArticleResponse(this.responseModel, this.articles, this.error);

//   ArticleResponse.fromJson(Map<String, dynamic> json)
//       : responseModel = ResponseModel.fromJson(json),
//         articles = (json["articles"] as List)
//             .map((i) => ArticleModel.fromJson(i))
//             .toList(),
//         error = "";

//   ArticleResponse.withError(String errorValue)
//       : responseModel =
//             ResponseModel(status: "", totalResults: 0, articles: []),
//         articles = List<ArticleModel>.empty(),
//         error = errorValue;
// }

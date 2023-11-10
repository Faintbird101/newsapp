import 'package:mohoro/model/source.model.dart';

class ArticleModel {
  final SourceModel source;
  final String? author;
  final String title;
  final String description;
  final String url;
  final String? urlToImage;
  final String publishedAt;
  final String content;

  const ArticleModel({
    required this.source,
    required this.author,
  required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> map) {
    return ArticleModel(
      source: SourceModel.fromJson(map['source']),
      author: map['author'] ?? "",
      title: map['title'] ?? "",
      description: map['description'] ?? "No description",
      url: map['url'] ?? map["name"] ?? "",
      urlToImage: map['urlToImage'] ?? "No image",
      publishedAt: map['publishedAt'] ?? "",
      content: map['content'] ?? "",
    );
  }
}

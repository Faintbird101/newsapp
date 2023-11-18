import 'package:rxdart/subjects.dart';
import 'package:mohoro/common.libs.dart';


class GetHotNewsBloc {
  final NewsRepository _repository = NewsRepository();
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final BehaviorSubject<ArticleResponse> _subject =
      BehaviorSubject<ArticleResponse>();

  getHotNews(String selectedQuery) async {
    ArticleResponse response = await _repository.getHotNews(selectedQuery);

        // Save articles to the database
    await _databaseHelper.saveArticles(response.articles);

    // Fetch articles from the database and update the subject
    List<ArticleModel> savedArticles = await _databaseHelper.getArticles();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<ArticleResponse> get subject => _subject;

}

final getHotNewsBloc = GetHotNewsBloc();

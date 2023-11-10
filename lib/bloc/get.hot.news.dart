import 'package:rxdart/subjects.dart';
import 'package:mohoro/common.libs.dart';


class GetHotNewsBloc {
  final NewsRepository _repository = NewsRepository();
  final BehaviorSubject<ArticleResponse> _subject =
      BehaviorSubject<ArticleResponse>();

  getHotNews(String selectedQuery) async {
    ArticleResponse response = await _repository.getHotNews(selectedQuery);
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<ArticleResponse> get subject => _subject;
}

final getHotNewsBloc = GetHotNewsBloc();

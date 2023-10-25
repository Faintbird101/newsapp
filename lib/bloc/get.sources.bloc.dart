import 'package:mohoro/model/source.response.dart';
import 'package:mohoro/repository/repository.dart';
import 'package:rxdart/subjects.dart';

class GetSourcesBloc {
  final NewsRepository _repository = NewsRepository();
  final BehaviorSubject<SourceResponse> _subject =
      BehaviorSubject<SourceResponse>();

  getSources() async {
    SourceResponse response = await _repository.getSources();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<SourceResponse> get subject => _subject;
  
}
final getSourcesBloc = GetSourcesBloc();
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/book_model.dart';
part 'library_state.freezed.dart';

@freezed
class LibraryState with _$LibraryState {
  const factory LibraryState.initial() = _Initial;
  const factory LibraryState.loading() = _Loading;
  const factory LibraryState.loaded(List<BookModel> books) = _Loaded;
  const factory LibraryState.error(String message) = _Error;
}

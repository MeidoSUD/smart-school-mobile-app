import 'package:injectable/injectable.dart';
import '../../../../core/network/api_result.dart';
import '../../data/models/book_model.dart';
import '../repositories/library_repository.dart';

@lazySingleton
class GetBooksUseCase {
  final LibraryRepository _repository;
  GetBooksUseCase(this._repository);
  Future<ApiResult<List<BookModel>>> execute() => _repository.getBooks();
}

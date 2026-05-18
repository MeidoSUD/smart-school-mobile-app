import '../../../../core/network/api_result.dart';
import '../../data/models/book_model.dart';

abstract class LibraryRepository {
  Future<ApiResult<List<BookModel>>> getBooks();
  Future<ApiResult<List<BookModel>>> getIssuedBooks();
}

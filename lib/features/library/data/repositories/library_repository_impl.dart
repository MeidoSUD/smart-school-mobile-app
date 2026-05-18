import 'package:injectable/injectable.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/api_result.dart';
import '../models/book_model.dart';
import '../../domain/repositories/library_repository.dart';

@Injectable(as: LibraryRepository)
class LibraryRepositoryImpl implements LibraryRepository {
  @override
  Future<ApiResult<List<BookModel>>> getBooks() async {
    if (AppConstants.useDummyData) {
      return ApiResult.success([
        const BookModel(id: 1, title: 'Mathematics Textbook', author: 'Dr. Ahmed', issueDate: '2024-01-01', returnDate: '2024-02-01'),
        const BookModel(id: 2, title: 'Science Encyclopedia', author: 'Prof. Sara', issueDate: '2024-01-05', returnDate: '2024-02-05'),
        const BookModel(id: 3, title: 'English Literature', author: 'Mr. John', issueDate: '2024-01-10', returnDate: '2024-02-10'),
      ]);
    }
    // TODO: Implement API call
    return const ApiResult.success([]);
  }

  @override
  Future<ApiResult<List<BookModel>>> getIssuedBooks() async {
    if (AppConstants.useDummyData) {
      return ApiResult.success([
        const BookModel(id: 1, title: 'Mathematics Textbook', author: 'Dr. Ahmed', issueDate: '2024-01-01', returnDate: '2024-02-01'),
      ]);
    }
    // TODO: Implement API call
    return const ApiResult.success([]);
  }
}

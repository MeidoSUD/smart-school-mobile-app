import '../../../../core/network/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/get_books_usecase.dart';
import 'library_state.dart';

@injectable
class LibraryCubit extends Cubit<LibraryState> {
  final GetBooksUseCase _getBooksUseCase;
  LibraryCubit(this._getBooksUseCase) : super(const LibraryState.initial());

  Future<void> loadBooks() async {
    emit(const LibraryState.loading());
    final result = await _getBooksUseCase.execute();
    result.when(
      success: (books) => emit(LibraryState.loaded(books)),
      failure: (failure) => emit(LibraryState.error(failure.message)),
    );
  }
}

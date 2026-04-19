import 'package:geniuses_school/core/utils/logger.dart';
import 'package:geniuses_school/data/models/booking_model.dart';
// booking_provider.dart
import 'package:geniuses_school/data/models/books_model.dart';
import 'package:geniuses_school/data/models/pagination_model.dart';
import 'package:geniuses_school/data/repositories/booking_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum BookStatus { success, error, loading, init }

class BookState {
  final List<BookingModel> bookingModel;
  final BookStatus status;
  final String message;
  final int? bookingId;

  BookState({
    required this.bookingModel,
    required this.status,
    required this.message,
    this.bookingId,
  });

  BookState copyWith({
    List<BookingModel>? bookingModel,
    BookStatus? status,
    String? message,
    int? bookingId,
  }) {
    return BookState(
      bookingModel: bookingModel ?? this.bookingModel,
      status: status ?? this.status,
      message: message ?? this.message,
      bookingId: bookingId ?? this.bookingId,
    );
  }
}

// Repository Provider
final bookingRepositoryProvider = Provider((ref) => BookingRepository());

// StateNotifier Provider
final bookingProvider =
    StateNotifierProvider<BookingNotifier, AsyncValue<BookState>>(
      (ref) => BookingNotifier(ref.watch(bookingRepositoryProvider)),
    );

class BookingNotifier extends StateNotifier<AsyncValue<BookState>> {
  final BookingRepository _repository;

  BookingNotifier(this._repository)
    : super(
        AsyncValue.data(
          BookState(bookingModel: [], status: BookStatus.init, message: ""),
        ),
      ) {
    getBookings();
  }

  Future<void> getBookings() async {
    try {
      state = AsyncValue.data(
        BookState(
          bookingModel: [],
          status: BookStatus.init,
          message: "",
          bookingId: null,
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addBooking(BookingModel booking) async {
    try {
      final previous =
          state.value ??
          BookState(
            bookingModel: [],
            status: BookStatus.loading,
            message: "",
            bookingId: null,
          );

      state = AsyncValue.data(
        BookState(
          bookingModel: [],
          status: BookStatus.loading,
          message: "",
          bookingId: null,
        ),
      );

      final result = await _repository.addBooking(booking);

      final updatedBookings = [...previous.bookingModel, booking];
      final bookingId = result['booking_id'] as int?;

      state = AsyncValue.data(
        previous.copyWith(
          bookingModel: updatedBookings,
          status: result['success'] ? BookStatus.success : BookStatus.error,
          message: result['message'],
          bookingId: bookingId,
        ),
      );
    } catch (error) {
      state = AsyncValue.data(
        BookState(
          bookingModel: [],
          status: BookStatus.error,
          message: error.toString(),
          bookingId: null,
        ),
      );
    }
  }
}

class BooksState {
  final List<BooksModel> bookings;
  final PaginationInfo pagination;
  final bool isLoadingMore;
  final bool hasError;

  BooksState({
    required this.bookings,
    required this.pagination,
    this.isLoadingMore = false,
    this.hasError = false,
  });

  BooksState copyWith({
    List<BooksModel>? bookings,
    PaginationInfo? pagination,
    bool? isLoadingMore,
    bool? hasError,
  }) {
    return BooksState(
      bookings: bookings ?? this.bookings,
      pagination: pagination ?? this.pagination,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasError: hasError ?? this.hasError,
    );
  }
}

class BooksNotifier extends StateNotifier<AsyncValue<BooksState>> {
  final BookingRepository _repository;
  int _currentPage = 1;

  BooksNotifier(this._repository) : super(const AsyncValue.loading()) {
    getBooks();
  }

  Future<void> getBooks({bool refresh = false}) async {
    try {
      if (refresh) {
        _currentPage = 1;
        state = const AsyncValue.loading();
      } else if (state.value == null) {
        state = const AsyncValue.loading();
      }

      final result = await _repository.getBookings(page: _currentPage);
      final bookings = result['bookings'] as List<BooksModel>;
      final pagination = result['pagination'] as PaginationInfo;

      Logger.log("Books fetched: ${bookings.map((b) => b.toJson()).toList()}");
      Logger.log("Pagination: page=${pagination.currentPage}, hasMore=${pagination.hasMore}");

      if (refresh || _currentPage == 1) {
        state = AsyncValue.data(BooksState(
          bookings: bookings,
          pagination: pagination,
        ));
      } else {
        final currentState = state.value;
        if (currentState != null) {
          state = AsyncValue.data(currentState.copyWith(
            bookings: [...currentState.bookings, ...bookings],
            pagination: pagination,
            isLoadingMore: false,
          ));
        }
      }
    } catch (e, st) {
      Logger.log("Error fetching books: $e");
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> loadMore() async {
    final currentState = state.value;
    if (currentState == null || 
        currentState.isLoadingMore || 
        !currentState.pagination.hasMore) {
      return;
    }

    try {
      state = AsyncValue.data(currentState.copyWith(isLoadingMore: true));
      _currentPage++;
      await getBooks();
    } catch (e) {
      Logger.log("Error loading more: $e");
      _currentPage--;
      state = AsyncValue.data(currentState.copyWith(
        isLoadingMore: false,
        hasError: true,
      ));
    }
  }

  Future<void> refreshBookings() async {
    await getBooks(refresh: true);
  }

  Future<bool> cancelBooking(int bookingId) async {
    try {
      final result = await _repository.cancelBooking(bookingId);
      if (result['success'] == true) {
        await refreshBookings();
        return true;
      }
      return false;
    } catch (e) {
      Logger.log("Error canceling booking: $e");
      return false;
    }
  }
}

final booksProvider =
    StateNotifierProvider<BooksNotifier, AsyncValue<BooksState>>(
      (ref) => BooksNotifier(ref.watch(bookingRepositoryProvider)),
    );

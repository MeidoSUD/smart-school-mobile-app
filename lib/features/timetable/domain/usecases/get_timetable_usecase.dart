import 'package:injectable/injectable.dart';
import '../../../../core/network/api_result.dart';
import '../../data/models/timetable_model.dart';
import '../repositories/timetable_repository.dart';

@lazySingleton
class GetTimetableUseCase {
  final TimetableRepository _repository;
  GetTimetableUseCase(this._repository);
  Future<ApiResult<List<TimetableModel>>> execute() => _repository.getTimetable();
}

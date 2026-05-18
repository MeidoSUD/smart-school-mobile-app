import 'package:injectable/injectable.dart';
import '../../../../core/network/api_result.dart';
import '../../data/models/exam_model.dart';
import '../repositories/exams_repository.dart';

@lazySingleton
class GetExamScheduleUseCase {
  final ExamsRepository _repository;
  GetExamScheduleUseCase(this._repository);
  Future<ApiResult<List<ExamModel>>> execute() => _repository.getExamSchedule();
}

import 'package:injectable/injectable.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/api_result.dart';
import '../models/exam_model.dart';
import '../../domain/repositories/exams_repository.dart';

@Injectable(as: ExamsRepository)
class ExamsRepositoryImpl implements ExamsRepository {
  @override
  Future<ApiResult<List<ExamModel>>> getExamSchedule() async {
    if (AppConstants.useDummyData) {
      return ApiResult.success([
        const ExamModel(id: 1, subject: 'Mathematics', date: '2024-02-01', time: '09:00', room: 'Hall A'),
        const ExamModel(id: 2, subject: 'Science', date: '2024-02-03', time: '10:00', room: 'Hall B'),
        const ExamModel(id: 3, subject: 'English', date: '2024-02-05', time: '09:00', room: 'Hall A'),
        const ExamModel(id: 4, subject: 'History', date: '2024-02-07', time: '11:00', room: 'Hall C'),
      ]);
    }
    // TODO: Implement API call
    return const ApiResult.success([]);
  }
}

import 'package:injectable/injectable.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/api_result.dart';
import '../models/online_exam_model.dart';
import '../../domain/repositories/online_exam_repository.dart';

@Injectable(as: OnlineExamRepository)
class OnlineExamRepositoryImpl implements OnlineExamRepository {
  @override
  Future<ApiResult<List<OnlineExamModel>>> getOnlineExams() async {
    if (AppConstants.useDummyData) {
      return ApiResult.success([
        const OnlineExamModel(id: 1, title: 'Math Quiz 1', subject: 'Mathematics', duration: 60, totalQuestions: 20, status: 'available'),
        const OnlineExamModel(id: 2, title: 'Science Test', subject: 'Science', duration: 45, totalQuestions: 15, status: 'completed'),
        const OnlineExamModel(id: 3, title: 'English Grammar', subject: 'English', duration: 30, totalQuestions: 10, status: 'upcoming'),
      ]);
    }
    // TODO: Implement API call
    return const ApiResult.success([]);
  }
}

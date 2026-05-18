import 'package:injectable/injectable.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/api_result.dart';
import '../models/homework_model.dart';
import '../../domain/repositories/homework_repository.dart';

@Injectable(as: HomeworkRepository)
class HomeworkRepositoryImpl implements HomeworkRepository {
  @override
  Future<ApiResult<List<HomeworkModel>>> getHomework() async {
    if (AppConstants.useDummyData) {
      return ApiResult.success([
        const HomeworkModel(id: 1, title: 'Math Exercises', description: 'Complete chapter 5 exercises', subject: 'Mathematics', dueDate: '2024-01-20', status: 'pending', createdAt: '2024-01-10'),
        const HomeworkModel(id: 2, title: 'Science Report', description: 'Write a report on photosynthesis', subject: 'Science', dueDate: '2024-01-22', status: 'completed', createdAt: '2024-01-11'),
        const HomeworkModel(id: 3, title: 'English Essay', description: 'Write an essay on your favorite book', subject: 'English', dueDate: '2024-01-25', status: 'pending', createdAt: '2024-01-12'),
      ]);
    }
    // TODO: Implement API call
    return const ApiResult.success([]);
  }

  @override
  Future<ApiResult<HomeworkModel>> getHomeworkDetail(int id, int status) async {
    if (AppConstants.useDummyData) {
      return ApiResult.success(
        const HomeworkModel(id: 1, title: 'Math Exercises', description: 'Complete chapter 5 exercises', subject: 'Mathematics', dueDate: '2024-01-20', status: 'pending', createdAt: '2024-01-10'),
      );
    }
    // TODO: Implement API call
    return const ApiResult.success(HomeworkModel());
  }

  @override
  Future<ApiResult<void>> uploadHomework({required int homeworkId, String? message, String? filePath}) async {
    if (AppConstants.useDummyData) {
      return const ApiResult.success(null);
    }
    // TODO: Implement API call
    return const ApiResult.success(null);
  }
}

import 'package:injectable/injectable.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/api_result.dart';
import '../models/syllabus_model.dart';
import '../../domain/repositories/syllabus_repository.dart';

@Injectable(as: SyllabusRepository)
class SyllabusRepositoryImpl implements SyllabusRepository {
  @override
  Future<ApiResult<List<SyllabusModel>>> getSyllabus() async {
    if (AppConstants.useDummyData) {
      return ApiResult.success([
        const SyllabusModel(id: 1, subject: 'Mathematics', topic: 'Algebra', status: 'completed'),
        const SyllabusModel(id: 2, subject: 'Mathematics', topic: 'Geometry', status: 'in_progress'),
        const SyllabusModel(id: 3, subject: 'Science', topic: 'Physics', status: 'pending'),
        const SyllabusModel(id: 4, subject: 'English', topic: 'Grammar', status: 'completed'),
      ]);
    }
    // TODO: Implement API call
    return const ApiResult.success([]);
  }
}

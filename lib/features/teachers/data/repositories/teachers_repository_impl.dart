import 'package:injectable/injectable.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/repositories/teachers_repository.dart';
import '../models/teacher_model.dart';

@Injectable(as: TeachersRepository)
class TeachersRepositoryImpl implements TeachersRepository {
  @override
  Future<ApiResult<List<TeacherModel>>> getTeachers() async {
    if (AppConstants.useDummyData) {
      return const ApiResult.success([
        TeacherModel(
          id: 1,
          name: 'Mr. Ahmed',
          subject: 'Mathematics',
          phone: '+966501234567',
          rating: 4.5,
        ),
        TeacherModel(
          id: 2,
          name: 'Ms. Fatima',
          subject: 'Science',
          phone: '+966501234568',
          rating: 4.8,
        ),
        TeacherModel(
          id: 3,
          name: 'Mr. John',
          subject: 'English',
          phone: '+966501234569',
          rating: 4.2,
        ),
        TeacherModel(
          id: 4,
          name: 'Mrs. Sara',
          subject: 'History',
          phone: '+966501234570',
          rating: 4.6,
        ),
      ]);
    }
    // TODO: Implement API call
    return const ApiResult.success([]);
  }
}

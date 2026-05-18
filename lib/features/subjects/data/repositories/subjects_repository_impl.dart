import 'package:injectable/injectable.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/api_result.dart';
import '../models/subject_model.dart';
import '../../domain/repositories/subjects_repository.dart';

@Injectable(as: SubjectsRepository)
class SubjectsRepositoryImpl implements SubjectsRepository {
  @override
  Future<ApiResult<List<SubjectModel>>> getSubjects() async {
    if (AppConstants.useDummyData) {
      return ApiResult.success([
        const SubjectModel(id: 1, name: 'Mathematics', code: 'MATH101', teacher: 'Mr. Ahmed'),
        const SubjectModel(id: 2, name: 'Science', code: 'SCI101', teacher: 'Ms. Fatima'),
        const SubjectModel(id: 3, name: 'English', code: 'ENG101', teacher: 'Mr. John'),
        const SubjectModel(id: 4, name: 'History', code: 'HIS101', teacher: 'Mrs. Sara'),
        const SubjectModel(id: 5, name: 'Physics', code: 'PHY101', teacher: 'Dr. Omar'),
      ]);
    }
    // TODO: Implement API call
    return const ApiResult.success([]);
  }
}

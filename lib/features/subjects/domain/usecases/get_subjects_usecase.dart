import 'package:injectable/injectable.dart';
import '../../../../core/network/api_result.dart';
import '../../data/models/subject_model.dart';
import '../repositories/subjects_repository.dart';

@lazySingleton
class GetSubjectsUseCase {
  final SubjectsRepository _repository;
  GetSubjectsUseCase(this._repository);
  Future<ApiResult<List<SubjectModel>>> execute() => _repository.getSubjects();
}

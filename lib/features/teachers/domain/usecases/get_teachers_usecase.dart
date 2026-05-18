import 'package:injectable/injectable.dart';
import '../../../../core/network/api_result.dart';
import '../../data/models/teacher_model.dart';
import '../repositories/teachers_repository.dart';

@lazySingleton
class GetTeachersUseCase {
  final TeachersRepository _repository;
  GetTeachersUseCase(this._repository);
  Future<ApiResult<List<TeacherModel>>> execute() => _repository.getTeachers();
}

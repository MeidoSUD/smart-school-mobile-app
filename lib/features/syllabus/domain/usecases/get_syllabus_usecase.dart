import 'package:injectable/injectable.dart';
import '../../../../core/network/api_result.dart';
import '../../data/models/syllabus_model.dart';
import '../repositories/syllabus_repository.dart';

@lazySingleton
class GetSyllabusUseCase {
  final SyllabusRepository _repository;
  GetSyllabusUseCase(this._repository);
  Future<ApiResult<List<SyllabusModel>>> execute() => _repository.getSyllabus();
}

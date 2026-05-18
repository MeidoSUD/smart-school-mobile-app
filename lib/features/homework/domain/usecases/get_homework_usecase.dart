import 'package:injectable/injectable.dart';
import '../../../../core/network/api_result.dart';
import '../../data/models/homework_model.dart';
import '../repositories/homework_repository.dart';

@lazySingleton
class GetHomeworkUseCase {
  final HomeworkRepository _repository;
  GetHomeworkUseCase(this._repository);
  Future<ApiResult<List<HomeworkModel>>> execute() => _repository.getHomework();
}

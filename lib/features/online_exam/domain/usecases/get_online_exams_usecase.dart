import 'package:injectable/injectable.dart';
import '../../../../core/network/api_result.dart';
import '../../data/models/online_exam_model.dart';
import '../repositories/online_exam_repository.dart';

@lazySingleton
class GetOnlineExamsUseCase {
  final OnlineExamRepository _repository;

  GetOnlineExamsUseCase(this._repository);

  Future<ApiResult<List<OnlineExamModel>>> execute() {
    return _repository.getOnlineExams();
  }
}

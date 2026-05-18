import 'package:injectable/injectable.dart';
import '../../../../core/network/api_result.dart';
import '../../data/models/leave_model.dart';
import '../repositories/leave_repository.dart';

@lazySingleton
class GetLeavesUseCase {
  final LeaveRepository _repository;

  GetLeavesUseCase(this._repository);

  Future<ApiResult<List<LeaveModel>>> execute() {
    return _repository.getLeaves();
  }
}

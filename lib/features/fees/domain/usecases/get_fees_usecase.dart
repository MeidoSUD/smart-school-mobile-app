import 'package:injectable/injectable.dart';
import '../../../../core/network/api_result.dart';
import '../../data/models/fee_model.dart';
import '../repositories/fees_repository.dart';

@lazySingleton
class GetFeesUseCase {
  final FeesRepository _repository;

  GetFeesUseCase(this._repository);

  Future<ApiResult<List<FeeModel>>> execute() {
    return _repository.getFees();
  }
}

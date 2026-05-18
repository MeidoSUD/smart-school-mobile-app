import 'package:injectable/injectable.dart';
import '../../../../core/network/api_result.dart';
import '../../data/models/visitor_model.dart';
import '../repositories/visitors_repository.dart';

@lazySingleton
class GetVisitorsUseCase {
  final VisitorsRepository _repository;

  GetVisitorsUseCase(this._repository);

  Future<ApiResult<List<VisitorModel>>> execute() {
    return _repository.getVisitors();
  }
}

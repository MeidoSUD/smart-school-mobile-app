import 'package:injectable/injectable.dart';
import '../../../../core/network/api_result.dart';
import '../../data/models/hostel_model.dart';
import '../repositories/hostel_repository.dart';

@lazySingleton
class GetHostelInfoUseCase {
  final HostelRepository _repository;

  GetHostelInfoUseCase(this._repository);

  Future<ApiResult<List<HostelModel>>> execute() {
    return _repository.getHostelInfo();
  }
}

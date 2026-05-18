import 'package:injectable/injectable.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/api_result.dart';
import '../models/visitor_model.dart';
import '../../domain/repositories/visitors_repository.dart';

@Injectable(as: VisitorsRepository)
class VisitorsRepositoryImpl implements VisitorsRepository {
  @override
  Future<ApiResult<List<VisitorModel>>> getVisitors() async {
    if (AppConstants.useDummyData) {
      return ApiResult.success([
        const VisitorModel(id: 1, name: 'Ahmed Ali', reason: 'Parent Meeting', visitDate: '2024-01-15', phone: '+966501234567'),
        const VisitorModel(id: 2, name: 'Fatima Omar', reason: 'Document Submission', visitDate: '2024-01-14', phone: '+966501234568'),
        const VisitorModel(id: 3, name: 'Mohammed Hassan', reason: 'Fee Payment', visitDate: '2024-01-13', phone: '+966501234569'),
      ]);
    }
    // TODO: Implement API call
    return const ApiResult.success([]);
  }
}

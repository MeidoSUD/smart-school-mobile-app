import 'package:injectable/injectable.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/api_result.dart';
import '../models/fee_model.dart';
import '../../domain/repositories/fees_repository.dart';

@Injectable(as: FeesRepository)
class FeesRepositoryImpl implements FeesRepository {
  @override
  Future<ApiResult<List<FeeModel>>> getFees() async {
    if (AppConstants.useDummyData) {
      return ApiResult.success([
        const FeeModel(id: 1, title: 'Tuition Fee', amount: 5000.0, dueDate: '2024-02-01', status: 'pending', description: 'Monthly tuition fee'),
        const FeeModel(id: 2, title: 'Transport Fee', amount: 1500.0, dueDate: '2024-02-01', status: 'paid', description: 'Monthly transport fee'),
        const FeeModel(id: 3, title: 'Lab Fee', amount: 500.0, dueDate: '2024-02-15', status: 'pending', description: 'Science lab fee'),
      ]);
    }
    // TODO: Implement API call
    return const ApiResult.success([]);
  }
}

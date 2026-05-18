import 'package:injectable/injectable.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/api_result.dart';
import '../models/dashboard_model.dart';
import '../../domain/repositories/dashboard_repository.dart';

@Injectable(as: DashboardRepository)
class DashboardRepositoryImpl implements DashboardRepository {
  @override
  Future<ApiResult<DashboardModel>> getDashboard() async {
    if (AppConstants.useDummyData) {
      return ApiResult.success(
        const DashboardModel(
          attendancePercentage: 85,
          homeworkList: [
            {'id': 1, 'title': 'Math Homework', 'subject': 'Mathematics', 'due_date': '2024-01-20'},
            {'id': 2, 'title': 'Science Project', 'subject': 'Science', 'due_date': '2024-01-22'},
          ],
          notificationList: [
            {'id': 1, 'title': 'School Holiday', 'message': 'School closed on Friday'},
            {'id': 2, 'title': 'Exam Schedule', 'message': 'Mid-term exams starting next week'},
          ],
          subjectsData: {'Math': 90, 'Science': 85, 'English': 78},
          timetable: {},
          visitorList: [],
          bookList: [],
          teacherList: [],
        ),
      );
    }
    // TODO: Implement API call
    return const ApiResult.success(DashboardModel());
  }
}

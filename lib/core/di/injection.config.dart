// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/admission/data/repositories/admission_repository_impl.dart'
    as _i108;
import '../../features/admission/domain/repositories/admission_repository.dart'
    as _i390;
import '../../features/admission/domain/usecases/get_application_status_usecase.dart'
    as _i837;
import '../../features/admission/presentation/bloc/admission_cubit.dart'
    as _i357;
import '../../features/attendance/data/repositories/attendance_repository_impl.dart'
    as _i719;
import '../../features/attendance/domain/repositories/attendance_repository.dart'
    as _i477;
import '../../features/attendance/domain/usecases/get_attendance_usecase.dart'
    as _i133;
import '../../features/attendance/presentation/bloc/attendance_cubit.dart'
    as _i1;
import '../../features/auth/data/datasources/auth_remote_datasource.dart'
    as _i161;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/usecases/login_usecase.dart' as _i188;
import '../../features/auth/domain/usecases/logout_usecase.dart' as _i48;
import '../../features/auth/presentation/bloc/auth_cubit.dart' as _i52;
import '../../features/calendar/data/repositories/calendar_repository_impl.dart'
    as _i712;
import '../../features/calendar/domain/repositories/calendar_repository.dart'
    as _i241;
import '../../features/calendar/domain/usecases/get_calendar_events_usecase.dart'
    as _i377;
import '../../features/calendar/presentation/bloc/calendar_cubit.dart' as _i648;
import '../../features/chat/data/repositories/chat_repository_impl.dart'
    as _i504;
import '../../features/chat/domain/repositories/chat_repository.dart' as _i420;
import '../../features/chat/domain/usecases/get_chat_users_usecase.dart'
    as _i297;
import '../../features/chat/presentation/bloc/chat_cubit.dart' as _i708;
import '../../features/dashboard/data/datasources/dashboard_remote_datasource.dart'
    as _i817;
import '../../features/dashboard/data/repositories/dashboard_repository_impl.dart'
    as _i509;
import '../../features/dashboard/domain/repositories/dashboard_repository.dart'
    as _i665;
import '../../features/dashboard/domain/usecases/get_dashboard_usecase.dart'
    as _i803;
import '../../features/dashboard/presentation/bloc/dashboard_cubit.dart'
    as _i58;
import '../../features/exams/data/repositories/exams_repository_impl.dart'
    as _i1002;
import '../../features/exams/domain/repositories/exams_repository.dart'
    as _i701;
import '../../features/exams/domain/usecases/get_exam_schedule_usecase.dart'
    as _i496;
import '../../features/exams/presentation/bloc/exams_cubit.dart' as _i637;
import '../../features/fees/data/repositories/fees_repository_impl.dart'
    as _i934;
import '../../features/fees/domain/repositories/fees_repository.dart' as _i291;
import '../../features/fees/domain/usecases/get_fees_usecase.dart' as _i586;
import '../../features/fees/presentation/bloc/fees_cubit.dart' as _i742;
import '../../features/homework/data/repositories/homework_repository_impl.dart'
    as _i616;
import '../../features/homework/domain/repositories/homework_repository.dart'
    as _i246;
import '../../features/homework/domain/usecases/get_homework_usecase.dart'
    as _i38;
import '../../features/homework/presentation/bloc/homework_cubit.dart' as _i148;
import '../../features/hostel/data/repositories/hostel_repository_impl.dart'
    as _i77;
import '../../features/hostel/domain/repositories/hostel_repository.dart'
    as _i249;
import '../../features/hostel/domain/usecases/get_hostel_info_usecase.dart'
    as _i485;
import '../../features/hostel/presentation/bloc/hostel_cubit.dart' as _i965;
import '../../features/leave/data/repositories/leave_repository_impl.dart'
    as _i624;
import '../../features/leave/domain/repositories/leave_repository.dart'
    as _i865;
import '../../features/leave/domain/usecases/get_leaves_usecase.dart' as _i580;
import '../../features/leave/presentation/bloc/leave_cubit.dart' as _i947;
import '../../features/library/data/repositories/library_repository_impl.dart'
    as _i912;
import '../../features/library/domain/repositories/library_repository.dart'
    as _i810;
import '../../features/library/domain/usecases/get_books_usecase.dart' as _i832;
import '../../features/library/presentation/bloc/library_cubit.dart' as _i1033;
import '../../features/online_exam/data/repositories/online_exam_repository_impl.dart'
    as _i264;
import '../../features/online_exam/domain/repositories/online_exam_repository.dart'
    as _i523;
import '../../features/online_exam/domain/usecases/get_online_exams_usecase.dart'
    as _i370;
import '../../features/online_exam/presentation/bloc/online_exam_cubit.dart'
    as _i728;
import '../../features/profile/data/repositories/profile_repository_impl.dart'
    as _i334;
import '../../features/profile/domain/repositories/profile_repository.dart'
    as _i894;
import '../../features/profile/domain/usecases/get_profile_usecase.dart'
    as _i965;
import '../../features/profile/presentation/bloc/profile_cubit.dart' as _i800;
import '../../features/settings/presentation/cubit/settings_cubit.dart'
    as _i792;
import '../../features/subjects/data/repositories/subjects_repository_impl.dart'
    as _i962;
import '../../features/subjects/domain/repositories/subjects_repository.dart'
    as _i640;
import '../../features/subjects/domain/usecases/get_subjects_usecase.dart'
    as _i464;
import '../../features/subjects/presentation/bloc/subjects_cubit.dart' as _i911;
import '../../features/syllabus/data/repositories/syllabus_repository_impl.dart'
    as _i678;
import '../../features/syllabus/domain/repositories/syllabus_repository.dart'
    as _i161;
import '../../features/syllabus/domain/usecases/get_syllabus_usecase.dart'
    as _i447;
import '../../features/syllabus/presentation/bloc/syllabus_cubit.dart' as _i391;
import '../../features/teachers/data/repositories/teachers_repository_impl.dart'
    as _i577;
import '../../features/teachers/domain/repositories/teachers_repository.dart'
    as _i398;
import '../../features/teachers/domain/usecases/get_teachers_usecase.dart'
    as _i389;
import '../../features/teachers/presentation/bloc/teachers_cubit.dart' as _i165;
import '../../features/timetable/data/repositories/timetable_repository_impl.dart'
    as _i1067;
import '../../features/timetable/domain/repositories/timetable_repository.dart'
    as _i239;
import '../../features/timetable/domain/usecases/get_timetable_usecase.dart'
    as _i911;
import '../../features/timetable/presentation/bloc/timetable_cubit.dart'
    as _i696;
import '../../features/transport/data/repositories/transport_repository_impl.dart'
    as _i608;
import '../../features/transport/domain/repositories/transport_repository.dart'
    as _i922;
import '../../features/transport/domain/usecases/get_transport_usecase.dart'
    as _i24;
import '../../features/transport/presentation/bloc/transport_cubit.dart'
    as _i549;
import '../../features/visitors/data/repositories/visitors_repository_impl.dart'
    as _i972;
import '../../features/visitors/domain/repositories/visitors_repository.dart'
    as _i235;
import '../../features/visitors/domain/usecases/get_visitors_usecase.dart'
    as _i111;
import '../../features/visitors/presentation/bloc/visitors_cubit.dart' as _i811;
import '../network/app_info_interceptor.dart' as _i953;
import '../network/auth_interceptor.dart' as _i908;
import '../storage/storage_service.dart' as _i865;
import 'register_module.dart' as _i291;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.factory<_i792.SettingsCubit>(() => _i792.SettingsCubit());
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => registerModule.secureStorage,
    );
    gh.factory<_i420.ChatRepository>(() => _i504.ChatRepositoryImpl());
    gh.factory<_i291.FeesRepository>(() => _i934.FeesRepositoryImpl());
    gh.factory<_i922.TransportRepository>(
      () => _i608.TransportRepositoryImpl(),
    );
    gh.lazySingleton<_i297.GetChatUsersUseCase>(
      () => _i297.GetChatUsersUseCase(gh<_i420.ChatRepository>()),
    );
    gh.factory<_i239.TimetableRepository>(
      () => _i1067.TimetableRepositoryImpl(),
    );
    gh.factory<_i241.CalendarRepository>(() => _i712.CalendarRepositoryImpl());
    gh.factory<_i398.TeachersRepository>(() => _i577.TeachersRepositoryImpl());
    gh.factory<_i246.HomeworkRepository>(() => _i616.HomeworkRepositoryImpl());
    gh.factory<_i390.AdmissionRepository>(
      () => _i108.AdmissionRepositoryImpl(),
    );
    gh.factory<_i665.DashboardRepository>(
      () => _i509.DashboardRepositoryImpl(),
    );
    gh.factory<_i161.SyllabusRepository>(() => _i678.SyllabusRepositoryImpl());
    gh.factory<_i894.ProfileRepository>(() => _i334.ProfileRepositoryImpl());
    gh.factory<_i640.SubjectsRepository>(() => _i962.SubjectsRepositoryImpl());
    gh.factory<_i235.VisitorsRepository>(() => _i972.VisitorsRepositoryImpl());
    gh.factory<_i865.LeaveRepository>(() => _i624.LeaveRepositoryImpl());
    gh.lazySingleton<_i965.GetProfileUseCase>(
      () => _i965.GetProfileUseCase(gh<_i894.ProfileRepository>()),
    );
    gh.factory<_i249.HostelRepository>(() => _i77.HostelRepositoryImpl());
    gh.factory<_i810.LibraryRepository>(() => _i912.LibraryRepositoryImpl());
    gh.lazySingleton<_i24.GetTransportUseCase>(
      () => _i24.GetTransportUseCase(gh<_i922.TransportRepository>()),
    );
    gh.lazySingleton<_i586.GetFeesUseCase>(
      () => _i586.GetFeesUseCase(gh<_i291.FeesRepository>()),
    );
    gh.lazySingleton<_i865.StorageService>(
      () => _i865.StorageService(
        gh<_i460.SharedPreferences>(),
        gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.factory<_i523.OnlineExamRepository>(
      () => _i264.OnlineExamRepositoryImpl(),
    );
    gh.factory<_i477.AttendanceRepository>(
      () => _i719.AttendanceRepositoryImpl(),
    );
    gh.factory<_i787.AuthRepository>(() => _i153.AuthRepositoryImpl());
    gh.factory<_i701.ExamsRepository>(() => _i1002.ExamsRepositoryImpl());
    gh.factory<_i800.ProfileCubit>(
      () => _i800.ProfileCubit(gh<_i965.GetProfileUseCase>()),
    );
    gh.lazySingleton<_i908.AuthInterceptor>(
      () => _i908.AuthInterceptor(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i188.LoginUseCase>(
      () => _i188.LoginUseCase(gh<_i787.AuthRepository>()),
    );
    gh.lazySingleton<_i48.LogoutUseCase>(
      () => _i48.LogoutUseCase(gh<_i787.AuthRepository>()),
    );
    gh.lazySingleton<_i464.GetSubjectsUseCase>(
      () => _i464.GetSubjectsUseCase(gh<_i640.SubjectsRepository>()),
    );
    gh.lazySingleton<_i389.GetTeachersUseCase>(
      () => _i389.GetTeachersUseCase(gh<_i398.TeachersRepository>()),
    );
    gh.factory<_i549.TransportCubit>(
      () => _i549.TransportCubit(gh<_i24.GetTransportUseCase>()),
    );
    gh.lazySingleton<_i803.GetDashboardUseCase>(
      () => _i803.GetDashboardUseCase(gh<_i665.DashboardRepository>()),
    );
    gh.lazySingleton<_i447.GetSyllabusUseCase>(
      () => _i447.GetSyllabusUseCase(gh<_i161.SyllabusRepository>()),
    );
    gh.lazySingleton<_i377.GetCalendarEventsUseCase>(
      () => _i377.GetCalendarEventsUseCase(gh<_i241.CalendarRepository>()),
    );
    gh.lazySingleton<_i485.GetHostelInfoUseCase>(
      () => _i485.GetHostelInfoUseCase(gh<_i249.HostelRepository>()),
    );
    gh.lazySingleton<_i832.GetBooksUseCase>(
      () => _i832.GetBooksUseCase(gh<_i810.LibraryRepository>()),
    );
    gh.lazySingleton<_i911.GetTimetableUseCase>(
      () => _i911.GetTimetableUseCase(gh<_i239.TimetableRepository>()),
    );
    gh.factory<_i52.AuthCubit>(
      () => _i52.AuthCubit(gh<_i188.LoginUseCase>(), gh<_i48.LogoutUseCase>()),
    );
    gh.lazySingleton<_i370.GetOnlineExamsUseCase>(
      () => _i370.GetOnlineExamsUseCase(gh<_i523.OnlineExamRepository>()),
    );
    gh.factory<_i708.ChatCubit>(
      () => _i708.ChatCubit(gh<_i297.GetChatUsersUseCase>()),
    );
    gh.factory<_i648.CalendarCubit>(
      () => _i648.CalendarCubit(gh<_i377.GetCalendarEventsUseCase>()),
    );
    gh.factory<_i965.HostelCubit>(
      () => _i965.HostelCubit(gh<_i485.GetHostelInfoUseCase>()),
    );
    gh.lazySingleton<_i953.AppInfoInterceptor>(
      () => _i953.AppInfoInterceptor(gh<_i865.StorageService>()),
    );
    gh.factory<_i728.OnlineExamCubit>(
      () => _i728.OnlineExamCubit(gh<_i370.GetOnlineExamsUseCase>()),
    );
    gh.lazySingleton<_i580.GetLeavesUseCase>(
      () => _i580.GetLeavesUseCase(gh<_i865.LeaveRepository>()),
    );
    gh.factory<_i742.FeesCubit>(
      () => _i742.FeesCubit(gh<_i586.GetFeesUseCase>()),
    );
    gh.lazySingleton<_i133.GetAttendanceUseCase>(
      () => _i133.GetAttendanceUseCase(gh<_i477.AttendanceRepository>()),
    );
    gh.factory<_i58.DashboardCubit>(
      () => _i58.DashboardCubit(gh<_i803.GetDashboardUseCase>()),
    );
    gh.lazySingleton<_i496.GetExamScheduleUseCase>(
      () => _i496.GetExamScheduleUseCase(gh<_i701.ExamsRepository>()),
    );
    gh.lazySingleton<_i111.GetVisitorsUseCase>(
      () => _i111.GetVisitorsUseCase(gh<_i235.VisitorsRepository>()),
    );
    gh.factory<_i1.AttendanceCubit>(
      () => _i1.AttendanceCubit(gh<_i133.GetAttendanceUseCase>()),
    );
    gh.factory<_i391.SyllabusCubit>(
      () => _i391.SyllabusCubit(gh<_i447.GetSyllabusUseCase>()),
    );
    gh.lazySingleton<_i38.GetHomeworkUseCase>(
      () => _i38.GetHomeworkUseCase(gh<_i246.HomeworkRepository>()),
    );
    gh.lazySingleton<_i837.GetApplicationStatusUseCase>(
      () => _i837.GetApplicationStatusUseCase(gh<_i390.AdmissionRepository>()),
    );
    gh.factory<_i148.HomeworkCubit>(
      () => _i148.HomeworkCubit(gh<_i38.GetHomeworkUseCase>()),
    );
    gh.factory<_i696.TimetableCubit>(
      () => _i696.TimetableCubit(gh<_i911.GetTimetableUseCase>()),
    );
    gh.factory<_i165.TeachersCubit>(
      () => _i165.TeachersCubit(gh<_i389.GetTeachersUseCase>()),
    );
    gh.factory<_i911.SubjectsCubit>(
      () => _i911.SubjectsCubit(gh<_i464.GetSubjectsUseCase>()),
    );
    gh.factory<_i947.LeaveCubit>(
      () => _i947.LeaveCubit(gh<_i580.GetLeavesUseCase>()),
    );
    gh.factory<_i1033.LibraryCubit>(
      () => _i1033.LibraryCubit(gh<_i832.GetBooksUseCase>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => registerModule.dio(
        gh<_i953.AppInfoInterceptor>(),
        gh<_i908.AuthInterceptor>(),
      ),
    );
    gh.factory<_i637.ExamsCubit>(
      () => _i637.ExamsCubit(gh<_i496.GetExamScheduleUseCase>()),
    );
    gh.factory<_i811.VisitorsCubit>(
      () => _i811.VisitorsCubit(gh<_i111.GetVisitorsUseCase>()),
    );
    gh.factory<_i357.AdmissionCubit>(
      () => _i357.AdmissionCubit(gh<_i837.GetApplicationStatusUseCase>()),
    );
    gh.factory<_i817.DashboardRemoteDataSource>(
      () => _i817.DashboardRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.factory<_i161.AuthRemoteDataSource>(
      () => _i161.AuthRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i291.RegisterModule {}

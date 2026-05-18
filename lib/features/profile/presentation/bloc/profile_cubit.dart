import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/usecases/get_profile_usecase.dart';
import 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase _getProfileUseCase;

  ProfileCubit(this._getProfileUseCase) : super(const ProfileState.initial());

  Future<void> loadProfile() async {
    emit(const ProfileState.loading());
    final result = await _getProfileUseCase.execute();
    result.when(
      success: (profile) => emit(ProfileState.loaded(profile)),
      failure: (failure) => emit(ProfileState.error(failure.message)),
    );
  }
}

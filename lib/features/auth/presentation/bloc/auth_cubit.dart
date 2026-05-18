import '../../../../core/network/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;

  AuthCubit(this._loginUseCase, this._logoutUseCase)
    : super(const AuthState.initial());

  Future<void> login({
    required String username,
    required String password,
  }) async {
    emit(const AuthState.loading());

    final result = await _loginUseCase.execute(
      username: username,
      password: password,
    );

    result.when(
      success: (response) {
        if (response.user != null) {
          emit(AuthState.authenticated(response.user!));
        } else {
          emit(AuthState.error(response.message ?? 'Invalid credentials'));
        }
      },
      failure: (failure) {
        emit(AuthState.error(failure.message));
      },
    );
  }

  Future<void> logout() async {
    emit(const AuthState.loading());

    final result = await _logoutUseCase.execute();

    result.when(
      success: (_) {
        emit(const AuthState.unauthenticated());
      },
      failure: (_) {
        emit(const AuthState.unauthenticated());
      },
    );
  }

  Future<void> checkAuth() async {
    emit(const AuthState.unauthenticated());
  }
}

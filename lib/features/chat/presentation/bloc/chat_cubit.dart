import '../../../../core/network/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/get_chat_users_usecase.dart';
import 'chat_state.dart';

@injectable
class ChatCubit extends Cubit<ChatState> {
  final GetChatUsersUseCase _getChatUsersUseCase;
  ChatCubit(this._getChatUsersUseCase) : super(const ChatState.initial());

  Future<void> loadChatUsers() async {
    emit(const ChatState.loading());
    final result = await _getChatUsersUseCase.execute();
    result.when(
      success: (users) => emit(ChatState.loaded(users)),
      failure: (failure) => emit(ChatState.error(failure.message)),
    );
  }
}

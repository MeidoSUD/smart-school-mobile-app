import 'package:injectable/injectable.dart';
import '../../../../core/network/api_result.dart';
import '../../data/models/chat_user_model.dart';
import '../repositories/chat_repository.dart';

@lazySingleton
class GetChatUsersUseCase {
  final ChatRepository _repository;
  GetChatUsersUseCase(this._repository);
  Future<ApiResult<List<ChatUserModel>>> execute() => _repository.getChatUsers();
}

import '../../../../core/network/api_result.dart';
import '../../data/models/chat_user_model.dart';
import '../../data/models/chat_message_model.dart';

abstract class ChatRepository {
  Future<ApiResult<List<ChatUserModel>>> getChatUsers();
  Future<ApiResult<List<ChatMessageModel>>> getChatRecord(int connectionId);
  Future<ApiResult<void>> sendMessage({required int connectionId, required int toUserId, required String message, required String time});
}

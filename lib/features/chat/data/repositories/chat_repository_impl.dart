import 'package:injectable/injectable.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/api_result.dart';
import '../models/chat_message_model.dart';
import '../models/chat_user_model.dart';
import '../../domain/repositories/chat_repository.dart';

@Injectable(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  @override
  Future<ApiResult<List<ChatUserModel>>> getChatUsers() async {
    if (AppConstants.useDummyData) {
      return ApiResult.success([
        const ChatUserModel(id: 1, name: 'Mr. Ahmed', lastMessage: 'Hello', time: '10:30 AM'),
        const ChatUserModel(id: 2, name: 'Ms. Fatima', lastMessage: 'See you tomorrow', time: '09:15 AM'),
        const ChatUserModel(id: 3, name: 'Admin', lastMessage: 'Notice: School holiday', time: 'Yesterday'),
      ]);
    }
    // TODO: Implement API call
    return const ApiResult.success([]);
  }

  @override
  Future<ApiResult<List<ChatMessageModel>>> getChatRecord(int connectionId) async {
    if (AppConstants.useDummyData) {
      return ApiResult.success([
        const ChatMessageModel(id: 1, message: 'Hello, how are you?', sender: 'user', time: '10:00 AM', isMe: true),
        const ChatMessageModel(id: 2, message: 'I am fine, thank you!', sender: 'other', time: '10:05 AM', isMe: false),
        const ChatMessageModel(id: 3, message: 'See you tomorrow', sender: 'user', time: '10:10 AM', isMe: true),
      ]);
    }
    // TODO: Implement API call
    return const ApiResult.success([]);
  }

  @override
  Future<ApiResult<void>> sendMessage({required int connectionId, required int toUserId, required String message, required String time}) async {
    if (AppConstants.useDummyData) {
      return const ApiResult.success(null);
    }
    // TODO: Implement API call
    return const ApiResult.success(null);
  }
}

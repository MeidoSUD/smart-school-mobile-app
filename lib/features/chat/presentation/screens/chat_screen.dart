import '../../../../core/localization/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../bloc/chat_cubit.dart';
import '../../../../core/di/injection.dart';
import '../bloc/chat_state.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (_) => getIt<ChatCubit>()..loadChatUsers(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: Colors.white,
          title: Text(context.tr(LocaleKeys.chat_title)),
        ),
        body: BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (users) {
                if (users.isEmpty) {
                  return Center(child: Text(context.tr(LocaleKeys.common_no_data)));
                }
                return ListView.builder(
                  padding: EdgeInsets.all(16.w),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return Card(
                      margin: EdgeInsets.only(bottom: 8.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                        leading: CircleAvatar(
                          radius: 24.r,
                          backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
                          child: Text(
                            user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                            style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.bold, fontSize: 18.sp),
                          ),
                        ),
                        title: Text(user.name, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp)),
                        subtitle: user.lastMessage != null
                            ? Text(user.lastMessage!, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]))
                            : null,
                        trailing: user.time != null
                            ? Text(user.time!, style: TextStyle(fontSize: 11.sp, color: Colors.grey[500]))
                            : null,
                      ),
                    );
                  },
                );
              },
              error: (message) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(message),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: () => context.read<ChatCubit>().loadChatUsers(),
                      child: Text(context.tr(LocaleKeys.common_retry)),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

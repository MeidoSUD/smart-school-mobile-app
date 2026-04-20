import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geniuses_school/core/constants/app_constants.dart';
import 'package:geniuses_school/presentation/state/lms_auth_provider.dart';

class LmsChatListScreen extends ConsumerWidget {
  const LmsChatListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatUsersAsync = ref.watch(lmsChatUsersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: chatUsersAsync.when(
        data: (users) {
          if (users.isEmpty) {
            return const Center(child: Text('No chats'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    child: user.photo != null
                        ? Image.network(user.photo!)
                        : const Icon(Icons.person),
                  ),
                  title: Text(user.name),
                  subtitle: Text(user.lastMessage ?? ''),
                  trailing: Text(user.time ?? ''),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
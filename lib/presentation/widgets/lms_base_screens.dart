import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geniuses_school/core/theme/app_theme.dart';
import 'package:geniuses_school/presentation/widgets/common_widgets.dart';

class LmsBaseScreen extends StatelessWidget {
  final String title;
  final Widget body;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final bool showBackButton;

  const LmsBaseScreen({
    super.key,
    required this.title,
    required this.body,
    this.actions,
    this.floatingActionButton,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(title),
        actions: actions,
        automaticallyImplyLeading: showBackButton && Navigator.canPop(context),
      ),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}

class LmsLoadingScreen extends StatelessWidget {
  final String? message;

  const LmsLoadingScreen({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return const LmsBaseScreen(
      title: 'Loading...',
      body: Center(child: AppLoading()),
    );
  }
}

class LmsAsyncScreen<T> extends ConsumerWidget {
  final String title;
  final FutureProvider<T> provider;
  final Widget Function(T data) builder;
  final Widget? emptyWidget;
  final List<Widget>? actions;

  const LmsAsyncScreen({
    super.key,
    required this.title,
    required this.provider,
    required this.builder,
    this.emptyWidget,
    this.actions,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(provider);

    return LmsBaseScreen(
      title: title,
      actions: actions,
      body: asyncValue.when(
        data: (data) {
          if (data is List && data.isEmpty && emptyWidget != null) {
            return emptyWidget!;
          }
          return builder(data);
        },
        loading: () => const Center(child: AppLoading()),
        error: (error, stack) => AppError(
          message: error.toString(),
          onRetry: () => ref.invalidate(provider),
        ),
      ),
    );
  }
}

class LmsListScreen<T> extends StatelessWidget {
  final String title;
  final List<T> items;
  final Widget Function(T item) itemBuilder;
  final String emptyMessage;
  final VoidCallback? onRetry;
  final List<Widget>? actions;

  const LmsListScreen({
    super.key,
    required this.title,
    required this.items,
    required this.itemBuilder,
    this.emptyMessage = 'No data found',
    this.onRetry,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return LmsBaseScreen(
        title: title,
        actions: actions,
        body: AppEmpty(
          message: emptyMessage,
          onRetry: onRetry,
        ),
      );
    }

    return LmsBaseScreen(
      title: title,
      actions: actions,
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) => itemBuilder(items[index]),
      ),
    );
  }
}

class LmsDetailScreen extends StatelessWidget {
  final String title;
  final List<_DetailItem> items;
  final List<Widget>? actions;

  const LmsDetailScreen({
    super.key,
    required this.title,
    required this.items,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return LmsBaseScreen(
      title: title,
      actions: actions,
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return AppCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.label,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  item.value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _DetailItem {
  final String label;
  final String value;

  const _DetailItem(this.label, this.value);
}
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/services/review_service.dart';
import 'auth_provider.dart';

final reviewServiceProvider = Provider<ReviewService>((ref) {
  final authState = ref.watch(authProvider);
  final token = authState.user?.token;
  return ReviewService(token: token);
});

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/ad_model.dart';
import '../../data/repositories/ads_repository.dart';

// ── State ────────────────────────────────────────────────────────────────────

class AdsState {
  final AsyncValue<List<AdModel>> ads;

  const AdsState({required this.ads});

  AdsState copyWith({AsyncValue<List<AdModel>>? ads}) =>
      AdsState(ads: ads ?? this.ads);
}

// ── Notifier ─────────────────────────────────────────────────────────────────

class AdsNotifier extends StateNotifier<AdsState> {
  final AdsRepository _repository;

  AdsNotifier(this._repository)
    : super(const AdsState(ads: AsyncValue.loading())) {
    loadAds();
  }

  Future<void> loadAds() async {
    state = state.copyWith(ads: const AsyncValue.loading());
    try {
      final ads = await _repository.getAds();
      state = state.copyWith(ads: AsyncValue.data(ads));
    } catch (error, stackTrace) {
      state = state.copyWith(ads: AsyncValue.error(error, stackTrace));
    }
  }
}

// ── Provider ─────────────────────────────────────────────────────────────────

final adsProvider = StateNotifierProvider<AdsNotifier, AdsState>((ref) {
  return AdsNotifier(AdsRepository());
});

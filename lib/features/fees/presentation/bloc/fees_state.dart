import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/fee_model.dart';

part 'fees_state.freezed.dart';

@freezed
class FeesState with _$FeesState {
  const factory FeesState.initial() = _Initial;
  const factory FeesState.loading() = _Loading;
  const factory FeesState.loaded(List<FeeModel> fees) = _Loaded;
  const factory FeesState.error(String message) = _Error;
}

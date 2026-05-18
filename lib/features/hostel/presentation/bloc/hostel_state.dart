import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/hostel_model.dart';

part 'hostel_state.freezed.dart';

@freezed
abstract class HostelState with _$HostelState {
  const factory HostelState.initial() = _Initial;
  const factory HostelState.loading() = _Loading;
  const factory HostelState.loaded(List<HostelModel> hostels) = _Loaded;
  const factory HostelState.error(String message) = _Error;
}

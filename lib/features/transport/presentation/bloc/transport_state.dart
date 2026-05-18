import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/transport_model.dart';
part 'transport_state.freezed.dart';

@freezed
class TransportState with _$TransportState {
  const factory TransportState.initial() = _Initial;
  const factory TransportState.loading() = _Loading;
  const factory TransportState.loaded(TransportModel transport) = _Loaded;
  const factory TransportState.error(String message) = _Error;
}

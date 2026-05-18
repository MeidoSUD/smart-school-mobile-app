import 'package:freezed_annotation/freezed_annotation.dart';

part 'admission_state.freezed.dart';

@freezed
abstract class AdmissionState with _$AdmissionState {
  const factory AdmissionState.initial() = _Initial;
  const factory AdmissionState.loading() = _Loading;
  const factory AdmissionState.loaded(Map<String, dynamic> status) = _Loaded;
  const factory AdmissionState.error(String message) = _Error;
}

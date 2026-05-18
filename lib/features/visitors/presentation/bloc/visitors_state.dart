import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/visitor_model.dart';

part 'visitors_state.freezed.dart';

@freezed
abstract class VisitorsState with _$VisitorsState {
  const factory VisitorsState.initial() = _Initial;
  const factory VisitorsState.loading() = _Loading;
  const factory VisitorsState.loaded(List<VisitorModel> visitors) = _Loaded;
  const factory VisitorsState.error(String message) = _Error;
}

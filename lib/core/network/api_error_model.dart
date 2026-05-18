import 'package:json_annotation/json_annotation.dart';
import '../errors/failures.dart';

part 'api_error_model.g.dart';

@JsonSerializable()
class ApiErrorModel extends Failure {
  final int code;
  
  const ApiErrorModel({
    required String message,
    required this.code,
  }) : super(message);
  
  factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorModelFromJson(json);
      
  Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);
  
  @override
  List<Object> get props => [message, code];
}

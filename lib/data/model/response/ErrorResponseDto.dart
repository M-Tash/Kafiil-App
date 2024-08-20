import 'package:kafiil_test/domain/entities/ErrorResponseEntity.dart';

class ErrorResponseDto extends ErrorResponseEntity {
  ErrorResponseDto({
    required super.message,
    required super.errors,
  });

  factory ErrorResponseDto.fromJson(Map<String, dynamic> json) {
    Map<String, List<String>> errorsMap = {};
    json['errors'].forEach((key, value) {
      errorsMap[key] = List<String>.from(value);
    });

    return ErrorResponseDto(
      message: json['message'],
      errors: errorsMap,
    );
  }
}

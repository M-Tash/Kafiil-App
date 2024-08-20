import 'package:kafiil_test/domain/entities/RegisterResponseEntity.dart';

class RegisterResponseDto extends RegisterResponseEntity {
  RegisterResponseDto({
    super.status,
    super.success,
    super.data,
  });

  RegisterResponseDto.fromJson(dynamic json) {
    status = json['status'];
    success = json['success'];
    data = json['data'];
  }
}

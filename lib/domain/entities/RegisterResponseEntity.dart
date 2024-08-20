class RegisterResponseEntity {
  RegisterResponseEntity({
    this.status,
    this.success,
    this.data,
  });

  int? status;
  bool? success;
  dynamic data;
}

class ErrorResponseEntity {
  final String message;
  final Map<String, List<String>> errors;

  ErrorResponseEntity({
    required this.message,
    required this.errors,
  });
}

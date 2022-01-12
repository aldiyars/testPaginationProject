class ApiException implements Exception {
  final ApiExceptionType type;

  ApiException(this.type);
}

enum ApiExceptionType {
  NETWORK,
  AUTH,
  OTHER,
  UNAUTHORIZED,
  BADREQUEST,
  INVALIDDATA,
}

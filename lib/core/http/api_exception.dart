class ApiException implements Exception {
  final ApiExceptionType type;

  ApiException(this.type);
}

///Базовый, самый простой тип эксепшны
enum ApiExceptionType {
  NETWORK,
  AUTH,
  OTHER,
  UNAUTHORIZED,
  BADREQUEST,
  INVALIDDATA,
}

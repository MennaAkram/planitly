import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../networking/failures.dart';

abstract class BaseRepository {
  final Dio dio;

  BaseRepository(this.dio);

  Future<Either<NetworkException, T>> tryToExecute<T>(
      Future<Response> Function() call, Function(dynamic) mapper) async {
    try {
      var response = await call();
      T mappedResponse = mapper(response.data);
      return right<NetworkException, T>(mappedResponse);
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        return left(BadRequest(e.response?.data['detail'] ?? 'BadRequest'));
      } else if (e.response?.statusCode == 401) {
        return left(UnAuthorizedFailure(
            e.response?.data['detail'] ?? "Internal Server Error"));
      } else if (e.response?.statusCode == 204) {
        return left(SuccessfulRequest('Successful Request'));
      } else if (e.response?.statusCode == 403) {
        return left(AccessDeniedException(
            e.response?.data['detail'] ?? "Access Denied"));
      } else if (e.response?.statusCode == 409) {
        return left(
            AlreadyExistException(e.response?.data['detail'] ?? 'Conflict'));
      } else if (e.response?.statusCode == 404) {
        return left(NotFoundException(e.response?.data['detail'] ?? 'Not Found'));
      } else if (e.response?.statusCode == 301) {
        return left(
            RedirectException(e.response?.data['detail'] ?? "Redirect"));
      } else if (e.response?.statusCode == 500) {
        return left(InternalServerError(
            e.response?.data['detail'] ?? "Internal Server Error"));
      } else if (e.type == DioExceptionType.connectionError) {
        return left(NoInternetError('No internet'));
      } else {
        return left(UnknownErrorException(e.response?.data['detail'] ?? 'Unknown Error'));
      }
    }
  }
}

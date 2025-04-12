import 'package:dio/dio.dart';
import 'package:planitly/shared/local_storage_manager.dart';

import '../../app/di.dart';
import '../../features/authentication/domain/repositories/authentication_repo.dart';
import '../../features/authentication/presentation/login/view/login_screen.dart';
import '../navigator_helper.dart';

class AppInterceptor extends Interceptor {
  final LocalStorageManager _storageManager;

  const AppInterceptor(this._storageManager);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _storageManager.getLoginToken();
    if (token != null) {
      options.headers["Authorization"] = "Bearer ${token.accessToken}";
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    try {
      if (err.response?.statusCode == 401 &&
          err.requestOptions.headers["Authorization"] != null) {
        final token = await _storageManager.getLoginToken();

        if (token != null) {
          final authRepo = getIt<AuthenticationRepository>();
          final newToken = await authRepo.refreshToken(
              token.accessToken, token.refreshToken);
          if (newToken.isRight()) {
            err.requestOptions.headers["Authorization"] =
                "Bearer ${newToken.getOrElse(() => throw Exception()).accessToken}";

            return handler.resolve(
              await getIt<Dio>().fetch(err.requestOptions),
            );
          }
          if (newToken.isLeft()) {
            _storageManager.clearLoginToken();
            NavigatorHelper.pushReplacement(const LoginScreen());
            return handler.reject(err);
          }
        }
      } else if (err.response?.statusCode == 404 &&
          err.response?.data['Message'] != null &&
          err.response?.data['Message'].contains("doesn't exist in the database")) {
        _storageManager.clearLoginToken();
        NavigatorHelper.pushReplacement(const LoginScreen());
        return handler.reject(err);
      }
    } catch (e) {
      _storageManager.clearLoginToken();
      NavigatorHelper.pushReplacement(const LoginScreen());
      return handler.reject(err);
    }
    handler.next(err);
  }
}

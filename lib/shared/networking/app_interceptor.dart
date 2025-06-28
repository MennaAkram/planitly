import 'package:dio/dio.dart';
import 'package:planitly/shared/local_storage_manager.dart';
import '../../app/di.dart';
import '../../features/authentication/domain/repositories/authentication_repo.dart';
import '../../features/authentication/presentation/login/presentation/view/login_screen.dart';
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
    final isRetry = err.requestOptions.extra['retry'] == true;

    if (err.response?.statusCode == 401 &&
        err.requestOptions.headers["Authorization"] != null &&
        !isRetry) {
      try {
        final token = await _storageManager.getLoginToken();

        if (token != null) {
          final authRepo = getIt<AuthenticationRepository>();
          final newToken = await authRepo.refreshToken(token.refreshToken);

          if (newToken.isRight()) {
            final accessToken =
                newToken.getOrElse(() => throw Exception()).accessToken;

            await _storageManager.saveLoginToken(
                newToken.getOrElse(() => throw Exception()));

            final opts = err.requestOptions;
            opts.headers["Authorization"] = "Bearer $accessToken";
            opts.extra["retry"] = true;

            final response = await getIt<Dio>(instanceName: 'planitlyService')
                .fetch(opts);

            return handler.resolve(response);
          }
        }

         _storageManager.clearLoginToken();
        NavigatorHelper.pushReplacement(const LoginScreen());
        return handler.reject(err);
      } catch (e) {
         _storageManager.clearLoginToken();
        NavigatorHelper.pushReplacement(const LoginScreen());
        return handler.reject(err);
      }
    }

    return handler.next(err);
  }
}

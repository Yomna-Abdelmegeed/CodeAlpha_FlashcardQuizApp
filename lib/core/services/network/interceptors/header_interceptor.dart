import 'package:flashcard_quiz_app/core/services/cache/secure_storage/secure_storage_service.dart';
import 'package:flashcard_quiz_app/core/constants/api_keys.dart';
import 'package:dio/dio.dart';

class HeaderInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final String? accessToken = await SecureStorageService.instance
        .getAccessToken();

    options.headers[ApiKeys.authorization] = accessToken != null
        ? '${ApiValues.bearer} $accessToken'
        : null;
    super.onRequest(options, handler);
  }
}

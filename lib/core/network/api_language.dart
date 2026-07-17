import 'package:dio/dio.dart';

const supportedApiLanguages = {'en', 'vi'};

String _apiLanguageCode = 'en';

String get apiLanguageCode => _apiLanguageCode;

void setApiLanguageCode(String? languageCode) {
  final normalized = languageCode?.toLowerCase();
  _apiLanguageCode = supportedApiLanguages.contains(normalized)
      ? normalized!
      : 'en';
}

class ApiLanguageInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Accept-Language'] = apiLanguageCode;
    handler.next(options);
  }
}

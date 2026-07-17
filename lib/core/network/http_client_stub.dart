import 'package:dio/dio.dart';

/// Web uses the browser networking stack, so there is no `dart:io` HTTP client
/// to configure.
void configureHttpClient(Dio dio, {required bool allowBadCertificate}) {}

/// No-op on web — the browser handles TLS and image loading.
void configureImageHttpOverrides({required bool allowBadCertificate}) {}

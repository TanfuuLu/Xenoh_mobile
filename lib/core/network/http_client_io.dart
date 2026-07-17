import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

/// Configures dio's underlying [HttpClient]. When [allowBadCertificate] is set
/// (dev only, e.g. the self-signed cert on https://localhost:7017), accept any
/// certificate. Never enable this against production.
void configureHttpClient(Dio dio, {required bool allowBadCertificate}) {
  if (!allowBadCertificate) return;
  dio.httpClientAdapter = IOHttpClientAdapter(
    createHttpClient: () =>
        HttpClient()..badCertificateCallback = (cert, host, port) => true,
  );
}

/// Installs a global [HttpOverrides] so Flutter's image loader (`Image.network`,
/// which does NOT go through dio) accepts the dev backend's self-signed cert.
/// Dev only — gated on [allowBadCertificate]; never enable against production.
void configureImageHttpOverrides({required bool allowBadCertificate}) {
  if (!allowBadCertificate) return;
  HttpOverrides.global = _DevHttpOverrides();
}

class _DevHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) =>
      super.createHttpClient(context)
        ..badCertificateCallback = (cert, host, port) => true;
}

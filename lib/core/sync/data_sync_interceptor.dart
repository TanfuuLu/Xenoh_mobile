import 'package:dio/dio.dart';

import 'data_sync_bus.dart';
import 'mutation_topics.dart';

/// Turns every successful write into a cross-screen refresh signal.
///
/// Sitting on the shared [Dio] instance means this catches *all* mutations —
/// repositories, `XenohApi` shortcuts, one-off calls inside screens — so no
/// call site has to remember to invalidate anything.
class DataSyncInterceptor extends Interceptor {
  DataSyncInterceptor(this._bus);

  final DataSyncBus _bus;

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final request = response.requestOptions;
    // `path` is usually the relative path passed to `dio.post(...)`, but a
    // call site may hand Dio an absolute URL — take the URL's path then.
    final path = request.path.startsWith('/')
        ? request.path
        : Uri.tryParse(request.path)?.path ?? '';
    _bus.notify(topicsForMutation(method: request.method, path: path));
    handler.next(response);
  }
}

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:signalr_netcore/signalr_client.dart';

import '../config/app_config.dart';
import '../storage/token_storage.dart';

final realtimeServiceProvider = Provider<RealtimeService>((ref) {
  final service = RealtimeService(ref.watch(tokenStorageProvider));
  ref.onDispose(() => unawaited(service.disconnect()));
  return service;
});

final realtimeEventsProvider = StreamProvider<RealtimeEvent>((ref) {
  return ref.watch(realtimeServiceProvider).events;
});

class RealtimeEvent {
  const RealtimeEvent({required this.name, required this.payload});

  final String name;
  final Object? payload;
}

class RealtimeService {
  RealtimeService(this._tokens);

  final TokenStorage _tokens;
  final _events = StreamController<RealtimeEvent>.broadcast();
  HubConnection? _connection;
  bool _connecting = false;

  Stream<RealtimeEvent> get events => _events.stream;

  bool get isConnected => _connection?.state == HubConnectionState.Connected;

  Future<void> connect() async {
    if (_connecting || isConnected) return;
    final token = _tokens.accessToken;
    if (token == null || token.isEmpty) return;

    _connecting = true;
    try {
      _connection ??= _buildConnection();
      if (_connection!.state != HubConnectionState.Connected) {
        await _connection!.start();
      }
    } finally {
      _connecting = false;
    }
  }

  Future<void> disconnect() async {
    final connection = _connection;
    _connection = null;
    if (connection != null) await connection.stop();
  }

  HubConnection _buildConnection() {
    final options = HttpConnectionOptions(
      accessTokenFactory: () async => _tokens.accessToken ?? '',
    );
    final hubUrl = AppConfig.apiBaseUrl.replaceFirst(
      RegExp(r'/api/?$'),
      '/hubs/notifications',
    );
    final connection = HubConnectionBuilder()
        .withUrl(hubUrl, options: options)
        .withAutomaticReconnect(retryDelays: [2000, 5000, 10000, 20000])
        .build();

    for (final eventName in _eventNames) {
      connection.on(eventName, (arguments) {
        _events.add(
          RealtimeEvent(
            name: eventName,
            payload: arguments == null || arguments.isEmpty
                ? null
                : arguments.length == 1
                ? arguments.first
                : arguments,
          ),
        );
      });
    }
    return connection;
  }
}

const _eventNames = [
  'ReceiveMessage',
  'ReceiveNotification',
  'ReceivePlanCommentAdded',
  'ReceivePlanCommentDeleted',
  'ReceiveWeekCommentAdded',
  'ReceiveWeekCommentDeleted',
];

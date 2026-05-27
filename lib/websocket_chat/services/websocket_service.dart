import 'dart:async';
import 'package:web_socket_channel/web_socket_channel.dart';

/// Enum representing the WebSocket connection state.
enum WsConnectionState { connecting, connected, disconnected, error }

/// Service that manages the WebSocket connection lifecycle.
class WebSocketService {
  WebSocketChannel? _channel;
  final StreamController<String> _messageController =
      StreamController<String>.broadcast();
  final StreamController<WsConnectionState> _connectionStateController =
      StreamController<WsConnectionState>.broadcast();

  WsConnectionState _connectionState = WsConnectionState.disconnected;
  String? _url;
  Timer? _reconnectTimer;
  int _reconnectAttempts = 0;
  static const int _maxReconnectAttempts = 5;
  bool _intentionalDisconnect = false;

  /// Stream of incoming text messages from the server.
  Stream<String> get messageStream => _messageController.stream;

  /// Stream of connection state changes.
  Stream<WsConnectionState> get connectionStateStream =>
      _connectionStateController.stream;

  /// Current connection state.
  WsConnectionState get connectionState => _connectionState;

  /// Whether the socket is currently connected.
  bool get isConnected => _connectionState == WsConnectionState.connected;

  /// Connects to the given WebSocket [url].
  Future<void> connect(String url) async {
    _url = url;
    _intentionalDisconnect = false;
    _updateConnectionState(WsConnectionState.connecting);

    try {
      _channel = WebSocketChannel.connect(Uri.parse(url));

      // Wait for the connection to be ready.
      await _channel!.ready;

      _reconnectAttempts = 0;
      _updateConnectionState(WsConnectionState.connected);

      // Listen for incoming messages.
      _channel!.stream.listen(
        (data) {
          if (data is String) {
            _messageController.add(data);
          }
        },
        onError: (error) {
          _updateConnectionState(WsConnectionState.error);
          _attemptReconnect();
        },
        onDone: () {
          _updateConnectionState(WsConnectionState.disconnected);
          if (!_intentionalDisconnect) {
            _attemptReconnect();
          }
        },
        cancelOnError: false,
      );
    } catch (e) {
      _updateConnectionState(WsConnectionState.error);
      _attemptReconnect();
    }
  }

  /// Sends a text [message] through the WebSocket.
  void sendMessage(String message) {
    if (_connectionState == WsConnectionState.connected && _channel != null) {
      _channel!.sink.add(message);
    }
  }

  /// Disconnects from the WebSocket server.
  Future<void> disconnect() async {
    _intentionalDisconnect = true;
    _reconnectTimer?.cancel();
    await _channel?.sink.close();
    _channel = null;
    _updateConnectionState(WsConnectionState.disconnected);
  }

  /// Attempts to reconnect with exponential backoff.
  void _attemptReconnect() {
    if (_intentionalDisconnect || _url == null) return;
    if (_reconnectAttempts >= _maxReconnectAttempts) return;

    _reconnectAttempts++;
    final delay = Duration(seconds: _reconnectAttempts * 2); // 2s, 4s, 6s, …

    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(delay, () {
      if (!_intentionalDisconnect && _url != null) {
        connect(_url!);
      }
    });
  }

  /// Manually trigger a reconnection (e.g. from a UI button).
  Future<void> reconnect() async {
    _reconnectAttempts = 0;
    if (_url != null) {
      await connect(_url!);
    }
  }

  void _updateConnectionState(WsConnectionState state) {
    _connectionState = state;
    _connectionStateController.add(state);
  }

  /// Cleans up all resources.
  void dispose() {
    _intentionalDisconnect = true;
    _reconnectTimer?.cancel();
    _channel?.sink.close();
    _messageController.close();
    _connectionStateController.close();
  }
}

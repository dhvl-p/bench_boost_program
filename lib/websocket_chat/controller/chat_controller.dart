import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bench_boost_program/websocket_chat/model/chat_message_model.dart';
import 'package:bench_boost_program/websocket_chat/services/websocket_service.dart';

/// GetX controller that orchestrates the chat UI state and WebSocket communication.
class ChatController extends GetxController {
  final WebSocketService _webSocketService = WebSocketService();

  /// The URL of the public echo WebSocket server.
  /// 'wss://echo.websocket.events' - give this url for get error
  static const String _serverUrl = 'wss://ws.postman-echo.com/raw';

  /// Observable list of chat messages.
  final RxList<ChatMessageModel> messages = <ChatMessageModel>[].obs;

  /// Current connection state.
  final Rx<WsConnectionState> connectionState =
      WsConnectionState.disconnected.obs;

  /// Whether the echo server is "typing" (simulated delay).
  final RxBool isTyping = false.obs;

  /// Text editing controller for the message input field.
  final TextEditingController textController = TextEditingController();

  /// Scroll controller for the message list.
  final ScrollController scrollController = ScrollController();

  StreamSubscription<String>? _messageSub;
  StreamSubscription<WsConnectionState>? _connectionSub;

  @override
  void onInit() {
    super.onInit();
    _listenToConnectionState();
    _listenToMessages();
    _connect();
  }

  /// Connects to the WebSocket echo server.
  Future<void> _connect() async {
    await _webSocketService.connect(_serverUrl);
  }

  /// Listens to connection state changes from the service.
  void _listenToConnectionState() {
    _connectionSub =
        _webSocketService.connectionStateStream.listen((state) {
      connectionState.value = state;
    });
  }

  /// Listens for incoming messages from the echo server.
  void _listenToMessages() {
    _messageSub = _webSocketService.messageStream.listen((data) {
      // The echo server sends back exactly what we sent.
      // Create an "echo" message.
      isTyping.value = false;

      final echoMessage = ChatMessageModel(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        text: data,
        sender: 'echo',
        timestamp: DateTime.now(),
        status: MessageStatus.delivered,
      );

      messages.add(echoMessage);
      _scrollToBottom();
    });
  }

  /// Sends a message through the WebSocket.
  void sendMessage() {
    final text = textController.text.trim();
    if (text.isEmpty) return;
    if (!_webSocketService.isConnected) return;

    // Add user message to the list.
    final userMessage = ChatMessageModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      text: text,
      sender: 'me',
      timestamp: DateTime.now(),
      status: MessageStatus.sending,
    );

    messages.add(userMessage);
    textController.clear();

    // Send via WebSocket.
    _webSocketService.sendMessage(text);

    // Mark as sent.
    userMessage.status = MessageStatus.sent;
    messages.refresh();

    // Show typing indicator for the echo response.
    isTyping.value = true;

    _scrollToBottom();
  }

  /// Scrolls the message list to the bottom.
  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent + 80,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
        );
      }
    });
  }

  /// Manually reconnect to the server.
  Future<void> reconnect() async {
    await _webSocketService.reconnect();
  }

  /// Clears the chat history.
  void clearChat() {
    messages.clear();
  }

  @override
  void onClose() {
    _messageSub?.cancel();
    _connectionSub?.cancel();
    _webSocketService.dispose();
    textController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bench_boost_program/websocket_chat/controller/chat_controller.dart';
import 'package:bench_boost_program/websocket_chat/model/chat_message_model.dart';
import 'package:bench_boost_program/websocket_chat/services/websocket_service.dart';

/// A polished real-time chat screen styled with a premium modern Light/White theme.
class WebSocketChatHome extends StatelessWidget {
  const WebSocketChatHome({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatController());

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [
            // ── Clean Light App Bar ──
            _buildAppBar(controller, context),

            const Divider(height: 1, color: Color(0xFFE5E7EB), thickness: 1),

            // ── Connection Banner ──
            _buildConnectionBanner(controller),

            // ── Messages List ──
            Expanded(child: _buildMessageList(controller)),

            // ── Typing Indicator ──
            _buildTypingIndicator(controller),

            // ── Input Bar ──
            _buildInputBar(controller),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // App Bar
  // ─────────────────────────────────────────────
  Widget _buildAppBar(ChatController controller, BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Color(0xFF374151), size: 20),
            onPressed: () => Navigator.of(context).pop(),
          ),
          const SizedBox(width: 4),

          // Avatar
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFF4F46E5), Color(0xFF6366F1)],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4F46E5).withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Center(
              child: Icon(Icons.bolt_rounded,
                  color: Colors.white, size: 22),
            ),
          ),

          const SizedBox(width: 12),

          // Title & status
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'WebSocket Echo',
                  style: TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.1,
                  ),
                ),
                const SizedBox(height: 2),
                Obx(() {
                  final state = controller.connectionState.value;
                  return Row(
                    children: [
                      _connectionDot(state),
                      const SizedBox(width: 6),
                      Text(
                        _connectionLabel(state),
                        style: const TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),

          // Clear chat button
          IconButton(
            icon: const Icon(Icons.delete_sweep_rounded,
                color: Color(0xFF9CA3AF), size: 22),
            tooltip: 'Clear chat',
            onPressed: controller.clearChat,
          ),
        ],
      ),
    );
  }

  Widget _connectionDot(WsConnectionState state) {
    Color color;
    switch (state) {
      case WsConnectionState.connected:
        color = const Color(0xFF10B981); // Emerald Green
        break;
      case WsConnectionState.connecting:
        color = const Color(0xFFF59E0B); // Amber
        break;
      case WsConnectionState.error:
      case WsConnectionState.disconnected:
        color = const Color(0xFFEF4444); // Red
        break;
    }
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: color.withValues(alpha: 0.4), blurRadius: 4),
        ],
      ),
    );
  }

  String _connectionLabel(WsConnectionState state) {
    switch (state) {
      case WsConnectionState.connected:
        return 'Connected';
      case WsConnectionState.connecting:
        return 'Connecting…';
      case WsConnectionState.disconnected:
        return 'Disconnected';
      case WsConnectionState.error:
        return 'Connection Error';
    }
  }

  // ─────────────────────────────────────────────
  // Connection Banner
  // ─────────────────────────────────────────────
  Widget _buildConnectionBanner(ChatController controller) {
    return Obx(() {
      final state = controller.connectionState.value;
      if (state == WsConnectionState.connected ||
          state == WsConnectionState.connecting) {
        return const SizedBox.shrink();
      }
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFFEF2F2), // Light Red/Pink
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFFEE2E2),
          ),
        ),
        child: Row(
          children: [
            const Icon(Icons.cloud_off_rounded,
                color: Color(0xFFDC2626), size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                state == WsConnectionState.error
                    ? 'Failed to connect. Please check connection.'
                    : 'Disconnected from echo server.',
                style: const TextStyle(
                  color: Color(0xFF991B1B),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            GestureDetector(
              onTap: controller.reconnect,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFDC2626),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Retry',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  // ─────────────────────────────────────────────
  // Message List
  // ─────────────────────────────────────────────
  Widget _buildMessageList(ChatController controller) {
    return Obx(() {
      if (controller.messages.isEmpty) {
        return _buildEmptyState();
      }

      return ListView.builder(
        controller: controller.scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: controller.messages.length,
        itemBuilder: (context, index) {
          final message = controller.messages[index];
          final showTimestamp = index == 0 ||
              message.timestamp
                      .difference(
                          controller.messages[index - 1].timestamp)
                      .inMinutes >
                  3;
          return _buildMessageBubble(message, showTimestamp);
        },
      );
    });
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFEEF2F6),
            ),
            child: const Icon(
              Icons.forum_outlined,
              size: 40,
              color: Color(0xFF9CA3AF),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Start a conversation',
            style: TextStyle(
              color: Color(0xFF1F2937),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Type a message below.\nThe WebSocket server will mirror it back.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // Message Bubble
  // ─────────────────────────────────────────────
  Widget _buildMessageBubble(ChatMessageModel message, bool showTimestamp) {
    final isMe = message.isMe;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          // Timestamp header
          if (showTimestamp)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5E7EB),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _formatTimestamp(message.timestamp),
                    style: const TextStyle(
                      color: Color(0xFF4B5563),
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),

          // Bubble row
          Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Flexible(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 280),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    gradient: isMe
                        ? const LinearGradient(
                            colors: [Color(0xFF4F46E5), Color(0xFF6366F1)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : null,
                    color: isMe ? null : Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20),
                      topRight: const Radius.circular(20),
                      bottomLeft:
                          isMe ? const Radius.circular(20) : const Radius.circular(4),
                      bottomRight:
                          isMe ? const Radius.circular(4) : const Radius.circular(20),
                    ),
                    border: isMe
                        ? null
                        : Border.all(color: const Color(0xFFE5E7EB)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isMe)
                        const Padding(
                          padding: EdgeInsets.only(bottom: 4),
                          child: Text(
                            'Server',
                            style: TextStyle(
                              color: Color(0xFF4F46E5),
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      Text(
                        message.text,
                        style: TextStyle(
                          color: isMe ? Colors.white : const Color(0xFF1F2937),
                          fontSize: 15,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _formatTime(message.timestamp),
                            style: TextStyle(
                              color: isMe
                                  ? Colors.white.withValues(alpha: 0.6)
                                  : const Color(0xFF9CA3AF),
                              fontSize: 10,
                            ),
                          ),
                          if (isMe) ...[
                            const SizedBox(width: 4),
                            _statusIcon(message.status),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statusIcon(MessageStatus status) {
    IconData icon;
    Color color;
    switch (status) {
      case MessageStatus.sending:
        icon = Icons.access_time_rounded;
        color = Colors.white.withValues(alpha: 0.5);
        break;
      case MessageStatus.sent:
        icon = Icons.check_rounded;
        color = Colors.white.withValues(alpha: 0.6);
        break;
      case MessageStatus.delivered:
        icon = Icons.done_all_rounded;
        color = const Color(0xFF34D399); // Light green
        break;
    }
    return Icon(icon, size: 13, color: color);
  }

  // ─────────────────────────────────────────────
  // Typing Indicator
  // ─────────────────────────────────────────────
  Widget _buildTypingIndicator(ChatController controller) {
    return Obx(() {
      if (!controller.isTyping.value) return const SizedBox.shrink();

      return Padding(
        padding: const EdgeInsets.only(left: 16, bottom: 8),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: const _TypingDots(),
          ),
        ),
      );
    });
  }

  // ─────────────────────────────────────────────
  // Input Bar
  // ─────────────────────────────────────────────
  Widget _buildInputBar(ChatController controller) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Row(
        children: [
          // Text Input Container
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(26),
              ),
              child: TextField(
                controller: controller.textController,
                style: const TextStyle(color: Color(0xFF1F2937), fontSize: 15),
                decoration: const InputDecoration(
                  hintText: 'Message…',
                  hintStyle: TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 15,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 20, vertical: 12),
                ),
                textCapitalization: TextCapitalization.sentences,
                onSubmitted: (_) => controller.sendMessage(),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Send Button
          Obx(() {
            final isConnected = controller.connectionState.value ==
                WsConnectionState.connected;
            return GestureDetector(
              onTap: isConnected ? controller.sendMessage : null,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: isConnected
                      ? const LinearGradient(
                          colors: [Color(0xFF4F46E5), Color(0xFF6366F1)],
                        )
                      : null,
                  color: isConnected ? null : const Color(0xFFE5E7EB),
                  boxShadow: isConnected
                      ? [
                          BoxShadow(
                            color: const Color(0xFF4F46E5)
                                .withValues(alpha: 0.3),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : null,
                ),
                child: Icon(
                  Icons.send_rounded,
                  color: isConnected ? Colors.white : const Color(0xFF9CA3AF),
                  size: 18,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // Helpers
  // ─────────────────────────────────────────────
  String _formatTimestamp(DateTime dt) {
    final now = DateTime.now();
    if (dt.year == now.year &&
        dt.month == now.month &&
        dt.day == now.day) {
      return 'Today';
    }
    final yesterday = now.subtract(const Duration(days: 1));
    if (dt.year == yesterday.year &&
        dt.month == yesterday.month &&
        dt.day == yesterday.day) {
      return 'Yesterday';
    }
    return '${dt.day}/${dt.month}/${dt.year}';
  }

  String _formatTime(DateTime dt) {
    final hour = dt.hour.toString().padLeft(2, '0');
    final minute = dt.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

// ─────────────────────────────────────────────────
// Animated Typing Dots Widget
// ─────────────────────────────────────────────────
class _TypingDots extends StatefulWidget {
  const _TypingDots();

  @override
  State<_TypingDots> createState() => _TypingDotsState();
}

class _TypingDotsState extends State<_TypingDots>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(3, (i) {
      return AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
      );
    });

    _animations = _controllers.map((c) {
      return Tween<double>(begin: 0, end: -5).animate(
        CurvedAnimation(parent: c, curve: Curves.easeInOut),
      );
    }).toList();

    // Stagger dots initiation
    for (int i = 0; i < 3; i++) {
      Future.delayed(Duration(milliseconds: i * 150), () {
        if (mounted) _controllers[i].repeat(reverse: true);
      });
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (i) {
        return AnimatedBuilder(
          animation: _animations[i],
          builder: (context, child) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              child: Transform.translate(
                offset: Offset(0, _animations[i].value),
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4F46E5),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

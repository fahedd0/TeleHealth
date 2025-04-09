// lib/screens/chat/chat_detail_screen.dart
import 'package:flutter/material.dart';
import '/constants/colors.dart';
import 'video_call_screen.dart';

class ChatDetailScreen extends StatefulWidget {
  final String name;
  final String imageUrl;
  final bool isOnline;

  const ChatDetailScreen({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.isOnline,
  });

  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {
      'text': 'Hello, how can I help you today?',
      'isMe': false,
      'time': '10:10 AM',
    },
    {
      'text': 'Hi Doctor. I\'ve been experiencing some chest pain lately.',
      'isMe': true,
      'time': '10:11 AM',
    },
    {
      'text':
          'I\'m sorry to hear that. When did the pain start and how would you describe it?',
      'isMe': false,
      'time': '10:12 AM',
    },
    {
      'text':
          'It started about 3 days ago. The pain is sharp and gets worse when I take deep breaths.',
      'isMe': true,
      'time': '10:14 AM',
    },
    {
      'text': 'Have you had any fever, cough, or shortness of breath?',
      'isMe': false,
      'time': '10:16 AM',
    },
    {
      'text':
          'No fever, but I have had a slight cough and feel a bit out of breath sometimes.',
      'isMe': true,
      'time': '10:18 AM',
    },
    {
      'text':
          'I see. Based on your symptoms, we should schedule a video consultation to assess this further. Are you available today at 2 PM?',
      'isMe': false,
      'time': '10:20 AM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage(widget.imageUrl),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.isOnline ? 'Online' : 'Offline',
                  style: TextStyle(
                    color: widget.isOnline ? Colors.green : Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam, color: AppColors.primary),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => const VideoCallScreen(
                        doctorName: 'Dr. Sarah Johnson',
                        doctorImage: 'assets/images/placeholder.jpg',
                      ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              reverse: false,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final bool isMe = message['isMe'];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    mainAxisAlignment:
                        isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isMe) ...[
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: AssetImage(widget.imageUrl),
                        ),
                        const SizedBox(width: 8),
                      ],
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isMe ? AppColors.primary : Colors.white,
                            borderRadius: BorderRadius.circular(16).copyWith(
                              bottomLeft:
                                  isMe
                                      ? const Radius.circular(16)
                                      : const Radius.circular(0),
                              bottomRight:
                                  isMe
                                      ? const Radius.circular(0)
                                      : const Radius.circular(16),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                message['text'],
                                style: TextStyle(
                                  color:
                                      isMe
                                          ? Colors.white
                                          : AppColors.textPrimary,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                message['time'],
                                style: TextStyle(
                                  color:
                                      isMe
                                          ? Colors.white70
                                          : AppColors.textSecondary,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (isMe) const SizedBox(width: 8),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.attach_file,
                    color: AppColors.textSecondary,
                  ),
                  onPressed: () {},
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        hintStyle: TextStyle(color: AppColors.textSecondary),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.mic, color: AppColors.textSecondary),
                  onPressed: () {},
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 20),
                    onPressed: () {
                      if (_messageController.text.trim().isNotEmpty) {
                        setState(() {
                          _messages.add({
                            'text': _messageController.text.trim(),
                            'isMe': true,
                            'time': '10:30 AM',
                          });
                          _messageController.clear();
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}

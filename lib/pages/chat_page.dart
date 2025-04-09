// lib/pages/chat_page.dart
import 'package:flutter/material.dart';
import '/constants/colors.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF), // Light background color
      body: Stack(
        children: [
          // Background gradient and shapes
          Positioned.fill(child: _buildBackground()),

          // Main content
          SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // App Bar with User Info
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                    child: _buildHeader(),
                  ),
                ),

                // Search Bar
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 28, 24, 0),
                    child: _buildSearchBar(),
                  ),
                ),

                // Messages Section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 28, 24, 0),
                    child: _buildMessagesSection(),
                  ),
                ),

                // Extra space for padding at the bottom
                SliverToBoxAdapter(child: SizedBox(height: 20)),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.chat),
      ),
    );
  }

  // Background decoration with gradient
  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFE6EEFE), Color(0xFFF8FAFF)],
          stops: [0.0, 0.5],
        ),
      ),
    );
  }

  // Header with user info and buttons
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Screen title and subtitle
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Messages',
              style: TextStyle(
                color: Color(0xFF1E293B),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Your healthcare conversations',
              style: TextStyle(
                color: Color(0xFF8C8FA3),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        // Action buttons
        Row(
          children: [
            // Filter Button
            _buildActionButton(
              onTap: () {
                // Filter conversations
              },
              icon: Icons.filter_list,
              notification: false,
              gradient: const [Color(0xFF64B6FF), Color(0xFF338BED)],
            ),
          ],
        ),
      ],
    );
  }

  // Action button with gradient background
  Widget _buildActionButton({
    required VoidCallback onTap,
    required IconData icon,
    required bool notification,
    required List<Color> gradient,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          // Button container
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          // Notification indicator
          if (notification)
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Modern search bar with voice input
  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Color(0xFF5E6272), size: 26),
          const SizedBox(width: 12),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search conversations...',
                hintStyle: TextStyle(
                  color: Color(0xFFA0A5BD),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          // Voice search button with animated ripple effect
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFE6EEFE), Color(0xFFDBE6FD)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.mic, color: AppColors.primary, size: 22),
          ),
        ],
      ),
    );
  }

  // Messages section with header and chat cards
  Widget _buildMessagesSection() {
    return Column(
      children: [
        // Section header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 6,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Recent Conversations',
                  style: TextStyle(
                    color: Color(0xFF1E293B),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            // See all appointments button
            GestureDetector(
              onTap: () {
                // View all messages
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Text(
                      'View All',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward,
                      color: AppColors.primary,
                      size: 14,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Chat cards
        _buildChatCard(
          name: 'Dr. Sarah Johnson',
          message:
              'Your last test results look good. How are you feeling today?',
          time: '10:30 AM',
          imageUrl: 'assets/images/placeholder.jpg',
          unreadCount: 2,
          isOnline: true,
        ),
        _buildChatCard(
          name: 'Dr. James Rodriguez',
          message: 'Remember to take your medications as prescribed.',
          time: 'Yesterday',
          imageUrl: 'assets/images/placeholder.jpg',
          unreadCount: 0,
          isOnline: false,
        ),
        _buildChatCard(
          name: 'Dr. Emma Wilson',
          message:
              'Please send me photos of the affected area before our next appointment.',
          time: 'Mar 22',
          imageUrl: 'assets/images/placeholder.jpg',
          unreadCount: 0,
          isOnline: true,
        ),
        _buildChatCard(
          name: 'Dr. Michael Brown',
          message:
              'I have reviewed your x-rays. We should schedule a follow-up.',
          time: 'Mar 20',
          imageUrl: 'assets/images/placeholder.jpg',
          unreadCount: 0,
          isOnline: false,
        ),
        _buildChatCard(
          name: 'Pharmacy Support',
          message: 'Your prescription is ready for pickup or delivery.',
          time: 'Mar 19',
          imageUrl: 'assets/images/placeholder.jpg',
          unreadCount: 0,
          isOnline: true,
        ),
      ],
    );
  }

  Widget _buildChatCard({
    required String name,
    required String message,
    required String time,
    required String imageUrl,
    required int unreadCount,
    required bool isOnline,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => ChatDetailScreen(
                  name: name,
                  imageUrl: imageUrl,
                  isOnline: isOnline,
                ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(imageUrl, fit: BoxFit.cover),
                  ),
                ),
                if (isOnline)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          color: Color(0xFF1E293B),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        time,
                        style: const TextStyle(
                          color: Color(0xFF64748B),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          message,
                          style: TextStyle(
                            color:
                                unreadCount > 0
                                    ? const Color(0xFF1E293B)
                                    : const Color(0xFF64748B),
                            fontSize: 14,
                            fontWeight:
                                unreadCount > 0
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (unreadCount > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            unreadCount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Chat Detail Screen
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
      backgroundColor: const Color(0xFFF8FAFF),
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
                      (context) => VideoCallScreen(
                        doctorName: widget.name,
                        doctorImage: widget.imageUrl,
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE6EEFE), Color(0xFFF8FAFF)],
            stops: [0.0, 0.5],
          ),
        ),
        child: Column(
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
                          isMe
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
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
                                  color: Colors.black.withOpacity(0.04),
                                  spreadRadius: 0,
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
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
                    color: Colors.black.withOpacity(0.04),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: const Offset(0, -4),
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
                        color: const Color(0xFFF8FAFF),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: const Color(0xFFE6EEFE),
                          width: 1,
                        ),
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
                  const SizedBox(width: 8),
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 20,
                      ),
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
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}

// Video Call Screen
class VideoCallScreen extends StatefulWidget {
  final String doctorName;
  final String doctorImage;

  const VideoCallScreen({
    super.key,
    required this.doctorName,
    required this.doctorImage,
  });

  @override
  _VideoCallScreenState createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  bool _isMuted = false;
  bool _isCameraOff = false;
  bool _isSpeakerOn = true;
  bool _isShowingControls = true;
  bool _isConnecting = true;

  @override
  void initState() {
    super.initState();
    // Simulate connection delay
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isConnecting = false;
        });
      }
    });

    // Auto-hide controls after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _isShowingControls = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: GestureDetector(
        onTap: () {
          setState(() {
            _isShowingControls = !_isShowingControls;
          });

          if (_isShowingControls) {
            Future.delayed(const Duration(seconds: 5), () {
              if (mounted) {
                setState(() {
                  _isShowingControls = false;
                });
              }
            });
          }
        },
        child: Stack(
          children: [
            // Main video (doctor)
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1A1A1A), Color(0xFF2E2E2E)],
                ),
              ),
              child:
                  _isConnecting
                      ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.primary,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Connecting...',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      )
                      : Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: const Color(0xFF1A1A1A),
                            child: Image.asset(
                              widget.doctorImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
            ),

            // Small video (patient)
            if (!_isConnecting)
              Positioned(
                top: 40,
                right: 20,
                child: GestureDetector(
                  onTap: () {
                    // Toggle self view size
                  },
                  child: Container(
                    width: 120,
                    height: 160,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child:
                          _isCameraOff
                              ? Container(
                                color: Colors.grey[900],
                                child: const Center(
                                  child: Icon(
                                    Icons.videocam_off,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              )
                              : Image.asset(
                                'assets/images/placeholder.jpg',
                                fit: BoxFit.cover,
                              ),
                    ),
                  ),
                ),
              ),

            // Call duration and doctor name
            if (_isShowingControls)
              Positioned(
                top: 40,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        '05:32',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundImage: AssetImage(widget.doctorImage),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            widget.doctorName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            // Bottom controls
            if (_isShowingControls)
              Positioned(
                bottom: 40,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildControlButton(
                          icon: _isMuted ? Icons.mic_off : Icons.mic,
                          label: _isMuted ? 'Unmute' : 'Mute',
                          color: _isMuted ? Colors.red : Colors.white,
                          onTap: () {
                            setState(() {
                              _isMuted = !_isMuted;
                            });
                          },
                        ),
                        const SizedBox(width: 16),
                        _buildControlButton(
                          icon:
                              _isCameraOff
                                  ? Icons.videocam_off
                                  : Icons.videocam,
                          label: _isCameraOff ? 'Camera On' : 'Camera Off',
                          color: _isCameraOff ? Colors.red : Colors.white,
                          onTap: () {
                            setState(() {
                              _isCameraOff = !_isCameraOff;
                            });
                          },
                        ),
                        const SizedBox(width: 16),
                        _buildControlButton(
                          icon:
                              _isSpeakerOn ? Icons.volume_up : Icons.volume_off,
                          label: _isSpeakerOn ? 'Speaker' : 'Speaker Off',
                          color: Colors.white,
                          onTap: () {
                            setState(() {
                              _isSpeakerOn = !_isSpeakerOn;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildActionButton(
                          color: Colors.red,
                          icon: Icons.call_end,
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(width: 20),
                        _buildActionButton(
                          color: AppColors.primary,
                          icon: Icons.chat,
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            // Back button
            if (_isShowingControls)
              Positioned(
                top: 40,
                left: 20,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 28),
      ),
    );
  }
}

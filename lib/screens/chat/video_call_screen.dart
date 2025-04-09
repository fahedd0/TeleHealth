// lib/screens/chat/video_call_screen.dart
import 'package:flutter/material.dart';
import '/constants/colors.dart';

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
      backgroundColor: const Color(0xFF121212),
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
              color: const Color(0xFF1A1A1A),
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
                        child: Image.asset(
                          widget.doctorImage,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
            ),

            // Small video (patient)
            if (!_isConnecting)
              Positioned(
                top: 40,
                right: 20,
                child: Container(
                  width: 120,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
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
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white, size: 30),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/widgets/doctor_card.dart';
import '../navigation/navigation_controller.dart';
import 'dart:math' as math;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _expandedServices = false;

  // List of services that can be dynamically expanded
  final List<Map<String, dynamic>> _services = const [
    {
      'icon': Icons.video_call,
      'label': 'Consultation',
      'gradient': [Color(0xFF6E8EF7), Color(0xFF4458DB)],
    },
    {
      'icon': Icons.medical_services_outlined,
      'label': 'Pharmacy',
      'gradient': [Color(0xFF65D6E4), Color(0xFF0F94A3)],
    },
    {
      'icon': Icons.science_outlined,
      'label': 'Lab Tests',
      'gradient': [Color(0xFFF78CAA), Color(0xFFE23A66)],
    },
    {
      'icon': Icons.history,
      'label': 'Records',
      'gradient': [Color(0xFFFAC98E), Color(0xFFF9A949)],
    },
    {
      'icon': Icons.health_and_safety_outlined,
      'label': 'Insurance',
      'gradient': [Color(0xFF8CD2AA), Color(0xFF37A264)],
    },
    {
      'icon': Icons.payment_outlined,
      'label': 'Payments',
      'gradient': [Color(0xFFB095E6), Color(0xFF8E67D0)],
    },
    {
      'icon': Icons.timeline,
      'label': 'Health Timeline',
      'gradient': [Color(0xFFFF9F7A), Color(0xFFFF6D3F)],
    },
    {
      'icon': Icons.event_note_outlined,
      'label': 'Prescriptions',
      'gradient': [Color(0xFF79C8F9), Color(0xFF4B9FDC)],
    },
    // Add more services as needed
  ];

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

                // Quick Access Services
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 28, 24, 0),
                    child: _buildServicesSection(),
                  ),
                ),

                // Upcoming Appointment
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 28, 24, 0),
                    child: _buildAppointmentSection(),
                  ),
                ),

                // Top Doctors Section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 28, 24, 0),
                    child: _buildDoctorsSection(),
                  ),
                ),

                // Health Articles Section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
                    child: _buildArticlesSection(),
                  ),
                ),

                // Extra space for padding at the bottom
                SliverToBoxAdapter(child: SizedBox(height: 20)),
              ],
            ),
          ),
        ],
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
        // User greeting and name
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Good Morning,',
              style: TextStyle(
                color: Color(0xFF8C8FA3),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Test User',
              style: TextStyle(
                color: Color(0xFF1E293B),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        // Action buttons
        Row(
          children: [
            // AI Assistant Button
            _buildActionButton(
              onTap: () {
                // Navigate to AI Assistant
              },
              icon: Icons.smart_toy_outlined,
              notification: false,
              gradient: const [Color(0xFF9E8CFF), Color(0xFF7B68EE)],
            ),
            const SizedBox(width: 12),
            // Notification Button
            _buildActionButton(
              onTap: () {
                // Navigate to notifications
              },
              icon: Icons.notifications_none_rounded,
              notification: true,
              gradient: const [Color(0xFF64B6FF), Color(0xFF338BED)],
            ),
            const SizedBox(width: 12),
            // Profile Picture
            _buildProfileAvatar(),
          ],
        ),
      ],
    );
  }

  // Modern profile avatar
  Widget _buildProfileAvatar() {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        image: const DecorationImage(
          image: AssetImage('assets/images/placeholder.jpg'),
          fit: BoxFit.cover,
        ),
      ),
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
                hintText: 'Search doctors, medicines, etc.',
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

  // Services section with expandable grid
  Widget _buildServicesSection() {
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
                  'Our Services',
                  style: TextStyle(
                    color: Color(0xFF1E293B),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            // Services toggle button
            if (_services.length > 4)
              GestureDetector(
                onTap: () {
                  setState(() {
                    _expandedServices = !_expandedServices;
                  });
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
                        _expandedServices ? 'Show Less' : 'Show More',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        _expandedServices
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: AppColors.primary,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 20),

        // First row - always visible
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(4, (index) {
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: index < 3 ? 12.0 : 0.0),
                child: _buildServiceItem(
                  icon: _services[index]['icon'],
                  label: _services[index]['label'],
                  gradient: _services[index]['gradient'],
                  onTap: () {
                    // Navigate based on service
                  },
                ),
              ),
            );
          }),
        ),

        // Second row - only visible when expanded
        if (_expandedServices && _services.length > 4)
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(math.min(4, _services.length - 4), (
                index,
              ) {
                final serviceIndex = index + 4;
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: index < 3 ? 12.0 : 0.0),
                    child: _buildServiceItem(
                      icon: _services[serviceIndex]['icon'],
                      label: _services[serviceIndex]['label'],
                      gradient: _services[serviceIndex]['gradient'],
                      onTap: () {
                        // Navigate based on service
                      },
                    ),
                  ),
                );
              }),
            ),
          ),
      ],
    );
  }

  // Individual service item with icon and label
  Widget _buildServiceItem({
    required IconData icon,
    required String label,
    required List<Color> gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          // Icon with color background
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.2),
                  spreadRadius: 0,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: AppColors.primary, size: 26),
          ),
          const SizedBox(height: 10),
          // Service label
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF1E293B),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // Appointment section with upcoming appointment
  Widget _buildAppointmentSection() {
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
                  'Your Next Appointment',
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
                // Use the static navigateTo method
                NavigationController.navigateTo(
                  1,
                ); // Navigate to appointments tab
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

        // Premium appointment card design
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                spreadRadius: 0,
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              // Doctor info section
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    // Doctor image
                    Hero(
                      tag: 'doctor-sarah',
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                          image: const DecorationImage(
                            image: AssetImage('assets/images/placeholder.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Doctor details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Dr. Sarah Johnson',
                                style: TextStyle(
                                  color: Color(0xFF1E293B),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              // Verified badge
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Color(0xFF1D70F1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 10,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          // Specialty with icon
                          Row(
                            children: const [
                              Icon(
                                Icons.medical_services,
                                color: Color(0xFF64748B),
                                size: 14,
                              ),
                              SizedBox(width: 6),
                              Text(
                                'Cardiologist',
                                style: TextStyle(
                                  color: Color(0xFF64748B),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 12),
                              // Experience
                              Icon(
                                Icons.workspace_premium,
                                color: Color(0xFF64748B),
                                size: 14,
                              ),
                              SizedBox(width: 6),
                              Text(
                                '12 years',
                                style: TextStyle(
                                  color: Color(0xFF64748B),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          // Rating
                          Row(
                            children: [
                              ...List.generate(
                                5,
                                (index) => Padding(
                                  padding: const EdgeInsets.only(right: 2),
                                  child: Icon(
                                    Icons.star,
                                    color:
                                        index < 4
                                            ? const Color(0xFFFFC107)
                                            : const Color(0xFFE0E0E0),
                                    size: 14,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                '4.9',
                                style: TextStyle(
                                  color: Color(0xFF1E293B),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                '(458)',
                                style: TextStyle(
                                  color: Color(0xFF64748B),
                                  fontSize: 12,
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

              // Divider
              const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),

              // Appointment details
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Date column
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Date',
                          style: TextStyle(
                            color: Color(0xFF64748B),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1D70F1).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.calendar_today,
                                color: Color(0xFF1D70F1),
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Today, Apr 9',
                              style: TextStyle(
                                color: Color(0xFF1E293B),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Vertical divider
                    Container(
                      height: 40,
                      width: 1,
                      color: const Color(0xFFF1F5F9),
                    ),

                    // Time column
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Time',
                          style: TextStyle(
                            color: Color(0xFF64748B),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1D70F1).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.access_time,
                                color: Color(0xFF1D70F1),
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              '10:00 AM',
                              style: TextStyle(
                                color: Color(0xFF1E293B),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Buttons
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Row(
                  children: [
                    // Reschedule button
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // Navigate to the appointments tab
                          NavigationController.navigateTo(1);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                Icons.event_busy,
                                color: Color(0xFF1E293B),
                                size: 18,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Reschedule',
                                style: TextStyle(
                                  color: Color(0xFF1E293B),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Join call button
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // Join call logic
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFF1D70F1), Color(0xFF0B59CC)],
                            ),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF1D70F1).withOpacity(0.3),
                                spreadRadius: 0,
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                Icons.video_call,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Join Call',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Top doctors section
  Widget _buildDoctorsSection() {
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
                  'Top Doctors',
                  style: TextStyle(
                    color: Color(0xFF1E293B),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            // See all button
            GestureDetector(
              onTap: () {
                // Navigate to all doctors
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

        // Doctors list
        SizedBox(
          height: 240,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            children: const [
              DoctorCard(
                name: 'Dr. Emma Wilson',
                specialty: 'Neurologist',
                rating: 4.9,
                imageUrl: 'assets/images/placeholder.jpg',
              ),
              SizedBox(width: 16),
              DoctorCard(
                name: 'Dr. James Rodriguez',
                specialty: 'Cardiologist',
                rating: 4.8,
                imageUrl: 'assets/images/placeholder.jpg',
              ),
              SizedBox(width: 16),
              DoctorCard(
                name: 'Dr. Amelia Thompson',
                specialty: 'Dermatologist',
                rating: 4.7,
                imageUrl: 'assets/images/placeholder.jpg',
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Health articles section
  Widget _buildArticlesSection() {
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
                  'Health Articles',
                  style: TextStyle(
                    color: Color(0xFF1E293B),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            // See all button
            GestureDetector(
              onTap: () {
                // Navigate to all articles
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

        // Featured article card
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                spreadRadius: 0,
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              // Article image area with blue background
              Stack(
                children: [
                  // Blue background instead of image
                  Container(
                    height: 180,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE6F4FF),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                  ),
                  // Category tag
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.local_hospital,
                            color: Color(0xFF1D70F1),
                            size: 14,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Telemedicine',
                            style: TextStyle(
                              color: Color(0xFF1D70F1),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Article title overlay
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'The Benefits of Telemedicine',
                          style: TextStyle(
                            color: Color(0xFF1E293B),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: const [
                            Icon(
                              Icons.calendar_today,
                              color: Color(0xFF64748B),
                              size: 14,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Apr 9, 2025',
                              style: TextStyle(
                                color: Color(0xFF64748B),
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(width: 16),
                            Icon(
                              Icons.access_time,
                              color: Color(0xFF64748B),
                              size: 14,
                            ),
                            SizedBox(width: 6),
                            Text(
                              '5 min read',
                              style: TextStyle(
                                color: Color(0xFF64748B),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Article preview text
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Telemedicine has revolutionized healthcare delivery, providing convenient access to medical professionals from the comfort of your home...',
                  style: TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ),

              // Action buttons
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Row(
                  children: [
                    // Save button
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.bookmark_border,
                        color: Color(0xFF64748B),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Share button
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.share,
                        color: Color(0xFF64748B),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Read more button
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // Navigate to article
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.3),
                                spreadRadius: 0,
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Read Full Article',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

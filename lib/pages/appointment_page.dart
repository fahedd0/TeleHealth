import 'package:flutter/material.dart';
import '/constants/colors.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _showScheduleForm = false;
  String _selectedType = 'Video Consultation';
  int _selectedDateIndex = 2; // Default to today
  int _selectedTimeSlot = -1;

  // List of available time slots
  final List<String> _timeSlots = [
    '09:00 AM',
    '09:30 AM',
    '10:00 AM',
    '10:30 AM',
    '11:00 AM',
    '11:30 AM',
    '01:00 PM',
    '01:30 PM',
    '02:00 PM',
    '02:30 PM',
    '03:00 PM',
    '03:30 PM',
  ];

  // Get next 7 days for date selection
  List<Map<String, dynamic>> _getNext7Days() {
    final List<Map<String, dynamic>> dates = [];
    final DateTime now = DateTime.now();

    for (int i = 0; i < 7; i++) {
      final DateTime date = now.add(Duration(days: i));
      dates.add({
        'dayName': _getDayName(date.weekday),
        'dayNumber': date.day,
        'date': date,
      });
    }

    return dates;
  }

  // Get day name from weekday
  String _getDayName(int weekday) {
    switch (weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
            child:
                _showScheduleForm
                    ? _buildScheduleForm()
                    : _buildAppointmentsList(),
          ),
        ],
      ),
      floatingActionButton:
          _showScheduleForm
              ? null
              : FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _showScheduleForm = true;
                  });
                },
                backgroundColor: AppColors.primary,
                child: const Icon(Icons.add),
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

  // Appointments list view
  Widget _buildAppointmentsList() {
    return Column(
      children: [
        // App Bar with User Info
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
          child: _buildHeader(),
        ),

        // Tab bar
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: AppColors.primary,
              ),
              labelColor: Colors.white,
              unselectedLabelColor: AppColors.textSecondary,
              tabs: const [
                Tab(text: 'Upcoming'),
                Tab(text: 'Completed'),
                Tab(text: 'Cancelled'),
              ],
            ),
          ),
        ),

        // Tab views
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // Upcoming Appointments
              _buildAppointmentsTab('upcoming'),

              // Completed Appointments
              _buildAppointmentsTab('completed'),

              // Cancelled Appointments
              _buildAppointmentsTab('cancelled'),
            ],
          ),
        ),
      ],
    );
  }

  // Tab content builder
  Widget _buildAppointmentsTab(String type) {
    List<Map<String, dynamic>> appointments = [];

    if (type == 'upcoming') {
      appointments = [
        {
          'doctorName': 'Dr. Sarah Johnson',
          'specialty': 'Cardiologist',
          'date': 'Today',
          'time': '10:00 AM',
          'appointmentType': 'video',
          'imageUrl': 'assets/images/placeholder.jpg',
          'section': 'Today, Apr 9, 2025',
        },
        {
          'doctorName': 'Dr. James Rodriguez',
          'specialty': 'Neurologist',
          'date': 'Tomorrow',
          'time': '11:30 AM',
          'appointmentType': 'clinic',
          'imageUrl': 'assets/images/placeholder.jpg',
          'section': 'Tomorrow, Apr 10, 2025',
        },
        {
          'doctorName': 'Dr. Emma Wilson',
          'specialty': 'Dermatologist',
          'date': 'Apr 14, 2025',
          'time': '09:00 AM',
          'appointmentType': 'video',
          'imageUrl': 'assets/images/placeholder.jpg',
          'section': 'Next Week',
        },
      ];
    } else if (type == 'completed') {
      appointments = [
        {
          'doctorName': 'Dr. Michael Brown',
          'specialty': 'Orthopedic',
          'date': 'Apr 3, 2025',
          'time': '02:30 PM',
          'appointmentType': 'clinic',
          'imageUrl': 'assets/images/placeholder.jpg',
          'section': 'Last Week',
        },
        {
          'doctorName': 'Dr. Lisa Chen',
          'specialty': 'Pediatrician',
          'date': 'Mar 28, 2025',
          'time': '10:00 AM',
          'appointmentType': 'video',
          'imageUrl': 'assets/images/placeholder.jpg',
          'section': 'Last Month',
        },
      ];
    } else if (type == 'cancelled') {
      appointments = [
        {
          'doctorName': 'Dr. Emily Davis',
          'specialty': 'Ophthalmologist',
          'date': 'Apr 5, 2025',
          'time': '01:00 PM',
          'appointmentType': 'video',
          'imageUrl': 'assets/images/placeholder.jpg',
          'section': 'Recent Cancellations',
        },
      ];
    }

    // Group appointments by section
    Map<String, List<Map<String, dynamic>>> groupedAppointments = {};
    for (var appointment in appointments) {
      String section = appointment['section'] as String;
      if (!groupedAppointments.containsKey(section)) {
        groupedAppointments[section] = [];
      }
      groupedAppointments[section]!.add(appointment);
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...groupedAppointments.entries.map((entry) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  child: Row(
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
                      Text(
                        entry.key,
                        style: const TextStyle(
                          color: Color(0xFF1E293B),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                ...entry.value.map(
                  (appointment) => _buildAppointmentCard(appointment),
                ),
                const SizedBox(height: 16),
              ],
            );
          }),

          // Empty state message if no appointments
          if (appointments.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Column(
                  children: [
                    Icon(
                      Icons.event_busy,
                      size: 80,
                      color: AppColors.primary.withOpacity(0.5),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No $type appointments',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (type == 'upcoming')
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _showScheduleForm = true;
                          });
                        },
                        child: Text(
                          'Schedule a new appointment',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Appointment card widget
  Widget _buildAppointmentCard(Map<String, dynamic> appointment) {
    bool isVideo = appointment['appointmentType'] == 'video';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    image: DecorationImage(
                      image: AssetImage(appointment['imageUrl']),
                      fit: BoxFit.cover,
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
                          Text(
                            appointment['doctorName'],
                            style: const TextStyle(
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
                        children: [
                          const Icon(
                            Icons.medical_services,
                            color: Color(0xFF64748B),
                            size: 14,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            appointment['specialty'],
                            style: const TextStyle(
                              color: Color(0xFF64748B),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Appointment type
                          Icon(
                            isVideo ? Icons.videocam : Icons.location_on,
                            color: Color(isVideo ? 0xFF1D70F1 : 0xFF64748B),
                            size: 14,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            isVideo ? 'Video Call' : 'Clinic Visit',
                            style: TextStyle(
                              color: Color(isVideo ? 0xFF1D70F1 : 0xFF64748B),
                              fontSize: 14,
                              fontWeight:
                                  isVideo ? FontWeight.w600 : FontWeight.w500,
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
                        Text(
                          appointment['date'],
                          style: const TextStyle(
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
                Container(height: 40, width: 1, color: const Color(0xFFF1F5F9)),

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
                        Text(
                          appointment['time'],
                          style: const TextStyle(
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
                // Cancel/Reschedule button
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Reschedule or cancel logic
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

                // Join call/Details button
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Join call or view details logic
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
                        children: [
                          Icon(
                            isVideo ? Icons.video_call : Icons.info_outline,
                            color: Colors.white,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            isVideo ? 'Join Call' : 'Details',
                            style: const TextStyle(
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
    );
  }

  // Schedule form view
  Widget _buildScheduleForm() {
    final List<Map<String, dynamic>> next7Days = _getNext7Days();

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with back button
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _showScheduleForm = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                const Text(
                  'Book Appointment',
                  style: TextStyle(
                    color: Color(0xFF1E293B),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Doctor Info Card
            Container(
              padding: const EdgeInsets.all(20),
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
              child: Row(
                children: [
                  // Doctor image
                  Container(
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
                        // Specialty and experience
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

            const SizedBox(height: 30),

            // Appointment Type Section
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
                  'Appointment Type',
                  style: TextStyle(
                    color: Color(0xFF1E293B),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                _appointmentTypeButton(
                  title: 'Video Consultation',
                  icon: Icons.videocam,
                  isSelected: _selectedType == 'Video Consultation',
                  onTap: () {
                    setState(() {
                      _selectedType = 'Video Consultation';
                    });
                  },
                ),
                const SizedBox(width: 16),
                _appointmentTypeButton(
                  title: 'Clinic Visit',
                  icon: Icons.local_hospital,
                  isSelected: _selectedType == 'Clinic Visit',
                  onTap: () {
                    setState(() {
                      _selectedType = 'Clinic Visit';
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Date Selection Section
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
                  'Select Date',
                  style: TextStyle(
                    color: Color(0xFF1E293B),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            SizedBox(
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: next7Days.length,
                itemBuilder: (context, index) {
                  final day = next7Days[index];
                  final bool isSelected = _selectedDateIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDateIndex = index;
                      });
                    },
                    child: Container(
                      width: 70,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            spreadRadius: 0,
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            day['dayName'],
                            style: TextStyle(
                              color:
                                  isSelected
                                      ? Colors.white
                                      : const Color(0xFF64748B),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            day['dayNumber'].toString(),
                            style: TextStyle(
                              color:
                                  isSelected
                                      ? Colors.white
                                      : const Color(0xFF1E293B),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  isSelected
                                      ? Colors.white
                                      : Colors.transparent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 30),

            // Time Selection Section
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
                  'Select Time',
                  style: TextStyle(
                    color: Color(0xFF1E293B),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2.5,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _timeSlots.length,
              itemBuilder: (context, index) {
                final bool isSelected = _selectedTimeSlot == index;
                final bool isAvailable =
                    index != 2 &&
                    index != 5 &&
                    index != 8; // Random unavailable slots

                return GestureDetector(
                  onTap:
                      isAvailable
                          ? () {
                            setState(() {
                              _selectedTimeSlot = index;
                            });
                          }
                          : null,
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? AppColors.primary
                              : (isAvailable
                                  ? Colors.white
                                  : const Color(0xFFF1F5F9)),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow:
                          isSelected || isAvailable
                              ? [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  spreadRadius: 0,
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ]
                              : null,
                    ),
                    child: Center(
                      child: Text(
                        _timeSlots[index],
                        style: TextStyle(
                          color:
                              isSelected
                                  ? Colors.white
                                  : (isAvailable
                                      ? const Color(0xFF1E293B)
                                      : const Color(0xFFADB5BD)),
                          fontSize: 14,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 30),

            // Additional Notes Section
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
                  'Additional Notes',
                  style: TextStyle(
                    color: Color(0xFF1E293B),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Add any specific concerns or symptoms here...',
                  hintStyle: const TextStyle(
                    color: Color(0xFFA0A5BD),
                    fontSize: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Book Appointment Button
            GestureDetector(
              onTap:
                  _selectedTimeSlot != -1
                      ? () {
                        // Book appointment logic
                        showDialog(
                          context: context,
                          builder:
                              (context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                title: const Text(
                                  'Appointment Booked!',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1E293B),
                                  ),
                                ),
                                content: Text(
                                  'You have successfully booked a $_selectedType with Dr. Sarah Johnson on ${next7Days[_selectedDateIndex]['dayName']}, ${next7Days[_selectedDateIndex]['dayNumber']} at ${_timeSlots[_selectedTimeSlot]}.',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      setState(() {
                                        _showScheduleForm = false;
                                      });
                                    },
                                    child: Text(
                                      'OK',
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        );
                      }
                      : null,
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  gradient:
                      _selectedTimeSlot != -1
                          ? const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFF1D70F1), Color(0xFF0B59CC)],
                          )
                          : null,
                  color:
                      _selectedTimeSlot == -1
                          ? Colors.grey.withOpacity(0.3)
                          : null,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow:
                      _selectedTimeSlot != -1
                          ? [
                            BoxShadow(
                              color: const Color(0xFF1D70F1).withOpacity(0.3),
                              spreadRadius: 0,
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ]
                          : null,
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Book Appointment',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
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
              'My Appointments',
              style: TextStyle(
                color: Color(0xFF1E293B),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Manage your medical schedule',
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
            // Search Button
            _buildActionButton(
              onTap: () {
                // Search appointments
              },
              icon: Icons.search,
              notification: false,
              gradient: const [Color(0xFF64B6FF), Color(0xFF338BED)],
            ),
            const SizedBox(width: 12),
            // Calendar Button
            _buildActionButton(
              onTap: () {
                // Open calendar view
              },
              icon: Icons.calendar_today,
              notification: false,
              gradient: const [Color(0xFF9E8CFF), Color(0xFF7B68EE)],
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

  // Appointment type button
  Widget _appointmentTypeButton({
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 0,
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : AppColors.primary,
                size: 32,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? Colors.white : const Color(0xFF1E293B),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

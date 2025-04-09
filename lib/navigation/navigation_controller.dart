import 'package:flutter/material.dart';
import 'package:telehealth_app/pages/chat_page.dart';
import '../pages/home_page.dart';
import '../pages/appointment_page.dart';

// Global key to access NavigationController state from anywhere
final GlobalKey<NavigationControllerState> navigatorKey =
    GlobalKey<NavigationControllerState>();

class NavigationController extends StatefulWidget {
  const NavigationController({super.key});

  // Static method to navigate from anywhere
  static void navigateTo(int index) {
    navigatorKey.currentState?.navigateTo(index);
  }

  @override
  State<NavigationController> createState() => NavigationControllerState();

  // Static instance that can be created in main.dart
  static final NavigationController instance = NavigationController(
    key: navigatorKey,
  );
}

// Make this public by removing the underscore
class NavigationControllerState extends State<NavigationController> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const AppointmentPage(),
    const ChatPage(), // Use our ChatPage instead of Placeholder
    const Placeholder(), // Profile page placeholder
  ];

  // Public method to navigate to a specific tab
  void navigateTo(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: _currentIndex,
        onTap: navigateTo,
      ),
    );
  }
}

// Import the custom navigation bar here so it's accessible through this file
class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60, // Reduced height
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            icon: Icons.home,
            isActive: currentIndex == 0,
            onTap: () => onTap(0),
          ),
          _buildNavItem(
            icon: Icons.calendar_today,
            isActive: currentIndex == 1,
            onTap: () => onTap(1),
          ),
          _buildNavItem(
            icon: Icons.chat_bubble,
            isActive: currentIndex == 2,
            onTap: () => onTap(2),
          ),
          _buildNavItem(
            icon: Icons.person,
            isActive: currentIndex == 3,
            onTap: () => onTap(3),
          ),
        ],
      ),
    );
  }

  // Individual navigation item
  Widget _buildNavItem({
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color:
              isActive
                  ? const Color(0xFF1D70F1).withOpacity(0.1)
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: isActive ? const Color(0xFF1D70F1) : const Color(0xFF94A3B8),
          size: 24,
        ),
      ),
    );
  }
}

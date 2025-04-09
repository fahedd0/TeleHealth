// lib/navigation/navigation_controller.dart
import 'package:flutter/material.dart';
import 'package:telehealth_app/pages/chat_page.dart';
import 'package:telehealth_app/pages/profile_page.dart';
import '../pages/home_page.dart';
import '../pages/appointment_page.dart';
import 'custom_navigation_bar.dart';

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

// Public state class for navigation controller
class NavigationControllerState extends State<NavigationController> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const AppointmentPage(),
    const ChatPage(),
    const ProfilePage(),
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

// lib/routes/app_routes.dart
import 'package:flutter/material.dart';
import '../pages/appointment_page.dart';
import '../pages/home_page.dart';
import '../pages/chat_page.dart';
import '../pages/profile_page.dart';
import '../navigation/navigation_controller.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/auth/forgot_password_screen.dart';
import '../screens/splash_screen.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    '/': (context) => const SplashScreen(),
    '/login': (context) => const LoginScreen(),
    '/register': (context) => const RegisterScreen(),
    '/forgot-password': (context) => const ForgotPasswordScreen(),
    '/home': (context) => const HomePage(),
    '/main':
        (context) =>
            NavigationController.instance, // Main app with bottom navigation
    '/appointments': (context) => const AppointmentPage(),
    '/chat': (context) => const ChatPage(),
    '/profile': (context) => const ProfilePage(),
  };
}

import 'package:flutter/material.dart';
import '../pages/appointment_page.dart';
import '../pages/home_page.dart';
import '../navigation/navigation_controller.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    '/':
        (context) =>
            NavigationController
                .instance, // Use the static instance with the global key
    '/home': (context) => const HomePage(),
    '/appointments': (context) => const AppointmentPage(),
    // Add more routes here later, like:
    // '/login': (context) => const LoginPage(),
  };
}

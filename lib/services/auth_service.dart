// lib/services/auth_service.dart
import 'dart:async';
import 'package:flutter/foundation.dart';

/// Authentication service to handle user auth operations
///
/// This is a simple mock implementation for demo purposes.
/// In a real app, you would use Firebase Auth, AWS Cognito, or a custom backend.
class AuthService {
  static final AuthService _instance = AuthService._internal();

  // Singleton pattern
  factory AuthService() {
    return _instance;
  }

  AuthService._internal();

  // Current user data
  String? _userId;
  String? _userName;
  String? _userEmail;
  bool _isLoggedIn = false;

  // Auth state notifier
  final ValueNotifier<bool> authStateChanges = ValueNotifier<bool>(false);

  // Getters for user data
  String? get userId => _userId;
  String? get userName => _userName;
  String? get userEmail => _userEmail;
  bool get isLoggedIn => _isLoggedIn;

  // Mock user database
  final Map<String, Map<String, dynamic>> _users = {
    'user@example.com': {
      'userId': 'user123',
      'name': 'Test User',
      'email': 'user@example.com',
      'password': 'password123',
    },
  };

  /// Login with email and password
  Future<bool> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Check if user exists and password matches
    if (_users.containsKey(email) && _users[email]!['password'] == password) {
      _userId = _users[email]!['userId'];
      _userName = _users[email]!['name'];
      _userEmail = email;
      _isLoggedIn = true;

      // Notify listeners
      authStateChanges.value = true;

      return true;
    }

    return false;
  }

  /// Register new user
  Future<bool> register(String name, String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Check if email already exists
    if (_users.containsKey(email)) {
      throw Exception('Email already registered');
    }

    // Create new user
    final userId = 'user${DateTime.now().millisecondsSinceEpoch}';
    _users[email] = {
      'userId': userId,
      'name': name,
      'email': email,
      'password': password,
    };

    // Auto login after registration
    _userId = userId;
    _userName = name;
    _userEmail = email;
    _isLoggedIn = true;

    // Notify listeners
    authStateChanges.value = true;

    return true;
  }

  /// Logout current user
  Future<void> logout() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    _userId = null;
    _userName = null;
    _userEmail = null;
    _isLoggedIn = false;

    // Notify listeners
    authStateChanges.value = false;
  }

  /// Reset password
  Future<bool> resetPassword(String email) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Check if email exists
    if (!_users.containsKey(email)) {
      // For security reasons, don't reveal if email exists or not
      // Just return true as if reset email was sent
      return true;
    }

    // In a real app, you would send a password reset email here
    // For this demo, we'll just simulate success
    return true;
  }

  /// Check if user is logged in
  Future<bool> checkAuthState() async {
    // Simulate checking stored credentials
    await Future.delayed(const Duration(milliseconds: 500));

    // In a real app, you would check for stored tokens/credentials
    return _isLoggedIn;
  }
}

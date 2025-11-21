import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFFBDB300);
  static const Color backgroundColor = Color(0xFFF8F9FA);
  static const Color cardBackground = Colors.white;
  static const Color textPrimary = Color(0xFF2C3E50);
  static const Color textSecondary = Color(0xFF7F8C8D);
  static const Color accent = Color(0xFF3498DB);
  static const Color success = Color(0xFF27AE60);
  static const Color warning = Color(0xFFF39C12);
  static const Color error = Color(0xFFE74C3C);
}

class AppSizes {
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;
  
  static const double radiusSmall = 6.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  
  static const double iconSmall = 16.0;
  static const double iconMedium = 24.0;
  static const double iconLarge = 32.0;
}

class AppStrings {
  static const String appName = 'GeForce';
  static const String tagline = 'Made With BrainBox';
  static const String searchHint = 'Search graphics cards...';
  static const String noResultsFound = 'No graphic cards found matching your search.';
  static const String maxComparisonReached = 'You can compare up to three cards only.';
  static const String networkError = 'Network error occurred. Please try again.';
  static const String loadingText = 'Loading...';
  
  // Navigation
  static const String navDashboard = 'Dashboard';
  static const String navCompare = 'Compare';
  static const String navSettings = 'Settings';
  
  // Sections
  static const String trending = 'Trending';
  static const String favorites = 'Favorites';
  static const String allCards = 'All Graphics Cards';
  static const String specifications = 'Specifications';
  static const String performance = 'Performance';
  static const String compatibility = 'Compatibility';
  
  // Settings
  static const String notifications = 'Notifications';
  static const String theme = 'Theme';
  static const String about = 'About';
  static const String version = 'Version';
}
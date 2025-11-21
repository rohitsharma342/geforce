import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/splash_screen.dart';
import 'themes/app_theme.dart';
import 'controllers/dashboard_controller.dart';
import 'controllers/comparison_controller.dart';
import 'controllers/settings_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(DashboardController());
    Get.put(ComparisonController());
    Get.put(SettingsController());
    
    return GetMaterialApp(
      title: 'GeForce',
      theme: AppTheme.lightTheme,
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
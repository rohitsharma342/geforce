import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends GetxController {
  final RxBool notificationsEnabled = true.obs;
  final RxBool isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadSettings();
  }

  Future<void> loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      notificationsEnabled.value = prefs.getBool('notifications') ?? true;
      isDarkMode.value = prefs.getBool('dark_mode') ?? false;
    } catch (e) {
      print('Error loading settings: $e');
    }
  }

  Future<void> toggleNotifications(bool value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('notifications', value);
      notificationsEnabled.value = value;
      
      Get.snackbar(
        'Settings Updated',
        'Notifications ${value ? 'enabled' : 'disabled'}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print('Error saving notification setting: $e');
    }
  }

  Future<void> toggleTheme(bool value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('dark_mode', value);
      isDarkMode.value = value;
      
      // Note: Theme switching would require additional implementation
      // with GetX theme management
      Get.snackbar(
        'Theme Updated',
        'Theme changed to ${value ? 'dark' : 'light'} mode',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print('Error saving theme setting: $e');
    }
  }

  String getAppVersion() {
    return '1.0.0';
  }

  String getDeveloper() {
    return 'Made With BrainBox';
  }
}
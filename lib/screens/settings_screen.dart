import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/settings_controller.dart';
import '../utils/constants.dart';

class SettingsScreen extends StatelessWidget {
  final SettingsController controller = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.navSettings),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildPreferencesSection(context),
            SizedBox(height: AppSizes.paddingLarge),
            _buildAboutSection(context),
            SizedBox(height: AppSizes.paddingLarge),
          ],
        ),
      ),
    );
  }

  Widget _buildPreferencesSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppSizes.paddingLarge),
      padding: EdgeInsets.all(AppSizes.paddingLarge),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Preferences',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: AppSizes.paddingLarge),
          Obx(() => ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.notifications_outlined,
                    color: AppColors.primaryColor,
                  ),
                ),
                title: Text(
                  AppStrings.notifications,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  'Receive updates about new graphics cards',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
                trailing: Switch(
                  value: controller.notificationsEnabled.value,
                  onChanged: controller.toggleNotifications,
                  activeColor: AppColors.primaryColor,
                ),
                contentPadding: EdgeInsets.zero,
              )),
          Divider(),
          Obx(() => ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    controller.isDarkMode.value
                        ? Icons.dark_mode_outlined
                        : Icons.light_mode_outlined,
                    color: AppColors.primaryColor,
                  ),
                ),
                title: Text(
                  AppStrings.theme,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  controller.isDarkMode.value ? 'Dark Mode' : 'Light Mode',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
                trailing: Switch(
                  value: controller.isDarkMode.value,
                  onChanged: controller.toggleTheme,
                  activeColor: AppColors.primaryColor,
                ),
                contentPadding: EdgeInsets.zero,
              )),
        ],
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppSizes.paddingLarge),
      padding: EdgeInsets.all(AppSizes.paddingLarge),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.about,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: AppSizes.paddingLarge),
          ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.memory,
                color: Colors.white,
              ),
            ),
            title: Text(
              AppStrings.appName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4),
                Text(
                  'Your comprehensive graphics card companion',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '${AppStrings.version}: ${controller.getAppVersion()}',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            contentPadding: EdgeInsets.zero,
          ),
          SizedBox(height: AppSizes.paddingMedium),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(AppSizes.paddingMedium),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Text(
                  controller.getDeveloper(),
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Crafted with passion for tech enthusiasts',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(height: AppSizes.paddingLarge),
          _buildInfoTile(
            icon: Icons.info_outline,
            title: 'Features',
            subtitle: 'Compare cards, view specs, save favorites',
          ),
          _buildInfoTile(
            icon: Icons.support_outlined,
            title: 'Support',
            subtitle: 'Get help and report issues',
          ),
          _buildInfoTile(
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy',
            subtitle: 'Your data stays on your device',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.textSecondary,
        size: 20,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 12,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 8),
      dense: true,
    );
  }
}
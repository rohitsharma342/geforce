import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/graphic_card.dart';
import '../controllers/dashboard_controller.dart';
import '../widgets/performance_chart.dart';
import '../utils/constants.dart';

class GraphicCardDetailsScreen extends StatelessWidget {
  final GraphicCard card;
  final DashboardController controller = Get.find<DashboardController>();

  GraphicCardDetailsScreen({required this.card});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(card.name),
        actions: [
          Obx(() {
            final currentCard = controller.getCardById(card.id);
            final isFavorite = currentCard?.isFavorite ?? false;
            return IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? AppColors.error : AppColors.textSecondary,
              ),
              onPressed: () {
                controller.toggleFavorite(card.id);
                Get.snackbar(
                  isFavorite ? 'Removed from Favorites' : 'Added to Favorites',
                  isFavorite
                      ? '${card.name} removed from favorites'
                      : '${card.name} added to favorites',
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
            );
          }),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCardHeader(context),
            SizedBox(height: AppSizes.paddingLarge),
            _buildSpecificationsSection(context),
            SizedBox(height: AppSizes.paddingLarge),
            _buildPerformanceSection(context),
            SizedBox(height: AppSizes.paddingLarge),
            _buildCompatibilitySection(context),
            SizedBox(height: AppSizes.paddingLarge),
          ],
        ),
      ),
    );
  }

  Widget _buildCardHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
                color: Colors.grey[100],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
                child: CachedNetworkImage(
                  imageUrl: card.imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.memory,
                        size: 64,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: AppSizes.paddingLarge),
          Text(
            card.name,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(height: AppSizes.paddingSmall),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingMedium,
                  vertical: AppSizes.paddingSmall,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  card.brand,
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: AppSizes.paddingMedium),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingMedium,
                  vertical: AppSizes.paddingSmall,
                ),
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  card.performanceTier,
                  style: TextStyle(
                    color: AppColors.accent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Spacer(),
              Text(
                card.price,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.success,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSpecificationsSection(BuildContext context) {
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
          Row(
            children: [
              Icon(Icons.info_outline, color: AppColors.primaryColor),
              SizedBox(width: AppSizes.paddingSmall),
              Text(
                AppStrings.specifications,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
          SizedBox(height: AppSizes.paddingLarge),
          ...card.specifications.entries.map((entry) {
            return Padding(
              padding: EdgeInsets.only(bottom: AppSizes.paddingMedium),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      entry.key,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      entry.value.toString(),
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildPerformanceSection(BuildContext context) {
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
          Row(
            children: [
              Icon(Icons.speed, color: AppColors.primaryColor),
              SizedBox(width: AppSizes.paddingSmall),
              Text(
                AppStrings.performance,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
          SizedBox(height: AppSizes.paddingLarge),
          Container(
            height: 250,
            child: PerformanceChart(benchmarkScores: card.benchmarkScores),
          ),
        ],
      ),
    );
  }

  Widget _buildCompatibilitySection(BuildContext context) {
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
          Row(
            children: [
              Icon(Icons.check_circle_outline, color: AppColors.primaryColor),
              SizedBox(width: AppSizes.paddingSmall),
              Text(
                AppStrings.compatibility,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
          SizedBox(height: AppSizes.paddingLarge),
          ...card.compatibilityNotes.map((note) {
            return Padding(
              padding: EdgeInsets.only(bottom: AppSizes.paddingMedium),
              child: Row(
                children: [
                  Icon(
                    Icons.check,
                    color: AppColors.success,
                    size: AppSizes.iconSmall,
                  ),
                  SizedBox(width: AppSizes.paddingMedium),
                  Expanded(
                    child: Text(
                      note,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
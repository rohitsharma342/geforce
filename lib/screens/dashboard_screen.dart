import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';
import '../widgets/trending_carousel.dart';
import '../widgets/graphic_card_item.dart';
import '../utils/constants.dart';
import '../data/static_data.dart';
import 'graphic_card_details_screen.dart';
import 'comparison_screen.dart';
import 'settings_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardController controller = Get.find<DashboardController>();
  final TextEditingController searchController = TextEditingController();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    controller.updateFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.appName),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
      ),
      body: _selectedIndex == 0
          ? _buildDashboardContent()
          : _selectedIndex == 1
              ? ComparisonScreen()
              : SettingsScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: AppStrings.navDashboard,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.compare),
            label: AppStrings.navCompare,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: AppStrings.navSettings,
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardContent() {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
              SizedBox(height: AppSizes.paddingMedium),
              Text(
                AppStrings.loadingText,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );
      }

      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchSection(),
            SizedBox(height: AppSizes.paddingMedium),
            if (controller.trendingCards.isNotEmpty) ...[
              _buildTrendingSection(),
              SizedBox(height: AppSizes.paddingLarge),
            ],
            if (controller.favoriteCards.isNotEmpty) ...[
              _buildFavoritesSection(),
              SizedBox(height: AppSizes.paddingLarge),
            ],
            _buildAllCardsSection(),
            SizedBox(height: AppSizes.paddingLarge),
          ],
        ),
      );
    });
  }

  Widget _buildSearchSection() {
    return Container(
      margin: EdgeInsets.all(AppSizes.paddingMedium),
      child: Column(
        children: [
          TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: AppStrings.searchHint,
              prefixIcon: Icon(Icons.search, color: AppColors.textSecondary),
              suffixIcon: IconButton(
                icon: Icon(Icons.filter_list, color: AppColors.primaryColor),
                onPressed: _showFilterDialog,
              ),
            ),
            onChanged: controller.searchCards,
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingMedium),
          child: Row(
            children: [
              Icon(Icons.trending_up, color: AppColors.primaryColor),
              SizedBox(width: AppSizes.paddingSmall),
              Text(
                AppStrings.trending,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
        SizedBox(height: AppSizes.paddingMedium),
        TrendingCarousel(
          cards: controller.trendingCards,
          onCardTap: (card) {
            Get.to(() => GraphicCardDetailsScreen(card: card));
          },
        ),
      ],
    );
  }

  Widget _buildFavoritesSection() {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingMedium),
              child: Row(
                children: [
                  Icon(Icons.favorite, color: AppColors.error),
                  SizedBox(width: AppSizes.paddingSmall),
                  Text(
                    AppStrings.favorites,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSizes.paddingMedium),
            Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingMedium),
                itemCount: controller.favoriteCards.length,
                itemBuilder: (context, index) {
                  final card = controller.favoriteCards[index];
                  return Container(
                    width: 300,
                    margin: EdgeInsets.only(right: AppSizes.paddingMedium),
                    child: GraphicCardItem(
                      card: card,
                      onTap: () {
                        Get.to(() => GraphicCardDetailsScreen(card: card));
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }

  Widget _buildAllCardsSection() {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingMedium),
              child: Text(
                AppStrings.allCards,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            SizedBox(height: AppSizes.paddingMedium),
            controller.filteredCards.isEmpty
                ? Container(
                    padding: EdgeInsets.all(AppSizes.paddingXLarge),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: AppColors.textSecondary,
                          ),
                          SizedBox(height: AppSizes.paddingMedium),
                          Text(
                            AppStrings.noResultsFound,
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding:
                        EdgeInsets.symmetric(horizontal: AppSizes.paddingMedium),
                    itemCount: controller.filteredCards.length,
                    itemBuilder: (context, index) {
                      final card = controller.filteredCards[index];
                      return Padding(
                        padding:
                            EdgeInsets.only(bottom: AppSizes.paddingMedium),
                        child: GraphicCardItem(
                          card: card,
                          onTap: () {
                            Get.to(() => GraphicCardDetailsScreen(card: card));
                          },
                        ),
                      );
                    },
                  ),
          ],
        ));
  }

  void _showFilterDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('Filters'),
        content: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Brand'),
              SizedBox(height: 8),
              Obx(() => DropdownButtonFormField<String>(
                    value: controller.selectedBrand.value,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    items: StaticData.getBrands().map((brand) {
                      return DropdownMenuItem(
                        value: brand,
                        child: Text(brand),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        controller.setFilters(value, controller.selectedTier.value);
                      }
                    },
                  )),
              SizedBox(height: 16),
              Text('Performance Tier'),
              SizedBox(height: 8),
              Obx(() => DropdownButtonFormField<String>(
                    value: controller.selectedTier.value,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    items: StaticData.getPerformanceTiers().map((tier) {
                      return DropdownMenuItem(
                        value: tier,
                        child: Text(tier),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        controller.setFilters(controller.selectedBrand.value, value);
                      }
                    },
                  )),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              controller.setFilters('All', 'All');
              Get.back();
            },
            child: Text('Clear'),
          ),
          ElevatedButton(
            onPressed: () => Get.back(),
            child: Text('Apply'),
          ),
        ],
      ),
    );
  }
}
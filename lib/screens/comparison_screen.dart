import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/comparison_controller.dart';
import '../controllers/dashboard_controller.dart';
import '../widgets/comparison_table.dart';
import '../utils/constants.dart';
import '../models/graphic_card.dart';

class ComparisonScreen extends StatelessWidget {
  final ComparisonController comparisonController = Get.find<ComparisonController>();
  final DashboardController dashboardController = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Compare Graphics Cards'),
        actions: [
          Obx(() => comparisonController.selectedCards.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear_all),
                  onPressed: () {
                    comparisonController.clearAll();
                  },
                )
              : SizedBox()),
        ],
      ),
      body: Obx(() {
        if (comparisonController.selectedCards.isEmpty) {
          return _buildEmptyState(context);
        }
        return _buildComparisonContent(context);
      }),
      floatingActionButton: Obx(() => comparisonController.canAddCard()
          ? FloatingActionButton.extended(
              onPressed: _showAddCardDialog,
              icon: Icon(Icons.add),
              label: Text('Add Card'),
              backgroundColor: AppColors.primaryColor,
            )
          : SizedBox()),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.compare,
            size: 80,
            color: AppColors.textSecondary.withOpacity(0.5),
          ),
          SizedBox(height: AppSizes.paddingLarge),
          Text(
            'No cards to compare',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          SizedBox(height: AppSizes.paddingMedium),
          Text(
            'Add graphics cards to start comparing\ntheir specifications side by side',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 16,
            ),
          ),
          SizedBox(height: AppSizes.paddingXLarge),
          ElevatedButton.icon(
            onPressed: _showAddCardDialog,
            icon: Icon(Icons.add),
            label: Text('Add Your First Card'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.paddingLarge,
                vertical: AppSizes.paddingMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonContent(BuildContext context) {
    return Column(
      children: [
        _buildSelectedCards(),
        Expanded(
          child: SingleChildScrollView(
            child: ComparisonTable(
              cards: comparisonController.selectedCards,
              onRemoveCard: (cardId) {
                comparisonController.removeCard(cardId);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedCards() {
    return Container(
      padding: EdgeInsets.all(AppSizes.paddingMedium),
      color: Colors.grey[50],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selected Cards (${comparisonController.selectedCards.length}/3)',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: AppSizes.paddingMedium),
          Container(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: comparisonController.selectedCards.length,
              itemBuilder: (context, index) {
                final card = comparisonController.selectedCards[index];
                return Container(
                  width: 200,
                  margin: EdgeInsets.only(right: AppSizes.paddingMedium),
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(AppSizes.paddingSmall),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.memory,
                              color: AppColors.primaryColor,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: AppSizes.paddingSmall),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  card.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  card.brand,
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.close,
                              size: 16,
                              color: AppColors.error,
                            ),
                            onPressed: () {
                              comparisonController.removeCard(card.id);
                            },
                            constraints: BoxConstraints(
                              minWidth: 24,
                              minHeight: 24,
                            ),
                            padding: EdgeInsets.zero,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showAddCardDialog() {
    final TextEditingController searchController = TextEditingController();
    final RxList<GraphicCard> searchResults = <GraphicCard>[].obs;
    final RxString searchQuery = ''.obs;

    searchResults.value = dashboardController.allCards.take(5).toList();

    Get.dialog(
      AlertDialog(
        title: Text('Add Graphics Card'),
        content: Container(
          width: double.maxFinite,
          height: 400,
          child: Column(
            children: [
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search graphics cards...',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (query) {
                  searchQuery.value = query;
                  if (query.isEmpty) {
                    searchResults.value = dashboardController.allCards.take(5).toList();
                  } else {
                    searchResults.value = dashboardController.allCards
                        .where((card) =>
                            card.name.toLowerCase().contains(query.toLowerCase()) ||
                            card.brand.toLowerCase().contains(query.toLowerCase()))
                        .toList();
                  }
                },
              ),
              SizedBox(height: AppSizes.paddingMedium),
              Expanded(
                child: Obx(() => ListView.builder(
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        final card = searchResults[index];
                        final isAlreadySelected = comparisonController.selectedCards
                            .any((c) => c.id == card.id);
                        
                        return ListTile(
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.memory,
                              color: AppColors.primaryColor,
                              size: 20,
                            ),
                          ),
                          title: Text(
                            card.name,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            '${card.brand} • ${card.price}',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          trailing: isAlreadySelected
                              ? Icon(
                                  Icons.check,
                                  color: AppColors.success,
                                )
                              : null,
                          enabled: !isAlreadySelected,
                          onTap: isAlreadySelected
                              ? null
                              : () {
                                  comparisonController.addCard(card);
                                  Get.back();
                                },
                        );
                      },
                    )),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
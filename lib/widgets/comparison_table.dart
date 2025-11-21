import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/graphic_card.dart';
import '../controllers/comparison_controller.dart';
import '../utils/constants.dart';
import 'package:get/get.dart';

class ComparisonTable extends StatelessWidget {
  final List<GraphicCard> cards;
  final Function(String) onRemoveCard;
  final ComparisonController controller = Get.find<ComparisonController>();

  ComparisonTable({
    Key? key,
    required this.cards,
    required this.onRemoveCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (cards.isEmpty) return SizedBox();

    final specs = controller.getComparisonSpecs();

    return Container(
      margin: EdgeInsets.all(AppSizes.paddingMedium),
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
        children: [
          _buildHeader(),
          _buildCardHeaders(),
          Divider(height: 1),
          ...specs.map((spec) => _buildSpecRow(spec)).toList(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(AppSizes.paddingLarge),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSizes.radiusMedium),
          topRight: Radius.circular(AppSizes.radiusMedium),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.compare,
            color: AppColors.primaryColor,
            size: AppSizes.iconMedium,
          ),
          SizedBox(width: AppSizes.paddingSmall),
          Text(
            'Specifications Comparison',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardHeaders() {
    return Container(
      height: 120,
      child: Row(
        children: [
          Container(
            width: 120,
            padding: EdgeInsets.all(AppSizes.paddingMedium),
            child: Center(
              child: Text(
                'Specification',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          ...cards.map((card) => Expanded(
                child: Container(
                  padding: EdgeInsets.all(AppSizes.paddingSmall),
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[100],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: card.imageUrl,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                                strokeWidth: 2,
                              ),
                            ),
                            errorWidget: (context, url, error) => Icon(
                              Icons.memory,
                              color: AppColors.primaryColor,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: AppSizes.paddingSmall),
                      Text(
                        card.name,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        card.price,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: AppColors.success,
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildSpecRow(String specName) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 120,
            padding: EdgeInsets.all(AppSizes.paddingMedium),
            child: Text(
              specName,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          ...cards.map((card) => Expanded(
                child: Container(
                  padding: EdgeInsets.all(AppSizes.paddingMedium),
                  child: Text(
                    controller.getSpecValue(card, specName),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/graphic_card.dart';
import '../utils/constants.dart';

class GraphicCardItem extends StatelessWidget {
  final GraphicCard card;
  final VoidCallback onTap;

  const GraphicCardItem({
    Key? key,
    required this.card,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        child: Container(
          padding: EdgeInsets.all(AppSizes.paddingMedium),
          child: Row(
            children: [
              _buildCardImage(),
              SizedBox(width: AppSizes.paddingMedium),
              Expanded(
                child: _buildCardInfo(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardImage() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        color: Colors.grey[100],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        child: CachedNetworkImage(
          imageUrl: card.imageUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
            ),
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
                strokeWidth: 2,
              ),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
            ),
            child: Center(
              child: Icon(
                Icons.memory,
                color: AppColors.primaryColor,
                size: AppSizes.iconLarge,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                card.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (card.isTrending)
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: AppColors.warning.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.trending_up,
                      size: 12,
                      color: AppColors.warning,
                    ),
                    SizedBox(width: 2),
                    Text(
                      'Hot',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.warning,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        SizedBox(height: AppSizes.paddingSmall),
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.paddingSmall,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                card.brand,
                style: TextStyle(
                  fontSize: 10,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(width: AppSizes.paddingSmall),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.paddingSmall,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: AppColors.accent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                card.performanceTier,
                style: TextStyle(
                  fontSize: 10,
                  color: AppColors.accent,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: AppSizes.paddingSmall),
        Row(
          children: [
            Icon(
              Icons.memory,
              size: AppSizes.iconSmall,
              color: AppColors.textSecondary,
            ),
            SizedBox(width: 4),
            Text(
              card.vram,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(width: AppSizes.paddingMedium),
            Icon(
              Icons.speed,
              size: AppSizes.iconSmall,
              color: AppColors.textSecondary,
            ),
            SizedBox(width: 4),
            Text(
              card.clockSpeed,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
            Spacer(),
            Text(
              card.price,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.success,
              ),
            ),
          ],
        ),
        if (card.isFavorite)
          Container(
            margin: EdgeInsets.only(top: AppSizes.paddingSmall),
            child: Row(
              children: [
                Icon(
                  Icons.favorite,
                  size: AppSizes.iconSmall,
                  color: AppColors.error,
                ),
                SizedBox(width: 4),
                Text(
                  'Favorite',
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.error,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
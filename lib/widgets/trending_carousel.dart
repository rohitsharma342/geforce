import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/graphic_card.dart';
import '../utils/constants.dart';

class TrendingCarousel extends StatelessWidget {
  final List<GraphicCard> cards;
  final Function(GraphicCard) onCardTap;

  const TrendingCarousel({
    Key? key,
    required this.cards,
    required this.onCardTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (cards.isEmpty) {
      return SizedBox();
    }

    return Container(
      height: 220,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.85),
        itemCount: cards.length,
        itemBuilder: (context, index) {
          final card = cards[index];
          return Container(
            margin: EdgeInsets.symmetric(horizontal: AppSizes.paddingSmall),
            child: _buildTrendingCard(context, card),
          );
        },
      ),
    );
  }

  Widget _buildTrendingCard(BuildContext context, GraphicCard card) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
      ),
      child: InkWell(
        onTap: () => onCardTap(card),
        borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primaryColor.withOpacity(0.1),
                Colors.white,
              ],
            ),
          ),
          child: Column(
            children: [
              _buildCardImageSection(card),
              Expanded(
                child: _buildCardInfoSection(context, card),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardImageSection(GraphicCard card) {
    return Container(
      height: 120,
      width: double.infinity,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSizes.radiusLarge),
              topRight: Radius.circular(AppSizes.radiusLarge),
            ),
            child: CachedNetworkImage(
              imageUrl: card.imageUrl,
              width: double.infinity,
              height: 120,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppSizes.radiusLarge),
                    topRight: Radius.circular(AppSizes.radiusLarge),
                  ),
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
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppSizes.radiusLarge),
                    topRight: Radius.circular(AppSizes.radiusLarge),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.memory,
                    color: AppColors.primaryColor,
                    size: 40,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: AppSizes.paddingSmall,
            right: AppSizes.paddingSmall,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.paddingSmall,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: AppColors.warning,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.trending_up,
                    size: 12,
                    color: Colors.white,
                  ),
                  SizedBox(width: 2),
                  Text(
                    'Trending',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardInfoSection(BuildContext context, GraphicCard card) {
    return Padding(
      padding: EdgeInsets.all(AppSizes.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            card.name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
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
                  borderRadius: BorderRadius.circular(10),
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
              Spacer(),
              Text(
                card.price,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.success,
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
              Expanded(
                child: Text(
                  card.vram,
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  card.performanceTier,
                  style: TextStyle(
                    fontSize: 9,
                    color: AppColors.accent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
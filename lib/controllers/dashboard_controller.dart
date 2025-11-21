import 'package:get/get.dart';
import '../models/graphic_card.dart';
import '../data/static_data.dart';

class DashboardController extends GetxController {
  final RxList<GraphicCard> allCards = <GraphicCard>[].obs;
  final RxList<GraphicCard> filteredCards = <GraphicCard>[].obs;
  final RxList<GraphicCard> trendingCards = <GraphicCard>[].obs;
  final RxList<GraphicCard> favoriteCards = <GraphicCard>[].obs;
  final RxString searchQuery = ''.obs;
  final RxString selectedBrand = 'All'.obs;
  final RxString selectedTier = 'All'.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() {
    isLoading.value = true;
    
    // Simulate loading delay
    Future.delayed(Duration(seconds: 2), () {
      allCards.value = StaticData.getAllGraphicCards();
      trendingCards.value = StaticData.getTrendingCards();
      filteredCards.value = allCards;
      isLoading.value = false;
    });
  }

  void searchCards(String query) {
    searchQuery.value = query;
    applyFilters();
  }

  void setFilters(String brand, String tier) {
    selectedBrand.value = brand;
    selectedTier.value = tier;
    applyFilters();
  }

  void applyFilters() {
    List<GraphicCard> filtered = allCards.where((card) {
      bool matchesSearch = searchQuery.value.isEmpty ||
          card.name.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
          card.brand.toLowerCase().contains(searchQuery.value.toLowerCase());
      
      bool matchesBrand = selectedBrand.value == 'All' ||
          card.brand == selectedBrand.value;
      
      bool matchesTier = selectedTier.value == 'All' ||
          card.performanceTier == selectedTier.value;
      
      return matchesSearch && matchesBrand && matchesTier;
    }).toList();
    
    filteredCards.value = filtered;
  }

  void toggleFavorite(String cardId) {
    final cardIndex = allCards.indexWhere((card) => card.id == cardId);
    if (cardIndex != -1) {
      allCards[cardIndex].isFavorite = !allCards[cardIndex].isFavorite;
      allCards.refresh();
      updateFavorites();
    }
  }

  void updateFavorites() {
    favoriteCards.value = allCards.where((card) => card.isFavorite).toList();
  }

  GraphicCard? getCardById(String id) {
    try {
      return allCards.firstWhere((card) => card.id == id);
    } catch (e) {
      return null;
    }
  }

  List<String> getSearchSuggestions(String query) {
    if (query.isEmpty) return [];
    
    List<String> suggestions = [];
    for (var card in allCards) {
      if (card.name.toLowerCase().contains(query.toLowerCase())) {
        suggestions.add(card.name);
      }
      if (card.brand.toLowerCase().contains(query.toLowerCase()) &&
          !suggestions.contains(card.brand)) {
        suggestions.add(card.brand);
      }
    }
    return suggestions.take(5).toList();
  }
}
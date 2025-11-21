import 'package:get/get.dart';
import '../models/graphic_card.dart';

class ComparisonController extends GetxController {
  final RxList<GraphicCard> selectedCards = <GraphicCard>[].obs;
  final int maxCards = 3;

  bool canAddCard() {
    return selectedCards.length < maxCards;
  }

  void addCard(GraphicCard card) {
    if (canAddCard() && !selectedCards.any((c) => c.id == card.id)) {
      selectedCards.add(card);
    } else if (selectedCards.length >= maxCards) {
      Get.snackbar(
        'Maximum Limit Reached',
        'You can compare up to three cards only.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void removeCard(String cardId) {
    selectedCards.removeWhere((card) => card.id == cardId);
  }

  void clearAll() {
    selectedCards.clear();
  }

  List<String> getComparisonSpecs() {
    if (selectedCards.isEmpty) return [];
    
    return [
      'Architecture',
      'Process',
      'CUDA Cores / Stream Processors',
      'RT Cores / RT Accelerators',
      'Base Clock',
      'Boost Clock',
      'Memory',
      'Memory Bus',
      'Memory Bandwidth',
      'TGP',
    ];
  }

  String getSpecValue(GraphicCard card, String specName) {
    switch (specName) {
      case 'Architecture':
        return card.specifications['Architecture'] ?? 'N/A';
      case 'Process':
        return card.specifications['Process'] ?? 'N/A';
      case 'CUDA Cores / Stream Processors':
        return card.specifications['CUDA Cores'] ?? 
               card.specifications['Stream Processors'] ?? 'N/A';
      case 'RT Cores / RT Accelerators':
        return card.specifications['RT Cores'] ?? 
               card.specifications['RT Accelerators'] ?? 'N/A';
      case 'Base Clock':
        return card.specifications['Base Clock'] ?? 'N/A';
      case 'Boost Clock':
        return card.specifications['Boost Clock'] ?? 'N/A';
      case 'Memory':
        return card.specifications['Memory'] ?? 'N/A';
      case 'Memory Bus':
        return card.specifications['Memory Bus'] ?? 'N/A';
      case 'Memory Bandwidth':
        return card.specifications['Memory Bandwidth'] ?? 'N/A';
      case 'TGP':
        return card.specifications['TGP'] ?? 'N/A';
      default:
        return 'N/A';
    }
  }
}
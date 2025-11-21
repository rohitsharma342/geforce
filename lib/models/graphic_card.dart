class GraphicCard {
  final String id;
  final String name;
  final String brand;
  final String imageUrl;
  final String gpu;
  final String vram;
  final String clockSpeed;
  final String price;
  final String performanceTier;
  final Map<String, dynamic> specifications;
  final List<String> compatibilityNotes;
  final Map<String, int> benchmarkScores;
  final bool isTrending;
  bool isFavorite;

  GraphicCard({
    required this.id,
    required this.name,
    required this.brand,
    required this.imageUrl,
    required this.gpu,
    required this.vram,
    required this.clockSpeed,
    required this.price,
    required this.performanceTier,
    required this.specifications,
    required this.compatibilityNotes,
    required this.benchmarkScores,
    this.isTrending = false,
    this.isFavorite = false,
  });

  factory GraphicCard.fromJson(Map<String, dynamic> json) {
    return GraphicCard(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      imageUrl: json['imageUrl'],
      gpu: json['gpu'],
      vram: json['vram'],
      clockSpeed: json['clockSpeed'],
      price: json['price'],
      performanceTier: json['performanceTier'],
      specifications: json['specifications'],
      compatibilityNotes: List<String>.from(json['compatibilityNotes']),
      benchmarkScores: Map<String, int>.from(json['benchmarkScores']),
      isTrending: json['isTrending'] ?? false,
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'imageUrl': imageUrl,
      'gpu': gpu,
      'vram': vram,
      'clockSpeed': clockSpeed,
      'price': price,
      'performanceTier': performanceTier,
      'specifications': specifications,
      'compatibilityNotes': compatibilityNotes,
      'benchmarkScores': benchmarkScores,
      'isTrending': isTrending,
      'isFavorite': isFavorite,
    };
  }
}
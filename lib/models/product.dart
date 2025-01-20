class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final double rating;
  final int reviews;
  final String category;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.reviews,
    required this.category,
    this.isFavorite = false,
  });

  void toggleFavorite() {
    isFavorite = !isFavorite;
  }
}

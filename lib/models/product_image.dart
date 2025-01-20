class ProductImage {
  final int id;
  final String productId;
  final String imagePath;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductImage({
    required this.id,
    required this.productId,
    required this.imagePath,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'] as int? ?? 0,
      productId: json['product_id']?.toString() ?? '',
      imagePath: json['image_path']?.toString() ?? '',
      createdAt: DateTime.parse(
          json['created_at'] as String? ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(
          json['updated_at'] as String? ?? DateTime.now().toIso8601String()),
    );
  }

  String get fullImageUrl => 'https://dkmart.lk/$imagePath';
}

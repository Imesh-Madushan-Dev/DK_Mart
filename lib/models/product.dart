import 'product_image.dart';

class Product {
  final int id;
  final String productId;
  final String? shopId;
  final String productName;
  final String productDescription;
  final int categoryId;
  final int subcategoryId;
  final int subSubcategoryId;
  final int quantity;
  final String? tags;
  final double normalPrice;
  final int isAffiliate;
  final double affiliatePrice;
  final double? commissionPercentage;
  final double? commissionPrice;
  final DateTime createdAt;
  final DateTime updatedAt;
  bool isFavorite;
  ProductImage? image;

  Product({
    required this.id,
    required this.productId,
    this.shopId,
    required this.productName,
    required this.productDescription,
    required this.categoryId,
    required this.subcategoryId,
    required this.subSubcategoryId,
    required this.quantity,
    this.tags,
    required this.normalPrice,
    required this.isAffiliate,
    required this.affiliatePrice,
    this.commissionPercentage,
    this.commissionPrice,
    required this.createdAt,
    required this.updatedAt,
    this.isFavorite = false,
    this.image,
  });

  void toggleFavorite() {
    isFavorite = !isFavorite;
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: _parseInt(json['id']) ?? 0,
      productId: json['product_id']?.toString() ?? '',
      shopId: json['shop_id']?.toString(),
      productName: json['product_name']?.toString() ?? '',
      productDescription: json['product_description']?.toString() ?? '',
      categoryId: _parseInt(json['category_id']) ?? 0,
      subcategoryId: _parseInt(json['subcategory_id']) ?? 0,
      subSubcategoryId: _parseInt(json['sub_subcategory_id']) ?? 0,
      quantity: _parseInt(json['quantity']) ?? 0,
      tags: json['tags']?.toString(),
      normalPrice: _parseDouble(json['normal_price']) ?? 0.0,
      isAffiliate: _parseInt(json['is_affiliate']) ?? 0,
      affiliatePrice: _parseDouble(json['affiliate_price']) ?? 0.0,
      commissionPercentage: _parseDouble(json['commission_percentage']),
      commissionPrice: _parseDouble(json['commission_price']),
      createdAt: _parseDateTime(json['created_at']) ?? DateTime.now(),
      updatedAt: _parseDateTime(json['updated_at']) ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'shop_id': shopId,
      'product_name': productName,
      'product_description': productDescription,
      'category_id': categoryId,
      'subcategory_id': subcategoryId,
      'sub_subcategory_id': subSubcategoryId,
      'quantity': quantity,
      'tags': tags,
      'normal_price': normalPrice.toString(),
      'is_affiliate': isAffiliate,
      'affiliate_price': affiliatePrice.toString(),
      'commission_percentage': commissionPercentage?.toString(),
      'commission_price': commissionPrice?.toString(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) {
      try {
        return int.parse(value);
      } catch (e) {
        return null;
      }
    }
    if (value is double) {
      return value.toInt();
    }
    return null;
  }

  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    if (value is String) {
      try {
        return double.parse(value);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  static DateTime? _parseDateTime(dynamic value) {
    if (value == null) return null;
    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  String get imageUrl =>
      image?.fullImageUrl ?? 'https://via.placeholder.com/300x200';
}

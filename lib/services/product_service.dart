import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/product.dart';
import '../models/product_image.dart';

class ProductService {
  final String baseUrl = dotenv.env['API_URL'] ?? '';

  Future<List<Product>> getProducts() async {
    try {
      // Fetch products
      final productsResponse = await http.get(
        Uri.parse('$baseUrl/products'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (productsResponse.statusCode != 200) {
        throw Exception(
            'Failed to load products: ${productsResponse.statusCode}');
      }

      // Fetch product images
      final imagesResponse = await http.get(
        Uri.parse('$baseUrl/product_images'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (imagesResponse.statusCode != 200) {
        throw Exception(
            'Failed to load product images: ${imagesResponse.statusCode}');
      }

      // Parse products and images
      final List<dynamic> productsData = json.decode(productsResponse.body);
      final List<dynamic> imagesData = json.decode(imagesResponse.body);

      // Create a map of product_id to ProductImage for quick lookup
      final Map<String, ProductImage> imageMap = {
        for (var imageJson in imagesData)
          imageJson['product_id'].toString(): ProductImage.fromJson(imageJson)
      };

      // Create products and link their images
      return productsData.map((json) {
        final product = Product.fromJson(json);
        product.image = imageMap[product.productId];
        return product;
      }).toList();
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  Future<Product> getProductById(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final product = Product.fromJson(data);

        // Fetch product image
        final imageResponse = await http.get(
          Uri.parse('$baseUrl/product_images?product_id=${product.productId}'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        );

        if (imageResponse.statusCode == 200) {
          final List<dynamic> imagesData = json.decode(imageResponse.body);
          if (imagesData.isNotEmpty) {
            product.image = ProductImage.fromJson(imagesData.first);
          }
        }

        return product;
      } else {
        throw Exception('Failed to load product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching product: $e');
    }
  }

  Future<List<Product>> getProductsByCategory(int categoryId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products?category_id=$categoryId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final products = data.map((json) => Product.fromJson(json)).toList();

        // Fetch all product images in one request
        final productIds = products.map((p) => p.productId).join(',');
        final imagesResponse = await http.get(
          Uri.parse('$baseUrl/product_images?product_id=$productIds'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        );

        if (imagesResponse.statusCode == 200) {
          final List<dynamic> imagesData = json.decode(imagesResponse.body);
          final imageMap = {
            for (var imageJson in imagesData)
              imageJson['product_id'].toString():
                  ProductImage.fromJson(imageJson)
          };

          // Link images to products
          for (var product in products) {
            product.image = imageMap[product.productId];
          }
        }

        return products;
      } else {
        throw Exception(
            'Failed to load products by category: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching products by category: $e');
    }
  }

  Future<List<Product>> searchProducts(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products?search=$query'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final products = data.map((json) => Product.fromJson(json)).toList();

        // Fetch images for search results
        final productIds = products.map((p) => p.productId).join(',');
        final imagesResponse = await http.get(
          Uri.parse('$baseUrl/product_images?product_id=$productIds'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        );

        if (imagesResponse.statusCode == 200) {
          final List<dynamic> imagesData = json.decode(imagesResponse.body);
          final imageMap = {
            for (var imageJson in imagesData)
              imageJson['product_id'].toString():
                  ProductImage.fromJson(imageJson)
          };

          // Link images to products
          for (var product in products) {
            product.image = imageMap[product.productId];
          }
        }

        return products;
      } else {
        throw Exception('Failed to search products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error searching products: $e');
    }
  }
}

import '../models/product.dart';
import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final IconData icon;

  Category({
    required this.id,
    required this.name,
    required this.icon,
  });
}

final List<Category> demoCategories = [
  Category(id: '1', name: 'Electronics', icon: Icons.devices),
  Category(id: '2', name: 'Vehicles', icon: Icons.directions_car),
  Category(id: '3', name: 'Lands', icon: Icons.landscape),
  Category(id: '4', name: 'Home', icon: Icons.home),
  Category(id: '5', name: 'Pets', icon: Icons.pets),
];

final List<Product> demoProducts = [
  Product(
    id: '1',
    title: 'Cat for Sale',
    description: 'Autumn And Winter Casual',
    price: 499,
    imageUrl: 'assets/images/cat.jpg',
    rating: 4.5,
    reviews: 1234,
    category: 'Pets',
    isFavorite: true,
  ),
  Product(
    id: '2',
    title: 'Gaming PC',
    description: 'High-end gaming computer setup',
    price: 399,
    imageUrl: 'assets/images/gaming_pc.jpg',
    rating: 4.8,
    reviews: 120,
    category: 'Electronics',
    isFavorite: false,
  ),
  Product(
    id: '3',
    title: 'iPhone',
    description: 'Latest iPhone model',
    price: 2000,
    imageUrl: 'assets/images/iphone.jpg',
    rating: 4.7,
    reviews: 2345,
    category: 'Electronics',
    isFavorite: true,
  ),
  Product(
    id: '4',
    title: 'Puppy For Sale',
    description: 'EARTHEN Rose Pink',
    price: 1900,
    imageUrl: 'assets/images/puppy.jpg',
    rating: 4.9,
    reviews: 567,
    category: 'Pets',
    isFavorite: false,
  ),
  Product(
    id: '5',
    title: 'Flare Dress',
    description: 'Anthea Black & Rust Orange Floral Print',
    price: 1990,
    imageUrl: 'assets/images/dress.jpg',
    rating: 4.6,
    reviews: 345,
    category: 'Fashion',
    isFavorite: true,
  ),
  Product(
    id: '6',
    title: 'SUV Car',
    description: 'Latest model with all features',
    price: 999999,
    imageUrl: 'assets/images/car.jpg',
    rating: 4.8,
    reviews: 77,
    category: 'Vehicles',
    isFavorite: false,
  ),
  Product(
    id: '7',
    title: 'Jordan Stay',
    description: 'The classic Air Jordan 12',
    price: 6999,
    imageUrl: 'assets/images/jordan.jpg',
    rating: 4.5,
    reviews: 522,
    category: 'Fashion',
    isFavorite: true,
  ),
  Product(
    id: '8',
    title: 'Realme 7',
    description: '6 GB RAM | 64 GB ROM',
    price: 3499,
    imageUrl: 'assets/images/realme.jpg',
    rating: 4.4,
    reviews: 2067,
    category: 'Electronics',
    isFavorite: false,
  ),
  Product(
    id: '9',
    title: 'Sony PS4',
    description: 'Sony PS4 Console 1TB Slim with 3 Games',
    price: 1999,
    imageUrl: 'assets/images/ps4.jpg',
    rating: 4.7,
    reviews: 1099,
    category: 'Electronics',
    isFavorite: true,
  ),
  Product(
    id: '10',
    title: 'Black Jacket',
    description: 'Warm and comfortable winter jacket',
    price: 2999,
    imageUrl: 'assets/images/jacket.jpg',
    rating: 4.3,
    reviews: 245,
    category: 'Fashion',
    isFavorite: false,
  ),
];

final List<String> demoBanners = [
  'assets/images/banner1.jpg',
  'assets/images/banner2.jpg',
  'assets/images/banner3.jpg',
];

final Map<String, dynamic> demoDeals = {
  'title': 'Deal of the Day',
  'timeRemaining': '22h 55m 20s',
  'products': [
    {
      'title': 'House for sale',
      'price': 1500,
      'rating': 4.5,
      'reviews': 234,
      'imageUrl': 'assets/images/house.jpg',
    },
    {
      'title': 'HRX by Hrithik Roshan',
      'price': 2499,
      'rating': 4.3,
      'reviews': 567,
      'imageUrl': 'assets/images/hrx.jpg',
    },
  ],
};

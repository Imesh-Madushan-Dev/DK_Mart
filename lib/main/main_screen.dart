import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../constants/colors.dart';
import 'cart_screen.dart';
import 'home_screen.dart';
import 'search_screen.dart';
import 'settings_screen.dart';
import 'wishlist_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  final List _pages = [
    const HomeScreen(),
    const WishlistScreen(),
    const CartScreen(),
    const SearchScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: SalomonBottomBar(
            currentIndex: currentIndex,
            onTap: (index) => setState(() => currentIndex = index),
            selectedItemColor: AppColors.primary,
            unselectedItemColor: Colors.grey,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            items: [
              SalomonBottomBarItem(
                icon: const Icon(Icons.home_outlined),
                activeIcon: const Icon(Icons.home),
                title: const Text('Home'),
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.favorite_outline),
                activeIcon: const Icon(Icons.favorite),
                title: const Text('Wishlist'),
              ),
              SalomonBottomBarItem(
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  size: 30,
                  color: AppColors.primary,
                ),
                activeIcon: const Icon(
                  Icons.shopping_cart,
                  size: 30,
                ),
                title: const Text('Cart'),
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.search_outlined),
                activeIcon: const Icon(Icons.search),
                title: const Text('Search'),
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.settings_outlined),
                activeIcon: const Icon(Icons.settings),
                title: const Text('Setting'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

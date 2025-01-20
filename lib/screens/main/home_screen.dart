import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../services/product_service.dart';
import '../../models/category.dart';
import '../../models/product.dart';
import '../../widgets/product_card.dart';
import '../../widgets/category_item.dart';
import '../../constants/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductService _productService = ProductService();
  List<Product> _products = [];
  List<Product> _dealOfDayProducts = [];
  List<Product> _specialOfferProducts = [];
  bool _isLoading = true;
  String? _error;
  int currentBannerIndex = 0;

  final List<String> bannerImages = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_dVoeTHjx1vMCVwPYayNCh9GiZQvdyBA-szm6UGbfFY4hItArMk01vH-LZOVrksDmkJw&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_dVoeTHjx1vMCVwPYayNCh9GiZQvdyBA-szm6UGbfFY4hItArMk01vH-LZOVrksDmkJw&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_dVoeTHjx1vMCVwPYayNCh9GiZQvdyBA-szm6UGbfFY4hItArMk01vH-LZOVrksDmkJw&usqp=CAU',
  ];

  final List<Category> categories = [
    Category(id: 17, name: 'Electronics', icon: Icons.devices),
    Category(id: 18, name: 'Fashion', icon: Icons.shopping_bag),
    Category(id: 19, name: 'Home', icon: Icons.home),
    Category(id: 20, name: 'Beauty', icon: Icons.face),
    Category(id: 21, name: 'Sports', icon: Icons.sports_soccer),
  ];

  int selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final products = await _productService.getProducts();

      // Filter products for different sections
      setState(() {
        _products = products;
        _dealOfDayProducts =
            products.take(5).toList(); // First 5 products for deals
        _specialOfferProducts =
            products.skip(5).take(5).toList(); // Next 5 for special offers
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load products: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _error!,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadData,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadData,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildAppBar(),
                        _buildCategories(),
                        _buildBannerSlider(),
                        _buildDealOfTheDay(),
                        _buildSpecialOffers(),
                        _buildTrendingProducts(),
                        _buildNewArrivals(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryBlue,
      ),
      child: Column(
        children: [
          SizedBox(height: 35),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/navbar-logo-new.png',
                  height: 35,
                ),
                const Spacer(),
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/images/avt.png'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search any Product...',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey[400]),
                      ),
                      onSubmitted: (value) async {
                        if (value.isNotEmpty) {
                          try {
                            final results =
                                await _productService.searchProducts(value);
                            setState(() {
                              _products = results;
                            });
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text('Error searching products: $e')),
                            );
                          }
                        }
                      },
                    ),
                  ),
                  const Icon(Icons.mic, color: Colors.grey),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'All Featured',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 20),
                child: CategoryItem(
                  category: categories[index],
                  isSelected: selectedCategoryIndex == index,
                  onTap: () async {
                    setState(() => selectedCategoryIndex = index);
                    try {
                      final products = await _productService
                          .getProductsByCategory(categories[index].id);
                      setState(() {
                        _products = products;
                      });
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error loading category: $e')),
                      );
                    }
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBannerSlider() {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 180,
            viewportFraction: 0.9,
            enlargeCenterPage: true,
            autoPlay: true,
            onPageChanged: (index, reason) {
              setState(() => currentBannerIndex = index);
            },
          ),
          items: bannerImages.map((banner) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(banner),
                  fit: BoxFit.cover,
                ),
              ),
            );
          }).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: bannerImages.asMap().entries.map((entry) {
            return Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: currentBannerIndex == entry.key
                    ? AppColors.primary
                    : Colors.grey[300],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDealOfTheDay() {
    if (_dealOfDayProducts.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Deal of the Day',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.timer, color: Colors.red, size: 16),
                    SizedBox(width: 4),
                    Text(
                      '23:59:59',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _dealOfDayProducts.length,
            itemBuilder: (context, index) {
              return Container(
                width: 200,
                margin: const EdgeInsets.only(right: 16),
                child: ProductCard(
                  product: _dealOfDayProducts[index],
                  onTap: () {
                    // TODO: Navigate to product details
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSpecialOffers() {
    if (_specialOfferProducts.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Special Offers',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 280, // Adjust height as needed
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _specialOfferProducts.length,
            itemBuilder: (context, index) {
              return Container(
                width: 200, // Adjust width as needed
                margin: const EdgeInsets.only(right: 16),
                child: ProductCard(
                  product: _specialOfferProducts[index],
                  onTap: () {
                    // TODO: Navigate to product details
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTrendingProducts() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Trending Products',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('View all'),
              ),
            ],
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            return ProductCard(
              product: _products[index],
              onTap: () {},
            );
          },
        ),
      ],
    );
  }

  Widget _buildNewArrivals() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'New Arrivals',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('View all'),
              ),
            ],
          ),
        ),
        Container(
          height: 150,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              Row(
                children: [
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Summer'25 Collections",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Get up to 30% off on new arrivals',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Image.asset(
                    'assets/images/summer_sale.png',
                    height: 120,
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

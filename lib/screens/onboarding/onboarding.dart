import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/colors.dart';
import '../../routes/routes.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      'title': 'DISCOVER THE BEST',
      'description':
          'From gadgets to groceries, everything you need in one place!',
      'image': 'assets/images/A.png',
    },
    {
      'title': 'UNBEATABLE STYLES ESSENTIAL SUPPLIES',
      'description': 'All you need, right at your fingertips.',
      'image': 'assets/images/B.png',
    },
    {
      'title': 'SHOP SMART, SAVE BIG',
      'description': 'Your journey to smarter shopping starts here.',
      'image': 'assets/images/C.png',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_currentPage + 1}/3',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, AppRoutes.login);
                    },
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        _onboardingData[index]['image']!,
                        height: MediaQuery.of(context).size.height * 0.4,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 40),
                      Text(
                        _onboardingData[index]['title']!,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.staatliches(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: index == 0
                              ? const Color(0xffFF5E43)
                              : index == 1
                                  ? const Color(0xff2C63FF)
                                  : const Color(0xffAF2401),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          _onboardingData[index]['description']!,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.staatliches(
                            fontSize: 18,
                            color: const Color(0xff37474F),
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Dots indicator
                  Row(
                    children: List.generate(
                      _onboardingData.length,
                      (index) => Container(
                        margin: const EdgeInsets.only(right: 8),
                        height: 8,
                        width: _currentPage == index ? 24 : 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? AppColors.primary
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  // Next/Get Started button
                  TextButton(
                    onPressed: () {
                      if (_currentPage == _onboardingData.length - 1) {
                        Navigator.pushReplacementNamed(
                            context, AppRoutes.login);
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Text(
                      _currentPage == _onboardingData.length - 1
                          ? 'Get Started'
                          : 'Next',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../routes/routes.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: PageView(
          controller: _pageController,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 10, right: 15, left: 15),
              child: Stack(
                children: [
                  Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 100,
                      ),
                      Image.asset(
                        'assets/images/A.png',
                        height: 250,
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      const Text(
                        'DISCOVER THE BEST',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Staatliches',
                          fontSize: 40,
                          color: Color(0xffff773d),
                        ),
                      ),
                      const Text(
                        'From gadgets to groceries, everything you need in one place!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Staatliches',
                          fontSize: 20,
                          color: Color(0xff37474F),
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: TextButton(
                      onPressed: () {
                        _pageController.jumpToPage(2);
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.grey,
                      ),
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          fontFamily: 'Staatliches',
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: TextButton(
                      onPressed: () {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.grey,
                      ),
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          fontFamily: 'Staatliches',
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 10, right: 15, left: 15),
              child: Stack(children: [
                Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 100,
                    ),
                    Image.asset(
                      'assets/images/B.png',
                      height: 250,
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    const Text(
                      'UNBEATABLE STYLES ESSENTIAL SUPPLIES',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Staatliches',
                        fontSize: 40,
                        height: 1,
                        color: Color(0xff2C63FF),
                      ),
                    ),
                    const Text(
                      'All you need, right at your fingertips.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Staatliches',
                        fontSize: 20,
                        height: 2.3,
                        color: Color(0xff37474F),
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: -5,
                  child: TextButton(
                    onPressed: () {
                      _pageController.jumpToPage(2);
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.grey,
                    ),
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        fontFamily: 'Staatliches',
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: -5,
                  child: TextButton(
                    onPressed: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.grey,
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        fontFamily: 'Staatliches',
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 100,
                  ),
                  Image.asset(
                    'assets/images/C.png',
                    height: 250,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  const Text(
                    'SHOP SMART, SAVE BIG',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Staatliches',
                      fontSize: 40,
                      color: Color(0xffAF2401),
                    ),
                  ),
                  const Text(
                    'Your journey to smarter shopping starts here.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Staatliches',
                      fontSize: 20,
                      color: Color(0xff37474F),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Navigator.pushAndRemoveUntil(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const Authentication()),
                      //   (Route<dynamic> route) => false,
                      // );
                      Navigator.pushNamed(context, AppRoutes.authentication);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffff773d),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        fontFamily: 'Staatliches',
                        fontSize: 28,
                        color: Colors.white,
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

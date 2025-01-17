import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../components/socialButtons.dart';
import '../../constants/colors.dart';
import '../../routes/routes.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<Authentication> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: screenHeight / 2.5,
              width: screenHeight,
              decoration: BoxDecoration(
                color: const Color(0xffFAFAFA),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(5, 0),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  const Positioned(
                    top: 40,
                    left: 0,
                    right: 0,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Wel',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: 'Come',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffFF5E43),
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Positioned(
                    top: 90,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Image.asset(
                        'assets/images/D.png',
                        fit: BoxFit.contain,
                        height: screenHeight / 5,
                        width: screenHeight / 5,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 250,
                    left: 0,
                    right: 0,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: _currentPage == 0
                                ? 'Signup with '
                                : 'Login with ',
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const TextSpan(
                            text: 'DK - Mart !',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffFF5E43),
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Opacity(
                opacity: 1,
                child: ElevatedButton(
                  onPressed: () {
                    _pageController.animateToPage(
                      0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.transparent,
                    backgroundColor: _currentPage == 0
                        ? const Color(0xffFF5E43)
                        : const Color(0x00FF5E43), // Button background color
                    foregroundColor: Colors.transparent, // Text color
                    elevation: 0,
                    fixedSize: const Size(150, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    "Signup",
                    style: TextStyle(
                        fontSize: 18,
                        color: _currentPage == 1 ? Colors.grey : Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              Opacity(
                opacity: 1,
                child: ElevatedButton(
                  onPressed: () {
                    _pageController.animateToPage(
                      1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.transparent,
                    backgroundColor: _currentPage == 1
                        ? const Color(0xffFF5E43)
                        : const Color(0x00FF5E43),
                    // Button background color
                    foregroundColor: Colors.transparent, // Text color
                    elevation: 0,
                    fixedSize: const Size(150, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 18,
                        color: _currentPage == 0 ? Colors.grey : Colors.white),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: const [
                SignupForm(),
                LoginForm(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//!------------------------  Forms Here -----------------------------

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  bool _obscureText = true;
  Timer? _shimmerTimer;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _shimmerTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _shimmerTimer?.cancel();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _addressController.dispose();
    _dobController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your email";
    }
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return "Please enter a valid email address";
    }
    return null;
  }

  String? nonEmptyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "This field cannot be empty";
    }
    return null;
  }

  Widget _buildTextField({
    required String labelText,
    required IconData prefixIcon,
    bool isPassword = false,
    required TextEditingController controller,
    FormFieldValidator<String>? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword && _obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(prefixIcon, color: Colors.grey),
        labelStyle: TextStyle(color: Colors.grey),
        border: const UnderlineInputBorder(),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2.0),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.5),
        ),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
      validator: validator,
    );
  }

  Widget _buildDatePickerTextField({
    required String labelText,
    required IconData prefixIcon,
    required TextEditingController controller,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(prefixIcon, color: Colors.grey),
        labelStyle: TextStyle(color: Colors.grey),
        border: const UnderlineInputBorder(),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2.0),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.5),
        ),
      ),
      readOnly: true,
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );

        if (picked != null) {
          setState(() {
            controller.text = "${picked.toLocal()}"
                .split(' ')[0]; // Format date as yyyy-mm-dd
          });
        }
      },
    );
  }

  void _handleSignup() async {
    // Navigate to home without form validation
    Navigator.pushNamed(context, '/home');

    // If you want to handle registration, you can uncomment this part
    /*
    if (_formKey.currentState?.validate() ?? false) {
      final user = User(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        address: _addressController.text,
        dob: _dobController.text,
        phone: _phoneController.text,
      );

      final authService = AuthService();

      try {
        bool success = await authService.registerUser(user);

        if (success) {
          Navigator.pushNamed(context, '/home');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Registration failed. Please try again.')),
          );
        }
      } catch (e) {
        print("Error during registration: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('An error occurred. Please try again.')),
        );
      }
    }
    */
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildTextField(
              labelText: "Name",
              prefixIcon: Icons.person,
              controller: _nameController,
              validator: nonEmptyValidator,
            ),
            const SizedBox(height: 10),
            _buildTextField(
              labelText: "Email",
              prefixIcon: Icons.email,
              controller: _emailController,
              validator: emailValidator,
            ),
            const SizedBox(height: 10),
            _buildTextField(
              labelText: "Password",
              prefixIcon: Icons.lock,
              isPassword: true,
              controller: _passwordController,
              validator: nonEmptyValidator,
            ),
            const SizedBox(height: 10),
            _buildTextField(
              labelText: "Address",
              prefixIcon: Icons.home,
              controller: _addressController,
              validator: nonEmptyValidator,
            ),
            const SizedBox(height: 10),
            _buildDatePickerTextField(
              labelText: "Date of Birth",
              prefixIcon: Icons.calendar_today,
              controller: _dobController,
            ),
            const SizedBox(height: 10),
            _buildTextField(
              labelText: "Phone",
              prefixIcon: Icons.phone,
              controller: _phoneController,
              validator: nonEmptyValidator,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _handleSignup,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 2,
                fixedSize: const Size(150, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Signup", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _obscureText = true;
  bool _isShimmering = true;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      setState(() {
        _isShimmering = false; // Stop shimmer effect
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Email",
              prefixIcon: Icon(Icons.email, color: AppColors.darkGrey),
              labelStyle: TextStyle(
                color: AppColors.darkGrey,
              ),
              border: UnderlineInputBorder(),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.darkGrey,
                  width: 2.0,
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.darkGrey,
                  width: 1.5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            obscureText: _obscureText, // Toggles password visibility
            decoration: InputDecoration(
              labelText: "Password",
              labelStyle: const TextStyle(
                color: AppColors.darkGrey,
              ),
              prefixIcon: const Icon(
                Icons.lock,
                color: AppColors.darkGrey,
              ),
              border: const UnderlineInputBorder(),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.darkGrey,
                  width: 2.0,
                ),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.darkGrey,
                  width: 1.5,
                ),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.darkGrey,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText; // Toggle visibility state
                  });
                },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  print("Forgot Password clicked!");
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 20.0,
                  ), // Button padding
                ),
                child: const Text(
                  "Forgot Password ?",
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.darkGrey,
                  ),
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              // Add login logic here
              Navigator.pushNamed(context, AppRoutes.mainPage);
              print("Login Button Clicked");
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 2,
              fixedSize: const Size(150, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: const Text(
              "Login",
              style: TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text('Or Login With'),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // Center align buttons
            children: [
              Flexible(
                child: _isShimmering
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.white,
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      )
                    : SocialButtons.facebookButton(() {
                        print('Facebook button pressed');
                      }),
              ),
              const SizedBox(width: 10), // Add spacing between buttons
              Flexible(
                child: _isShimmering
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.white,
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      )
                    : SocialButtons.googleButton(() {
                        print('Google button pressed');
                      }),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: _isShimmering
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.white,
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      )
                    : SocialButtons.tiktokButton(() {
                        print('TikTok button pressed');
                      }),
              ),
            ],
          )
        ],
      ),
    );
  }
}

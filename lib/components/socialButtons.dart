import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final Color color;
  final String logoPath;
  final String label;
  final VoidCallback onPressed;

  const SocialButton({
    super.key,
    required this.color,
    required this.logoPath,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Rounded button
        ),
        elevation: 0,
        padding: const EdgeInsets.only(),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            logoPath,
            height: 80,
            width: 80,
          ),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

// Example usage for specific buttons
class SocialButtons {
  static Widget facebookButton(VoidCallback onPressed) {
    return SocialButton(
      color: const Color(0x001877F2),
      logoPath: 'assets/images/social_logo/Facebook.png',
      onPressed: onPressed,
      label: '',
    );
  }

  static Widget googleButton(VoidCallback onPressed) {
    return SocialButton(
      color: const Color(0x00DB4437),
      logoPath:
          'assets/images/social_logo/Google.png', // Ensure this asset exists
      label: '',
      onPressed: onPressed,
    );
  }

  static Widget tiktokButton(VoidCallback onPressed) {
    return SocialButton(
      color: const Color(0x00010101),
      logoPath:
          'assets/images/social_logo/Tiktok.png', // Ensure this asset exists
      label: '',
      onPressed: onPressed,
    );
  }
}

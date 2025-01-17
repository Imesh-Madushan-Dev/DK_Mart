import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class SocialButtons {
  static Widget facebookButton(VoidCallback onPressed) {
    return _socialButton(
      onPressed: onPressed,
      icon: Brand(Brands.facebook),
    );
  }

  static Widget googleButton(VoidCallback onPressed) {
    return _socialButton(
      onPressed: onPressed,
      icon: Brand(Brands.google),
    );
  }

  static Widget tiktokButton(VoidCallback onPressed) {
    return _socialButton(
      onPressed: onPressed,
      icon: Brand(Brands.tiktok),
    );
  }

  static Widget _socialButton({
    required VoidCallback onPressed,
    required Widget icon,
  }) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 0,
        ),
        child: Center(child: icon),
      ),
    );
  }
}

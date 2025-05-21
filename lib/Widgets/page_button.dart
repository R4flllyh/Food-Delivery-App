import 'package:flutter/material.dart';
import 'package:food_delivery/core/utils/consts.dart';

class PageButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  final Color? color;
  const PageButton({
    super.key,
    required this.buttonText,
    required this.onTap,
    this.color = red,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      ),
      onPressed: onTap,
      child: Text(
        buttonText,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}

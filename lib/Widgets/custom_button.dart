import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final bool loading;
  final String text;
  final VoidCallback onPressed;
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.purple,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
      child: loading == true
          ? const Center(
              child: CircularProgressIndicator(color: Colors.white),
            )
          : Text(text, style: const TextStyle(fontSize: 16)),
    );
  }
}

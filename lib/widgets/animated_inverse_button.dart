import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';

class AnimatedInverseButton extends StatefulWidget {
  final VoidCallback onPressed; //
  final String text; //

  const AnimatedInverseButton({
    super.key,
    required this.onPressed,
    this.text = 'Login',
  });

  @override
  State<AnimatedInverseButton> createState() => _AnimatedInverseButtonState();
}

class _AnimatedInverseButtonState extends State<AnimatedInverseButton> {
  bool _isPressed = false; //

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true), //
      onTapUp: (_) => setState(() => _isPressed = false), //
      onTapCancel: () => setState(() => _isPressed = false), //
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200), //
        width: 170,
        height: 45,
        decoration: BoxDecoration(
          color: _isPressed ? AppColors.whiteColor : AppColors.customRed, //
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColors.customRed, width: 2), //
        ),
        alignment: Alignment.center,
        child: Text(
          widget.text,
          style: GoogleFonts.roboto(
            color: _isPressed ? AppColors.customRed : AppColors.whiteColor, //
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
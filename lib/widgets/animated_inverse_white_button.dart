import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';

class AnimatedInverseWhiteButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final double? width;
  final double? height;

  const AnimatedInverseWhiteButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.width,
    this.height,
  });

  @override
  State<AnimatedInverseWhiteButton> createState() =>
      _AnimatedInverseWhiteButtonState();
}

class _AnimatedInverseWhiteButtonState
    extends State<AnimatedInverseWhiteButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final buttonWidth = widget.width ?? screenWidth * 0.35;
    final buttonHeight = widget.height ?? 45;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: buttonWidth,
        height: buttonHeight,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _isPressed
              ? AppColors.customColorRed
              : AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.customColorRed,
            width: 2,
          ),
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 180),
          style: GoogleFonts.roboto(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: _isPressed
                ? Colors.white
                : AppColors.customColorRed,
          ),
          child: Text(widget.text),
        ),
      ),
    );
  }
}
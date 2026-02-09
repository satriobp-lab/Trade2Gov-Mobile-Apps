import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppBox {
  static BoxDecoration primary() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),

      // BORDER UTAMA (20% DC3129, weight 2)
      border: Border.all(
        color: AppColors.customColorRed.withOpacity(0.2),
        width: 2,
      ),

      // SHADOW HALUS (enterprise look)
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 6,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  static BoxDecoration menu() {
    return primary().copyWith(
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.06),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }

  static BoxDecoration menuActive() {
    return BoxDecoration(
      color: AppColors.customColorRed,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: AppColors.customColorRed,
        width: 2,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.12),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}

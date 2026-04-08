import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';
import 'edec_loader.dart';

class NetworkEdecStateWidget extends StatelessWidget {
  final bool isLoading;
  final bool isNoInternet;
  final Widget child;
  final VoidCallback onRetry;
  final String loadingText;

  const NetworkEdecStateWidget({
    super.key,
    required this.isLoading,
    required this.isNoInternet,
    required this.child,
    required this.onRetry,
    this.loadingText = "Loading...",
  });

  @override
  Widget build(BuildContext context) {

    /// LOADING
    if (isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const EdecLoader(),
            const SizedBox(height: 12),
            Text(
              loadingText,
              style: GoogleFonts.lato(
                color: AppColors.customColorRed,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }

    /// NO INTERNET
    if (isNoInternet) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(
              Icons.wifi_off,
              size: 70,
              color: AppColors.customColorRed,
            ),

            const SizedBox(height: 15),

            Text(
              "No Internet Connection",
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.customColorGray,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "Please check your internet connection",
              style: GoogleFonts.lato(
                fontSize: 14,
                color: AppColors.customColorGray.withOpacity(0.7),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 0,
                side: const BorderSide(color: AppColors.customColorRed),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Retry",
                style: GoogleFonts.roboto(
                  color: AppColors.customColorRed,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      );
    }

    /// SUCCESS STATE
    return child;
  }
}
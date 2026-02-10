import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/app_colors.dart';
import '../login/login_page.dart';
import '../../widgets/animated_inverse_button.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor, //
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0), //
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(30 * (1 - value), 0), //
                  child: child,
                ),
              );
            },
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome to,',
                    style: GoogleFonts.montserrat(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.customColorRedLoginOnly,
                    ),
                  ), //
                  const SizedBox(height: 10),
                  Image.asset('assets/images/t2g-logo.png', width: 350), //
                  const SizedBox(height: 10),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: GoogleFonts.robotoSerif(fontSize: 14),
                      children: const [
                        TextSpan(text: 'Integrated Soluti', style: TextStyle(color: AppColors.customColorRedLoginOnly)),
                        TextSpan(text: 'ons for Seam', style: TextStyle(color: AppColors.customColorGray)),
                        TextSpan(text: 'less Trade to Government', style: TextStyle(color: AppColors.customColorRedLoginOnly)),
                      ],
                    ),
                  ), //
                  const SizedBox(height: 30),
                  // Menggunakan widget kustom untuk konsistensi animasi
                  AnimatedInverseButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';
import '../widgets/animated_inverse_button.dart';
import '../main_navigation.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(30 * (1 - value), 0),
                          child: child,
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome to,',
                          style: GoogleFonts.montserrat(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.customColorRedLoginOnly,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Image.asset('assets/images/t2g-logo.png', width: 350),
                        const SizedBox(height: 10),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: GoogleFonts.robotoSerif(fontSize: 14),
                            children: const [
                              TextSpan(
                                text: 'Integrated Soluti',
                                style: TextStyle(color: AppColors.customColorRedLoginOnly),
                              ),
                              TextSpan(
                                text: 'ons for Seam',
                                style: TextStyle(color: AppColors.customColorGray),
                              ),
                              TextSpan(
                                text: 'less Trade to Government',
                                style: TextStyle(color: AppColors.customColorRedLoginOnly),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(25),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFDF7F4),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: AppColors.customColorRedLoginOnly.withOpacity(0.2),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 20,
                                spreadRadius: 2,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              _buildTextField("Masukkan Username atau Email Anda"),
                              const SizedBox(height: 15),
                              _buildTextField("Masukkan Password Anda", isPassword: true),
                              const SizedBox(height: 30),
                              AnimatedInverseButton(
                                text: "Login",
                                onPressed: () {
                                  // PERBAIKAN: Navigasi ke MainNavigation agar Bottom Nav muncul
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => const MainNavigation()),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, {bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      cursorColor: AppColors.customColorRedLoginOnly,
      style: GoogleFonts.roboto(
        color: AppColors.customColorRedLoginOnly,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.roboto(
          color: AppColors.customColorRedLoginOnly.withOpacity(0.4),
          fontSize: 13,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColors.customColorRedLoginOnly.withOpacity(0.2),
            width: 1.2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColors.customColorRedLoginOnly.withOpacity(0.2),
            width: 1.2,
          ),
        ),
      ),
    );
  }
}
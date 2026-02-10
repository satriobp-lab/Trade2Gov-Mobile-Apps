import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';

import '../../utils/app_colors.dart';
import '../../widgets/animated_inverse_button.dart';
import '../../main_navigation.dart';
import '../../data/controllers/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  bool _obscurePassword = true;

  Future<void> _handleLogin() async {
    setState(() => _isLoading = true);

    await LoginController.login(
      context,
      onFinish: () {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      },
    );
  }

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
                              TextSpan(text: 'Integrated Soluti', style: TextStyle(color: AppColors.customColorRedLoginOnly)),
                              TextSpan(text: 'ons for Seam', style: TextStyle(color: AppColors.customColorGray)),
                              TextSpan(text: 'less Trade to Government', style: TextStyle(color: AppColors.customColorRedLoginOnly)),
                            ],
                          ),
                        ), //
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
                              _buildTextField(
                                "Masukkan Username atau Email Anda",
                                controller: LoginController.emailController,
                              ),
                              const SizedBox(height: 15),
                              _buildPasswordField(),
                              const SizedBox(height: 30),

                              /// LOGIN BUTTON + LOADING
                              _isLoading
                                  ? const CupertinoActivityIndicator(
                                radius: 14,
                                color: AppColors.customColorRed,
                              )
                                  : AnimatedInverseButton(
                                text: "Login",
                                onPressed: _handleLogin,
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

  Widget _buildTextField(
      String hint, {
        TextEditingController? controller,
      }) {
    return TextField(
      controller: controller,
      cursorColor: AppColors.customColorRedLoginOnly,
      style: GoogleFonts.roboto(
        color: AppColors.customColorRedLoginOnly,
        fontSize: 14,
      ),
      decoration: _inputDecoration(hint),
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      controller: LoginController.passwordController,
      obscureText: _obscurePassword,
      cursorColor: AppColors.customColorRedLoginOnly,
      style: GoogleFonts.roboto(
        color: AppColors.customColorRedLoginOnly,
        fontSize: 14,
      ),
      decoration: _inputDecoration("Masukkan Password Anda").copyWith(
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off : Icons.visibility,
            color: AppColors.customColorRedLoginOnly.withOpacity(0.6),
          ),
          onPressed: () {
            setState(() => _obscurePassword = !_obscurePassword);
          },
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
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
    );
  }
}

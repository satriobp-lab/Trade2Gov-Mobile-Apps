import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/app_colors.dart';
import '../repositories/auth_repository.dart';
import '../../main_navigation.dart';
import '../../ui/splash/app_loader_page.dart';

class LoginController {
  static final emailController = TextEditingController();
  static final passwordController = TextEditingController();

  static final AuthRepository _authRepository = AuthRepository();

  static Future<void> login(
      BuildContext context, {
        required VoidCallback onFinish,
      }) async {
    try {
      final user = await _authRepository.login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Welcome in Trade2Gov mobile app, ${user.nama}!',
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: AppColors.customColorRed,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(10),
        ),
      );

      await Future.delayed(const Duration(milliseconds: 600));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const AppLoaderPage(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      onFinish();
    }
  }
}

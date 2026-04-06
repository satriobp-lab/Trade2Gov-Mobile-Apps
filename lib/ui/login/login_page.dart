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

    // VALIDASI SEBELUM CALL API
    if (LoginController.emailController.text.trim().isEmpty ||
        LoginController.passwordController.text.trim().isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Email dan password harus diisi terlebih dahulu.",
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(10),
        ),
      );

      return;
    }

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
      body: Stack(
        children: [
          // 1. Background Waves di layer paling belakang
          const Positioned.fill(
            child: BackgroundWaves(),
          ),

          // 2. Konten Utama (Login Form)
          SafeArea(
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
                                  _buildTextField(
                                    "Masukkan Username atau Email Anda",
                                    controller: LoginController.emailController,
                                  ),
                                  const SizedBox(height: 15),
                                  _buildPasswordField(),
                                  const SizedBox(height: 30),
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
        ], // Penutup Stack
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

class BackgroundWaves extends StatelessWidget {
  const BackgroundWaves({super.key});

  @override
  Widget build(BuildContext context) {
    // Kita buat warna dasar dari AppColors Anda
    final baseColor = AppColors.customColorRedLoginOnly;

    return Stack(
      children: [
        // Lapisan 1: Paling Belakang & Paling Tinggi (Sampai ke tengah kotak)
        Positioned.fill(
          child: ClipPath(
            clipper: WaveClipper(280, 1.0), // Nilai 280-300 biasanya mencapai tengah layar
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    baseColor.withOpacity(0.25),
                    baseColor.withOpacity(0),
                  ],
                ),
              ),
            ),
          ),
        ),
        // Lapisan 2: Tengah
        Positioned.fill(
          child: ClipPath(
            clipper: WaveClipper(260, 0.9),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    baseColor.withOpacity(0.3),
                    baseColor.withOpacity(0),
                  ],
                ),
              ),
            ),
          ),
        ),
        // Lapisan 3: Paling Depan & Paling Rendah (Paling Pekat di bawah)
        Positioned.fill(
          child: ClipPath(
            clipper: WaveClipper(180, 1.1),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    baseColor.withOpacity(0.5),
                    baseColor.withOpacity(0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Logika untuk membuat bentuk gelombang
class WaveClipper extends CustomClipper<Path> {
  final double waveHeight;
  final double offset;

  WaveClipper(this.waveHeight, this.offset);

  @override
  Path getClip(Size size) {
    Path path = Path();

    // Mulai dari pojok bawah kiri
    path.moveTo(0, size.height);

    // Garis ke atas sesuai offset tinggi gelombang
    path.lineTo(0, size.height - (waveHeight * offset));

    // Gelombang pertama (naik)
    var firstControlPoint = Offset(size.width / 4, size.height - (waveHeight * offset) - 40);
    var firstEndPoint = Offset(size.width / 2, size.height - (waveHeight * offset));
    path.quadraticBezierTo(
        firstControlPoint.dx,
        firstControlPoint.dy,
        firstEndPoint.dx,
        firstEndPoint.dy
    );

    // Gelombang kedua (turun sedikit)
    var secondControlPoint = Offset(size.width * 3 / 4, size.height - (waveHeight * offset) + 40);
    var secondEndPoint = Offset(size.width, size.height - (waveHeight * offset) - 20);
    path.quadraticBezierTo(
        secondControlPoint.dx,
        secondControlPoint.dy,
        secondEndPoint.dx,
        secondEndPoint.dy
    );

    // Garis tutup ke pojok kanan bawah dan balik ke awal
    path.lineTo(size.width, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
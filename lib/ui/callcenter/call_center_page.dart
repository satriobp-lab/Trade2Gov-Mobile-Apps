import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/app_colors.dart';
import 'package:url_launcher/url_launcher.dart'; // ✅ TAMBAHAN
import '../../utils/app_box_decoration.dart';

class CallCenterPage extends StatefulWidget {
  const CallCenterPage({super.key});

  @override
  State<CallCenterPage> createState() => _CallCenterPageState();
}

class _CallCenterPageState extends State<CallCenterPage> {

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Call Center',
          style: GoogleFonts.lato(
            color: AppColors.customColorRed,
            fontWeight: FontWeight.bold,
            fontSize: width * 0.055, // responsive
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: AppColors.customColorRed.withOpacity(0.3),
            height: 1.0,
            margin: const EdgeInsets.symmetric(horizontal: 25),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        child: Column(
          children: [
            // Card Email
            _buildContactCard(
              context,
              title: 'Email',
              subtitle: 'Need help? Email us',
              imagePath: 'assets/images/gmail.png',
              onTap: () {
                _openEmail();
              },
            ),

            const SizedBox(height: 20),

            // Card WhatsApp
            _buildContactCard(
              context,
              title: 'WhatsApp',
              subtitle: 'Need help? WhatsApp us',
              imagePath: 'assets/images/wa.png',
              onTap: () {
                _openWhatsApp();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(
      BuildContext context, {
        required String title,
        required String subtitle,
        required String imagePath,
        required VoidCallback onTap,
      }) {
    return Container(
      decoration: AppBox.primary(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Row(
          children: [
            // Logo Icon
            Image.asset(
              imagePath,
              width: 45,
              height: 45,
              fit: BoxFit.contain,
              // Jika path error saat running, pastikan pubspec.yaml sudah benar
            ),

            const SizedBox(width: 15),

            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.customColorGray,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.roboto(
                      fontSize: 13,
                      color: AppColors.customColorGray.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),

            // Button Click Here
            ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.customColorRed,
                foregroundColor: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: Text(
                'Click Here',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =======================
// 🔗 OPEN EMAIL (GMAIL / EMAIL APP)
// =======================
  Future<void> _openEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'marketing@edi-indonesia.co.id',
      // optional:
      // query: 'subject=Need Help&body=Hello Team',
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Tidak bisa membuka email');
    }
  }

// =======================
// 💬 OPEN WHATSAPP
// =======================
  Future<void> _openWhatsApp() async {
    final String phone = '6282119933623'; // tanpa + dan spasi
    final Uri waUri = Uri.parse(
      'https://wa.me/$phone?text=Halo%20Saya%20butuh%20bantuan',
    );

    if (await canLaunchUrl(waUri)) {
      await launchUrl(waUri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Tidak bisa membuka WhatsApp');
    }
  }

}
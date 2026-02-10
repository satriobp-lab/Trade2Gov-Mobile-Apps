import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_box_decoration.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  // Inisialisasi index navigasi (biasanya 0 karena dibuka dari Home/Drawer)
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Jika user menekan item selain home, kita kembali ke MainNavigation
    // dan biarkan MainNavigation yang menangani perpindahan tab.
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            // Konten scrollable
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    // Judul Halaman
                    Text(
                      'About us',
                      style: GoogleFonts.lato(
                        color: AppColors.customColorRed,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Garis Divider Atas
                    Container(
                      height: 1.5,
                      width: double.infinity,
                      color: AppColors.customColorRed.withOpacity(0.5),
                    ),
                    const SizedBox(height: 30),

                    // Logo Pelindo (Tanpa Box)
                    Image.asset(
                      'assets/images/logo-pelindo.png',
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 30),

                    // Box Street Address
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: AppBox.primary(),
                      child: Column(
                        children: [
                          Text(
                            'Street Address',
                            style: GoogleFonts.roboto(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.customColorRed,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Divider Merah Tengah
                          Container(
                            height: 1.5,
                            width: 220,
                            color: AppColors.customColorRed,
                          ),
                          const SizedBox(height: 15),
                          Text(
                            'Wisma SMR Lt. 1 & 10, Jl. Yos Sudarso\nKav. 89, Sunter, Jakarta Utara 14350',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              fontSize: 13,
                              height: 1.4,
                              color: AppColors.customColorGray,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Box Gmail (Centered)
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        decoration: AppBox.primary(),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset('assets/images/gmail.png', width: 28, height: 28),
                            const SizedBox(width: 12),
                            Text(
                              'marketing@edi-indonesia.co.id',
                              style: GoogleFonts.roboto(
                                fontSize: 13,
                                color: AppColors.customColorGray,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Box WhatsApp (Centered)
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        decoration: AppBox.primary(),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset('assets/images/wa.png', width: 28, height: 28),
                            const SizedBox(width: 12),
                            Text(
                              '+62 821-1993-3623',
                              style: GoogleFonts.roboto(
                                fontSize: 13,
                                color: AppColors.customColorGray,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Section Version
                    Text(
                      'Version Mobile Apps',
                      style: GoogleFonts.robotoSerif(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.customColorRed,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: 140,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.customColorRed.withOpacity(0.15),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '1.0.0',
                        style: GoogleFonts.roboto(
                          color: AppColors.customColorRed.withOpacity(0.8),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Tombol Back di Kiri Bawah (Tetap di atas Bottom Navigation)
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 10, top: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.reply_rounded,
                    color: AppColors.customColorRed,
                    size: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.customColorRed,
        unselectedItemColor: AppColors.customColorGray,
        selectedLabelStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 11),
        unselectedLabelStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 11),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long_rounded), label: 'Billing'),
          BottomNavigationBarItem(icon: Icon(Icons.support_agent_rounded), label: 'Call Center'),
          BottomNavigationBarItem(icon: Icon(Icons.email_outlined), label: 'Mailbox'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}
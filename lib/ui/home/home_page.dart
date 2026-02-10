import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trade2gov/ui/edec/edec_page.dart';
import 'package:trade2gov/ui/scan/scan_page.dart';
import '../about/about_page.dart';
import '../notify/notify_page.dart';
import '../scan/scan_page.dart';
import '../../main_navigation.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_box_decoration.dart';
import '../../data/securestorage/secure_storage_service.dart';
import '../../ui/login/login_page.dart';



class HomePage extends StatefulWidget {
  final VoidCallback onOpenInformation;
  final VoidCallback onOpenKurs;
  final VoidCallback onOpenTracking;
  final VoidCallback onOpenEdec;


  const HomePage({
    super.key,
    required this.onOpenInformation,
    required this.onOpenKurs,
    required this.onOpenTracking,
    required this.onOpenEdec,
  });


  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  //untuk menu Kurs / Tracking / Information
  int _activeMenu = -1;
  int _activeProduct = -1;


  @override
  Widget build(BuildContext context) {
    final bool isActive = _activeProduct == 0;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.menu_outlined,
              color: AppColors.customColorRed,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        titleSpacing: 0,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Image.asset(
            'assets/images/t2g-logo.png',
            height: 24,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
          ),
        ),
        actions: [
          // IconButton(
          //   icon: const Icon(
          //     Icons.qr_code_scanner_outlined,
          //     color: AppColors.customColorRed,
          //   ),
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => const ScanPage()),
          //     );
          //   },
          // ),
          IconButton(
            icon: const Icon(
              Icons.notifications_on_outlined,
              color: AppColors.customColorRed,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotifyPage()),
              );
            },
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Flow Diagram Section
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColors.customColorRed,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Text(
                    'Diagram Alir Proses T2G',
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/t2g-flow-diagram.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),

            // Icon Grid Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildMenuIcon(Icons.attach_money_outlined, 'Kurs', 0),
                  _buildMenuIcon(Icons.location_on_outlined, 'Tracking', 1),
                  _buildMenuIcon(Icons.newspaper_outlined, 'Information', 2),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Section Konten Utama
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- KOTAK STATUS TAGIHAN ---
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: AppBox.primary(),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Status:',
                                    style: GoogleFonts.roboto(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.customColorGray,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Tagihan terbit',
                                    style: GoogleFonts.roboto(
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal,
                                      color: AppColors.customColorGray,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'RP 3.281.740,-',
                                style: GoogleFonts.lato(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF389635),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  Text(
                                    'Periode:',
                                    style: GoogleFonts.roboto(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.customColorGray,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Januari 2026',
                                    style: GoogleFonts.roboto(
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal,
                                      color: AppColors.customColorGray,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MainNavigation(initialIndex: 1),
                              ),
                                  (route) => false,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.customColorRed,
                            foregroundColor: Colors.white,
                            overlayColor: Colors.black26,
                            elevation: 2,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Lihat Tagihan',
                            style: GoogleFonts.roboto(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // --- SECTION PRODUK DIGUNAKAN ---
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Produk Digunakan',
                          style: GoogleFonts.lato(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.customColorRed,
                          ),
                        ),
                        const SizedBox(height: 10),

                        InkWell(
                          onTapDown: (_) {
                            setState(() => _activeProduct = 0);
                          },
                          onTapCancel: () {
                            setState(() => _activeProduct = -1);
                          },
                          onTap: () {
                            Future.delayed(const Duration(milliseconds: 120), () {
                              widget.onOpenEdec();
                              setState(() => _activeProduct = -1);
                            });
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 120),
                            transform: Matrix4.translationValues(
                              0,
                              isActive ? 4 : 0, // 👈 INI EFEK SLIDE KE BAWAH
                              0,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                            decoration: isActive
                                ? AppBox.menuActive()
                                : AppBox.primary(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'assets/images/e-declaration.jpg',
                                  height: 80,
                                  width: 140,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'e-Declaration',
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: isActive
                                        ? Colors.white
                                        : AppColors.customColorGray,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),


                  const SizedBox(height: 25),

                  // --- SECTION DESCRIPTION PRODUCT ---
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Description Product',
                          style: GoogleFonts.lato(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.customColorRed,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: AppBox.primary(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Logo di Tengah
                              Image.asset(
                                'assets/images/e-declaration.jpg',
                                height: 80,
                                width: 140,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) => const Icon(
                                  Icons.description_outlined,
                                  color: AppColors.customColorRed,
                                  size: 60,
                                ),
                              ),
                              const SizedBox(height: 8),
                              // Text e-Declaration
                              Text(
                                'e-Declaration',
                                style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  color: AppColors.customColorGray,
                                ),
                              ),
                              const SizedBox(height: 12),
                              // Garis Line Warna Custom Red
                              Container(
                                height: 1.5,
                                width: 300,
                                color: AppColors.customColorRed,
                              ),
                              const SizedBox(height: 15),
                              // Deskripsi Lengkap
                              Text(
                                "e-Declaration adalah aplikasi Trade2Government yang memungkinkan pengguna menyiapkan, mengirim, mencetak, dan mengelola seluruh dokumen deklarasi kepabeanan—impor, ekspor, kawasan berikat, kedatangan sarana pengangkut, dan muatan kapal—secara online kapan saja dan di mana saja, terintegrasi langsung dengan sistem Bea & Cukai menggunakan standar keamanan dan penyampaian dokumen sesuai rekomendasi World Customs Organization (WCO), dengan seluruh respon diterima otomatis oleh sistem.",
                                style: GoogleFonts.roboto(
                                  fontSize: 12,
                                  height: 1.6,
                                  color: AppColors.customColorGray,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // --- SECTION INFORMASI DAN BERITA ---
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Informasi dan Berita',
                        style: GoogleFonts.lato(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.customColorRed,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: AppBox.primary(),
                        child: Text(
                          "Belum ada informasi dan berita apapun saat ini",
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            color: AppColors.customColorGray,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuIcon(IconData icon, String label, int index) {
    final bool isActive = _activeMenu == index;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkResponse(
          onTapDown: (_) {
            setState(() => _activeMenu = index);
          },
          onTapCancel: () {
            setState(() => _activeMenu = -1);
          },
          onTap: () {
            Future.delayed(const Duration(milliseconds: 100), () {
              if (index == 0) widget.onOpenKurs();
              if (index == 1) widget.onOpenTracking();
              if (index == 2) widget.onOpenInformation();
              setState(() => _activeMenu = -1);
            });
          },
          borderRadius: BorderRadius.circular(14),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 70,
            height: 70,
            decoration: isActive ? AppBox.menuActive() : AppBox.menu(),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive
                      ? Colors.white.withOpacity(0.2)
                      : AppColors.customColorRed.withOpacity(0.1),
                ),
                child: Icon(
                  icon,
                  size: 26,
                  color: isActive
                      ? Colors.white
                      : AppColors.customColorRed,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.lato(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: isActive
                ? AppColors.customColorRed
                : AppColors.customColorGray,
          ),
        ),
      ],
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 20),
            color: AppColors.whiteColor,
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage('assets/images/person-image.png'),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Dasha Taran',
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.customColorRed,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'dasha@gmail.com',
                        style: GoogleFonts.lato(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          color: AppColors.customColorRed,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          _drawerItem(Icons.home_rounded, 'Home', true, () {
            Navigator.pop(context); // Tutup drawer saja karena sudah di home
          }),
          _drawerItem(Icons.info_outline_rounded, 'About Us', false, () {
            Navigator.pop(context); // Tutup drawer
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AboutPage()),
            );
          }),
          // _drawerItem(Icons.e_mobiledata_rounded, 'e-Dec', false, () {
          //   Navigator.pop(context); // Tutup drawer
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => const EdecPage()),
          //   );
          // }),
          const Spacer(),
          _drawerItem(Icons.logout_rounded, 'Logout', false, () {
            _logout(context);
          }),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String label, bool isActive, VoidCallback onTap) {
    return ListTile(
      leading: Icon(
        icon,
        color: isActive ? AppColors.customColorRed : AppColors.customColorGray,
      ),
      title: Text(
        label,
        style: GoogleFonts.lato(
          fontWeight: FontWeight.bold,
          color: isActive ? AppColors.customColorRed : AppColors.customColorGray,
        ),
      ),
      onTap: onTap,
    );
  }

  Future<void> _logout(BuildContext context) async {
    final storage = SecureStorageService();

    await storage.clearSession(); // 1️⃣ Hapus session

    if (!context.mounted) return;

    // 2️⃣ Tutup drawer dulu
    Navigator.pop(context);

    // 3️⃣ Pindah ke LoginPage & hapus semua history
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
          (route) => false,
    );
  }
}


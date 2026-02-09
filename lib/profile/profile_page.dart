import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';
import '../utils/app_box_decoration.dart';
import '../widgets/animated_inverse_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
          'Profile',
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
        // Mengurangi padding vertical agar tidak terlalu jauh dari AppBar
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Column(
          children: [
            const SizedBox(height: 5), // Dikurangi dari 50 agar naik ke atas
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                // Kartu Informasi Profil
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 55), // Tetap setengah tinggi foto
                  decoration: AppBox.primary(),
                  padding: const EdgeInsets.only(
                    top: 65, // Jarak konten dari foto profil
                    left: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  child: Column(
                    children: [
                      // Nama & Kontak Utama
                      Text(
                        'Dasha Taran',
                        style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.customColorRed,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'dasha@gmail.com',
                        style: GoogleFonts.lato(
                          fontSize: 14,
                          color: AppColors.customColorRed,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '0812364829109',
                        style: GoogleFonts.lato(
                          fontSize: 14,
                          color: AppColors.customColorRed,
                        ),
                      ),

                      // Divider dengan warna customColorRed
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Divider(
                          thickness: 1,
                          color: AppColors.customColorRed.withOpacity(0.3), // Diubah ke Red
                        ),
                      ),

                      // Detail Data Perusahaan
                      _buildProfileInfoRow('Nama Perusahaan', 'Test Ecustoms'),
                      _buildProfileInfoRow('Npwp', '89384938209423'),
                      _buildProfileInfoRow('Alamat', 'Jalan Sanaan Dikit V'),
                      _buildProfileInfoRow('Kode Pos', '45678'),
                      _buildProfileInfoRow('Bidang Usaha', 'Importir'),
                      _buildProfileInfoRow('Komoditi', 'Penyewaan. Sewa Guna Usaha, Ketenagakerjaan, Travel Agent. Penunjang Lainnya.'),
                      _buildProfileInfoRow('Subkomoditi', 'Jasa Reservasi dan Aktivitas Terkait Lainnya.'),



                      // Divider bawah dengan warna customColorRed
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Divider(
                          thickness: 1,
                          color: AppColors.customColorRed.withOpacity(0.3), // Diubah ke Red
                        ),
                      ),

                      // Section Version
                      Text(
                        'Version Mobile Apps',
                        style: GoogleFonts.lato(
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
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.customColorRed.withOpacity(0.3),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '1.0.0',
                          style: GoogleFonts.roboto(
                            color: AppColors.customColorRed.withOpacity(0.6),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Foto Profil Lingkaran
                Positioned(
                  top: 0,
                  child: Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                      border: Border.all(
                        color: Colors.white,
                        width: 4,
                      ),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/person-image.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: AppColors.customColorGray,
              ),
            ),
          ),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: ': ',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold, // Membuat titik dua menjadi bold
                      fontSize: 13,
                      color: AppColors.customColorGray,
                    ),
                  ),
                  TextSpan(
                    text: value,
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.normal, // Nilai tetap normal
                      fontSize: 13,
                      color: AppColors.customColorGray.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
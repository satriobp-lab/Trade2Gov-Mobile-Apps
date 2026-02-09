import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_box_decoration.dart';

class PibContainerDetailsPage extends StatelessWidget {
  const PibContainerDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data untuk daftar Container PIB
    final List<Map<String, String>> containerList = [
      {
        'no_cont': 'ONEU-5267681',
        'seri': 'ONEU5267681',
        'ukuran': '40 FEET',
        'tipe': 'FCL',
      },
      {
        'no_cont': 'TGBU-1234567',
        'seri': 'TGBU1234567',
        'ukuran': '20 FEET',
        'tipe': 'LCL',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: AppColors.customColorRed),
          onPressed: () => Navigator.pop(context),
        ),
        toolbarHeight: 80,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'PIB Container Details',
              style: GoogleFonts.lato(
                color: AppColors.customColorRed,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '060000-000398-20251217-201062',
              style: GoogleFonts.lato(
                fontSize: 13,
                color: AppColors.customColorGray,
              ),
            ),
          ],
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
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        itemCount: containerList.length,
        itemBuilder: (context, index) {
          final item = containerList[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: AppBox.primary(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bagian Atas: Icon Truck/Container dan No. Container sebagai Judul
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          color: AppColors.customColorRed.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.local_shipping_rounded,
                          color: AppColors.customColorRed,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'NO. ${item['no_cont']}',
                          style: GoogleFonts.lato(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.customColorRed,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Garis Divider
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    height: 1.2,
                    color: AppColors.customColorRed.withOpacity(0.25),
                  ),
                ),

                // Bagian Bawah: Detail Container
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildDetailRow('Seri', item['seri'] ?? '-'),
                      const SizedBox(height: 8),
                      _buildDetailRow('Ukuran', item['ukuran'] ?? '-'),
                      const SizedBox(height: 8),
                      _buildDetailRow('Tipe', item['tipe'] ?? '-'),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Helper widget untuk baris detail agar rapi dan sejajar
  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100, // Lebar label sedikit lebih kecil untuk Container page
          child: Text(
            label,
            style: GoogleFonts.roboto(
              fontSize: 13,
              color: AppColors.customColorGray,
            ),
          ),
        ),
        Text(
          ': ',
          style: GoogleFonts.roboto(
            fontSize: 13,
            color: AppColors.customColorGray,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.roboto(
              fontSize: 13,
              color: AppColors.customColorGray,
            ),
          ),
        ),
      ],
    );
  }
}
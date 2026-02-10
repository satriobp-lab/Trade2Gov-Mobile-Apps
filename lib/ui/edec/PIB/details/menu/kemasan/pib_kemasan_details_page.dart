import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_box_decoration.dart';

class PibKemasanDetailsPage extends StatelessWidget {
  const PibKemasanDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data untuk daftar Kemasan PIB
    final List<Map<String, String>> kemasanList = [
      {
        'jumlah': '100',
        'jenis': 'Kode BA',
        'nama_kemasan': 'Barrel',
        'merek': 'SAMSUNG ELECTRONICS',
        'seri': 'BA',
      },
      {
        'jumlah': '50',
        'jenis': 'Kode BA',
        'nama_kemasan': 'Barrel',
        'merek': 'APPLE INC',
        'seri': 'BA',
      },
      {
        'jumlah': '25',
        'jenis': 'Kode BA',
        'nama_kemasan': 'Barrel',
        'merek': 'LOGITECH G',
        'seri': 'BA',
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
              'PIB Kemasan Details',
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
        itemCount: kemasanList.length,
        itemBuilder: (context, index) {
          final item = kemasanList[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: AppBox.primary(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bagian Atas: Icon Box dan Judul (Jenis Kemasan)
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
                          Icons.all_inbox_rounded,
                          color: AppColors.customColorRed,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          '${item['jenis']} - ${item['nama_kemasan']}',
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

                // Garis Divider Tipis
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    height: 1.2,
                    color: AppColors.customColorRed.withOpacity(0.25),
                  ),
                ),

                // Bagian Bawah: Detail Isi Kemasan
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildDetailRow('Jumlah Kemasan', item['jumlah'] ?? '0'),
                      const SizedBox(height: 8),
                      _buildDetailRow('Merek Kemasan', item['merek'] ?? '-'),
                      const SizedBox(height: 8),
                      _buildDetailRow('Seri', item['seri'] ?? '-'),
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

  // Helper widget untuk baris detail (Konsisten dengan Dokumen Page)
  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
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
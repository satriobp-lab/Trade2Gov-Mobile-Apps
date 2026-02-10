import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_box_decoration.dart';

class PibDokumenDetailsPage extends StatelessWidget {
  const PibDokumenDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data untuk daftar dokumen PIB
    final List<Map<String, String>> dokumenList = [
      {
        'kode': '271',
        'nama': 'Packing List',
        'no_dok': '325892-A',
        'tgl_dok': '30-11-2025'
      },
      {
        'kode': '380',
        'nama': 'Invoice',
        'no_dok': '325892-A',
        'tgl_dok': '30-11-2025'
      },
      {
        'kode': '705',
        'nama': 'B/L',
        'no_dok': '325892-A',
        'tgl_dok': '30-11-2025'
      },
      {
        'kode': '800',
        'nama': 'Sertifikat alat Perangkat Telekom/Postel',
        'no_dok': '325892-A',
        'tgl_dok': '30-11-2025'
      },
      {
        'kode': '803',
        'nama': 'SATS LN / Dephut',
        'no_dok': '325892-A',
        'tgl_dok': '30-11-2025'
      },
      {
        'kode': '861',
        'nama': 'Certificate Of Origin (CO)',
        'no_dok': '325892-A',
        'tgl_dok': '30-11-2025'
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
              'PIB Dokumen Details',
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
        itemCount: dokumenList.length,
        itemBuilder: (context, index) {
          final item = dokumenList[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: AppBox.primary(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bagian Atas: Icon dan Judul Sejajar
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
                          Icons.description_rounded,
                          color: AppColors.customColorRed,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          '${item['kode']} - ${item['nama']}',
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

                // Garis Divider ColorCustomRed
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    height: 1.2,
                    color: AppColors.customColorRed.withOpacity(0.25),
                  ),
                ),


                // Bagian Bawah: Detail Dokumen
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow('Nomor Dokumen', item['no_dok'] ?? ''),
                      const SizedBox(height: 8),
                      _buildDetailRow('Tanggal Dokumen', item['tgl_dok'] ?? ''),
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

  // Helper widget untuk baris detail
  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130, // Lebar tetap untuk label agar titik dua sejajar
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
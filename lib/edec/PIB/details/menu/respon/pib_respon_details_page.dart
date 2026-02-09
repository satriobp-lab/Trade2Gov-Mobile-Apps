import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_box_decoration.dart';

class PibResponDetailsPage extends StatelessWidget {
  const PibResponDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data untuk Rincian Respon
    final Map<String, String> responData = {
      'Kode': '-',
      'Tanggal': '14-01-2026',
      'Waktu': '09:57:26',
    };

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
              'PIB Respon Details',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Container(
              decoration: AppBox.primary(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Card
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
                            Icons.hourglass_bottom_rounded,
                            color: AppColors.customColorRed,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Rincian Respon',
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.customColorRed,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Divider
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      height: 1.2,
                      color: AppColors.customColorRed.withOpacity(0.2),
                    ),
                  ),

                  // Detail Body
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildDetailRow(Icons.qr_code_rounded, 'Kode', responData['Kode']!),
                        const SizedBox(height: 12),
                        _buildDetailRow(Icons.calendar_today_rounded, 'Tanggal', responData['Tanggal']!),
                        const SizedBox(height: 12),
                        _buildDetailRow(Icons.access_time_rounded, 'Waktu', responData['Waktu']!),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 18, color: AppColors.customColorGray.withOpacity(0.6)),
        const SizedBox(width: 10),
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: AppColors.customColorGray,
            ),
          ),
        ),
        Text(': ', style: TextStyle(color: AppColors.customColorGray)),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: AppColors.customColorGray,
            ),
          ),
        ),
      ],
    );
  }
}
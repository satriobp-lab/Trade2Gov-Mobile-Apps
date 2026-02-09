import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_box_decoration.dart';

class PibkHargaDetailsPage extends StatelessWidget {
  const PibkHargaDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data rincian harga sesuai permintaan
    final Map<String, String> hargaData = {
      'Valuta': 'USD - US Dollar',
      'NDPBM': 'Rp. 16.786',
      'Nilai CIF': '124.451,68',
      'Asuransi LN': '-',
      'Freight': '-',
      'Nilai Pabean': '124.451,68',
      'CIF (Rp)': 'Rp. 2.089.045.900,48',
      'Berat Kotor (KG)': '20.966',
      'Berat Bersih (KG)': '-',
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
              'PIBK Harga Details',
              style: GoogleFonts.lato(
                color: AppColors.customColorRed,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '070100456789',
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
        child: Container(
          decoration: AppBox.primary(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Kotak: Ikon dan Judul
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
                        Icons.price_change_rounded,
                        color: AppColors.customColorRed,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Rincian Harga',
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
                  color: AppColors.customColorRed.withOpacity(0.25),
                ),
              ),

              // Daftar Detail Harga
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildHargaRow('Valuta', hargaData['Valuta']!),
                    _buildHargaRow('NDPBM', hargaData['NDPBM']!),
                    _buildHargaRow('Nilai CIF', hargaData['Nilai CIF']!),
                    _buildHargaRow('Asuransi LN', hargaData['Asuransi LN']!),
                    _buildHargaRow('Freight', hargaData['Freight']!),
                    _buildHargaRow('Nilai Pabean', hargaData['Nilai Pabean']!),
                    _buildHargaRow('CIF (Rp)', hargaData['CIF (Rp)']!, isHighlight: true),
                    _buildHargaRow('Berat Kotor (KG)', hargaData['Berat Kotor (KG)']!),
                    _buildHargaRow('Berat Bersih (KG)', hargaData['Berat Bersih (KG)']!),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHargaRow(String label, String value, {bool isHighlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: GoogleFonts.lato(
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
              textAlign: TextAlign.left,
              style: GoogleFonts.roboto(
                fontSize: 13,
                fontWeight: isHighlight ? FontWeight.bold : FontWeight.w500,
                color: isHighlight ? AppColors.customColorRed : AppColors.customColorGray,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
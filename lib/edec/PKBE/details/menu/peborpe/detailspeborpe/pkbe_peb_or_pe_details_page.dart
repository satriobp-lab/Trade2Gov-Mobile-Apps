import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../../utils/app_colors.dart';
import '../../../../../../../utils/app_box_decoration.dart';

class PkbePebOrPeDetailsPage extends StatelessWidget {
  final Map<String, dynamic>? data;

  const PkbePebOrPeDetailsPage({
    super.key,
    this.data,
  });

  @override
  Widget build(BuildContext context) {
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
              'PEB / PE Details',
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(
          children: [
            // SEKSI INFORMASI UTAMA
            _buildSectionTitle('Informasi Utama'),
            _buildInfoCard([
              _buildDetailRow('No. Container', 'BBBBB1212311'),
              _buildDetailRow('PE ke', '1'),
              _buildDetailRow('Jenis Dokumen', '-'),
              _buildDetailRow('Nomor Dokumen', '-'),
              _buildDetailRow('Tanggal PEB', '28-10-2017'),
            ]),

            // SEKSI EKSPOR & PE
            _buildSectionTitle('Detail Ekspor & PE'),
            _buildInfoCard([
              _buildDetailRow('Kategori Barang Ekspor', '10 - Umum - 0 - Non Pe..'),
              _buildDetailRow('1 - PEB', '-'),
              _buildDetailRow('Tanggal PE', '28-10-2017'),
              _buildDetailRow('Keterangan', '-'),
            ]),

            // SEKSI IDENTITAS PENGIRIM / EKSPORTIR
            _buildSectionTitle('Identitas & Pengirim'),
            _buildInfoCard([
              _buildDetailRow('Identitas', '0 - NPWP 12 Digit - 3398388939'),
              _buildDetailRow('Nama', '-'),
              _buildDetailRow('Alamat', '-'),
            ]),

            // SEKSI KEMASAN
            _buildSectionTitle('Kemasan & Pengemas'),
            _buildInfoCard([
              _buildDetailRow('Jumlah Kemasan', '0'),
              _buildDetailRow('Pengemas', '-'),
            ]),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 5, bottom: 8, top: 15),
      child: Text(
        title,
        style: GoogleFonts.lato(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.customColorRed,
        ),
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Container(
      width: double.infinity,
      decoration: AppBox.primary(),
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.roboto(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: AppColors.customColorGray,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9F9),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.customColorRed.withOpacity(0.1),
              ),
            ),
            child: Text(
              value,
              style: GoogleFonts.roboto(
                fontSize: 12,
                color: AppColors.customColorGray,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
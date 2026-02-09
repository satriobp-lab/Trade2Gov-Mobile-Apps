import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_box_decoration.dart';

class PibkHeaderDetailsPage extends StatelessWidget {
  const PibkHeaderDetailsPage({super.key});

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
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'PIBK Header Details',
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
            const SizedBox(height: 8),
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
        padding: const EdgeInsets.symmetric(
          horizontal: 20, // kanan kiri tetap
          vertical: 5,   // atas bawah dinaikin dikit
        ),
        child: Column(
          children: [
            _buildSectionTitle('Data PIBK'),
            _buildInfoCard([
              _buildDetailRow('Kantor Pabean', '070100 - KPPBC Tanjung Perak'),
              _buildDetailRow('No Aju', '070100456789'),
              _buildDetailRow('Jenis PIB', '-'),
              _buildDetailRow('Jenis Impor', '-'),
              _buildDetailRow('Cara Pembayaran', '-'),
            ]),

            _buildSectionTitle('Pengirim'),
            _buildInfoCard([
              _buildDetailRow('Nama', '-'),
              _buildDetailRow('Alamat', '-'),
              _buildDetailRow('Negara', '-'),
            ]),

            _buildSectionTitle('Penjual'),
            _buildInfoCard([
              _buildDetailRow('Nama', '-'),
              _buildDetailRow('Alamat', '-'),
              _buildDetailRow('Negara', '-'),
            ]),

            _buildSectionTitle('Importir'),
            _buildInfoCard([
              _buildDetailRow('Identitas', '(NPWP 12 Digit)'),
              _buildDetailRow('Nama', '-'),
              _buildDetailRow('Alamat', 'Jalan Raya disana II'),
              _buildDetailRow('No API', '-'),
              _buildDetailRow('Status', '-'),
            ]),

            _buildSectionTitle('Pemilik Barang'),
            _buildInfoCard([
              _buildDetailRow('Identitas', '-'),
              _buildDetailRow('Nama', '-'),
              _buildDetailRow('Alamat', '-'),
            ]),

            _buildSectionTitle('PPJK'),
            _buildInfoCard([
              _buildDetailRow('NPWP', '098765432109876'),
              _buildDetailRow('Nama', 'Test Ecustoms'),
              _buildDetailRow('Alamat', 'Jl. Raya Disana II'),
              _buildDetailRow('NP-PPJK', '123'),
            ]),

            _buildSectionTitle('Data Pengangkutan'),
            _buildInfoCard([
              _buildDetailRow('Cara Pengangkutan', 'Laut'),
              _buildDetailRow('Nama Sarana Pengangkut', '-'),
              _buildDetailRow('Nomor Voyage/Flight', '-'),
              _buildDetailRow('Bendera Pengangkut', 'JP - Japan'),
              _buildDetailRow('Perkiraan Tanggal Tiba', '2026-01-21'),
              _buildDetailRow('Pelabuhan Muat', 'JPUKB - Kobe'),
              _buildDetailRow('Pelabuhan Transit', '-'),
              _buildDetailRow('Pelabuhan Tujuan', 'IDTPP - Tanjung Priok'),
              _buildDetailRow('Pemenuhan Persyaratan / Fasilitas Impor', '-'),
              _buildDetailRow('Tempat Penimbunan', '-'),
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
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_box_decoration.dart';

class PibHeaderDetailsPage extends StatelessWidget {
  const PibHeaderDetailsPage({super.key});

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
              'PIB Header Details',
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
            _buildSectionTitle('Data PIB'),
            _buildInfoCard([
              _buildDetailRow('Kantor Pabean', '040300 - KPU Tanjung Priok'),
              _buildDetailRow('No Aju', '060000-000398-20251217-201062'),
              _buildDetailRow('Jenis PIB', 'Biasa'),
              _buildDetailRow('Jenis Impor', 'Untuk dipakai'),
              _buildDetailRow('Cara Pembayaran', 'Biasa/Tunai'),
            ]),

            _buildSectionTitle('Pengirim'),
            _buildInfoCard([
              _buildDetailRow('Nama', 'Daicel Corporation'),
              _buildDetailRow('Alamat', '3-1, Ofuka-Cho, Kita-Ku, Osaka 530-0011, Jp'),
              _buildDetailRow('Negara', 'JP: Japan'),
            ]),

            _buildSectionTitle('Penjual'),
            _buildInfoCard([
              _buildDetailRow('Nama', 'Daicel Corporation'),
              _buildDetailRow('Alamat', '3-1, Ofuka-Cho, Kita-Ku, Seol'),
              _buildDetailRow('Negara', 'JP: Japan'),
            ]),

            _buildSectionTitle('Importir'),
            _buildInfoCard([
              _buildDetailRow('Identitas', 'NPWP - 0000919089208930039320'),
              _buildDetailRow('Nama', 'Hanjaya Mandala Sampoerna D'),
              _buildDetailRow('Alamat', 'Jalan Raya disana II'),
              _buildDetailRow('No API', 'APIP: 1234567890'),
              _buildDetailRow('Status', 'AEO'),
            ]),

            _buildSectionTitle('Pemilik Barang'),
            _buildInfoCard([
              _buildDetailRow('Identitas', 'NPWP - 0000919089208930039320'),
              _buildDetailRow('Nama', 'Hanjaya Mandala Sampoerna D'),
              _buildDetailRow('Alamat', 'JL. Raya Disana II'),
            ]),

            _buildSectionTitle('PPJK'),
            _buildInfoCard([
              _buildDetailRow('NPWP', '-'),
              _buildDetailRow('Nama', '-'),
              _buildDetailRow('Alamat', '-'),
              _buildDetailRow('NP-PPJK', '-'),
            ]),

            _buildSectionTitle('Data Pengangkutan'),
            _buildInfoCard([
              _buildDetailRow('Cara Pengangkutan', 'Laut'),
              _buildDetailRow('Nama Sarana Pengangkut', 'NYK DAEDALUS'),
              _buildDetailRow('Nomor Voyage/Flight', '097S'),
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
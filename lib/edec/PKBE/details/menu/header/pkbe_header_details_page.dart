import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_box_decoration.dart';

class PkbeHeaderDetailsPage extends StatelessWidget {
  const PkbeHeaderDetailsPage({super.key});

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
              'PKBE Header Details',
              style: GoogleFonts.lato(
                color: AppColors.customColorRed,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '010700-888888-20230721-000420',
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
            _buildSectionTitle('Konsolidator / Eksportir'),
            _buildInfoCard([
              _buildDetailRow('Identitas', 'NPWP 15 Digit'),
              _buildDetailRow('Nomor', '0987665432109876'),
              _buildDetailRow('Nipper', '001'),
              _buildDetailRow('Nama', 'Dasha Taran'),
              _buildDetailRow('Alamat', 'JL. Terangkanlah'),
              _buildDetailRow('Stat. Kons', 'Eksportir'),
            ]),

            _buildSectionTitle('Kontainer'),
            _buildInfoCard([
              _buildDetailRow('No. Container', 'BBBB1212311'),
              _buildDetailRow('Size', '20 Feet'),
              _buildDetailRow('NIP Petugas Stuffing', '807654354'),
              _buildDetailRow('Nama Petugas Stuffing', 'Budi'),
            ]),

            _buildSectionTitle('Kantor Pelayanan Bea Cukai (KPBC)'),
            _buildInfoCard([
              _buildDetailRow('KPBC Pendaftaran', '040300 - KPU Tanjung Priok'),
              _buildDetailRow('KPBC Pemeriksaan', '000000 - Kantor Pusat DJBC'),
              _buildDetailRow('KPBC Pemuatan', '040300 - KPU Tanjung Priok'),
              _buildDetailRow('Hanggar TPS', '040300005'),
            ]),

            _buildSectionTitle('Pengangkut'),
            _buildInfoCard([
              _buildDetailRow('Negara Tujuan', 'MY - Malaysia'),
              _buildDetailRow('Moda', 'Laut'),
              _buildDetailRow('Nama', 'Kline'),
              _buildDetailRow('Bendera', 'SG - Singapore'),
              _buildDetailRow('Alamat Stuffing', 'Jalan Baru'),
              _buildDetailRow('Voy / Flight', 'V-00'),
              _buildDetailRow('Tanggal Stuffing', '2017-10-28 Jam 08:00'),
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
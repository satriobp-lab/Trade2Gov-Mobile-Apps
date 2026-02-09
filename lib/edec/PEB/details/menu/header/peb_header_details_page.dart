import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_box_decoration.dart';

class PebHeaderDetailsPage extends StatelessWidget {
  const PebHeaderDetailsPage({super.key});

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
              'PEB Header Details',
              style: GoogleFonts.lato(
                color: AppColors.customColorRed,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '301019-9CB5DF-20251007-000009',
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
            _buildSectionTitle('Data PEB'),
            _buildInfoCard([
              _buildDetailRow('Kantor Pabean', 'KPPBC Tanjung Perak'),
              _buildDetailRow('Kantor Pabean Ekspor', '070100 - KPPBC Tanjung Perak'),
              _buildDetailRow('Nomor Aju', '3010199CB5DF20251007000009'),
              _buildDetailRow('Header - No. Daftar', '185301 - 2025-10-11'),
              _buildDetailRow('Jenis Ekspor', 'Ekspor Biasa'),
              _buildDetailRow('Kategori Ekspor', 'Umum'),
              _buildDetailRow('Cara Pembayaran', 'Gabungan/Lainnya'),
            ]),

            _buildSectionTitle('Eksportir'),
            _buildInfoCard([
              _buildDetailRow('Identitas', 'NPWP - 0000919089208930039320'),
              _buildDetailRow('Nama', 'Hanjaya Mandala Sampoerna D'),
              _buildDetailRow('Alamat', 'Jalan Raya disana II'),
              _buildDetailRow('Status', 'PMDN (non migas)'),
              _buildDetailRow('Niper', 'Khusus Fasilitas KITE'),
            ]),

            _buildSectionTitle('Penerima'),
            _buildInfoCard([
              _buildDetailRow('Nama', 'Philip Morris'),
              _buildDetailRow('Alamat', 'Pontao do Lago Sul (Brasília)'),
              _buildDetailRow('Negara', 'BR : Brazil'),
            ]),

            _buildSectionTitle('Pembeli'),
            _buildInfoCard([
              _buildDetailRow('Nama', 'Johan Liebert'),
              _buildDetailRow('Alamat', 'Kinderheim 511'),
              _buildDetailRow('Negara', 'GER : Germany'),
            ]),

            _buildSectionTitle('PPJK'),
            _buildInfoCard([
              _buildDetailRow('Identitas', '-'),
              _buildDetailRow('Nama', '-'),
              _buildDetailRow('Alamat', '-'),
            ]),

            _buildSectionTitle('Data Pengangkutan'),
            _buildInfoCard([
              _buildDetailRow('Cara Pengangkutan', 'Laut'),
              _buildDetailRow('Nama Sarana Pengangkut', 'APL PUSAN'),
              _buildDetailRow('Nomor Voyage/Flight', '0AUDWN'),
              _buildDetailRow('Bendera Pengangkut', 'SG - Singapore'),
              _buildDetailRow('Perkiraan Tanggal Ekspor', '2026-01-21'),
              _buildDetailRow('Pelabuhan Muat Asal', 'IDTPE - Tanjung Perak'),
              _buildDetailRow('Pelabuhan Muat Ekspor', 'JPUKB - Kobe'),
              _buildDetailRow('Pelabuhan Bongkar', 'BRNVT - Navegantes'),
              _buildDetailRow('Pelabuhan Tujuan', 'IDTPP - Tanjung Priok'),

              _buildDetailRow('Negara Tujuan Eksport', 'BR - Brazil'),
              _buildDetailRow('Lokasi / Tanggal Pemeriksa', 'Gudang Eksportir'),
              _buildDetailRow('KPBC Periksa', '071300 - KPPBC Pasuruan'),
              _buildDetailRow('Gudang PLB', '-'),
              _buildDetailRow('Cara Penyerahan Barang', 'Cost and Freight'),
              _buildDetailRow('Komoditi', 'Non Migas'),
              _buildDetailRow('Volume', '0'),
              _buildDetailRow('Bruto', '9218.4'),
              _buildDetailRow('Netto', '8100'),
              _buildDetailRow('Jumlah Barang', '10'),
              _buildDetailRow('Nilai Tukar Rupiah', '0'),
              _buildDetailRow('Nilai BK (Rupiah)', '0'),
              _buildDetailRow('Penerimaa Pajak Lainnya', '0'),

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
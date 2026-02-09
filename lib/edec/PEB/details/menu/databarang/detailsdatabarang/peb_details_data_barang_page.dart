import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../../utils/app_colors.dart';
import '../../../../../../../utils/app_box_decoration.dart';

class PebDetailsDataBarangPage extends StatelessWidget {
  final String serialNumber;

  const PebDetailsDataBarangPage({
    super.key,
    this.serialNumber = 'Serial 1',
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
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Data Barang Details',
              style: GoogleFonts.lato(
                color: AppColors.customColorRed,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              serialNumber,
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
        padding: const EdgeInsets.symmetric(
          horizontal: 20, // kanan kiri tetap
          vertical: 5,   // atas bawah dinaikin dikit
        ),
        child: Column(
          children: [
            // SEKSI DATA BARANG
            _buildSectionTitle('Data Barang'),
            _buildInfoCard([
              _buildDetailRow('Kode HS / Seri', '4813.10.00 / 1'),
              _buildDetailRow('Uraian Barang', 'FUTUROLA KING - 109/26 - WOOD BROWN'),
              _buildDetailRow('Merk', '-'),
              _buildDetailRow('Type', '-'),
              _buildDetailRow('Ukuran', '-'),
              _buildDetailRow('Kode', '900501721'),
            ]),

            // SEKSI KEMASAN
            _buildSectionTitle('Kemasan'),
            _buildInfoCard([
              _buildDetailRow('Jumlah / Kemasan', '18 / PK - Package'),
              _buildDetailRow('Netto', '66.72115384615384 Kilogram (KGM)'),
              _buildDetailRow('Volume', '-'),
              _buildDetailRow('Negara Asal', 'ID - INDONESIA'),
              _buildDetailRow('Daerah Asal Barang', '5104 - Kaburiwihihi'),
            ]),

            // SEKSI HARGA
            _buildSectionTitle('Harga'),
            _buildInfoCard([
              _buildDetailRow('Harga FOB', '2.358'),
              _buildDetailRow('Jumlah Satuan', '108'),
              _buildDetailRow('Jenis Satuan', 'PCE - Piece'),
              _buildDetailRow('Harga Satuan', '-'),
            ]),

            // SEKSI IZIN KHUSUS
            _buildSectionTitle('Izin Khusus'),
            _buildInfoCard([
              _buildDetailRow('Jenis Izin', '-'),
              _buildDetailRow('Nomor', '-'),
              _buildDetailRow('Tanggal', '-'),
            ]),

            // SEKSI BEA KELUAR
            _buildSectionTitle('Bea Keluar'),
            _buildInfoCard([
              _buildDetailRow('Jenis Tarif', 'Spesifik'),
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

  Widget _buildTarifRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: GoogleFonts.roboto(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.customColorGray.withOpacity(0.8),
              ),
            ),
          ),
          Text(
            ": ",
            style: GoogleFonts.roboto(color: AppColors.customColorGray),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: GoogleFonts.roboto(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.customColorGray,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
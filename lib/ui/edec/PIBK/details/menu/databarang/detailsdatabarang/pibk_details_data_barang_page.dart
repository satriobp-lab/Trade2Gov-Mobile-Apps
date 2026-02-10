import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../../utils/app_colors.dart';
import '../../../../../../../utils/app_box_decoration.dart';

class PibkDetailsDataBarangPage extends StatelessWidget {
  final String serialNumber;

  const PibkDetailsDataBarangPage({
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
              _buildDetailRow('Kode HS / Serinavarams.data[‘Kode HS’]', '-'),
              _buildDetailRow('Uraian Barang', '-'),
              _buildDetailRow('Merk', '-'),
              _buildDetailRow('Type', '-'),
              _buildDetailRow('Spec. Lain', '-'),
              _buildDetailRow('Negara Asal', 'HK - Hong Kong'),
            ]),

            // SEKSI KEMASAN
            _buildSectionTitle('Kemasan'),
            _buildInfoCard([
              _buildDetailRow('Jumlah / Kemasan', '1 / BX - Box'),
              _buildDetailRow('Netto', 'Kilogram (KGM)'),
            ]),

            // SEKSI HARGA
            _buildSectionTitle('Harga'),
            _buildInfoCard([
              _buildDetailRow('Amount', '6'),
              _buildDetailRow('BT-Diskon', '-'),
              _buildDetailRow('Jenis Satuan', '1'),
              _buildDetailRow('Kode Satuan', 'BX - Box'),
              _buildDetailRow('Harga Satuan', '-'),
              _buildDetailRow('Harga FOB', '-'),
              _buildDetailRow('Freight', '-'),
              _buildDetailRow('Asuransi', '-'),
              _buildDetailRow('Harga CIF', '-'),
              _buildDetailRow('CIF (Rp)', '-'),
            ]),

            // SEKSI TARIF DAN FASILITAS (2 KOLOM)
            _buildSectionTitle('Tarif dan Fasilitas'),
            _buildInfoCard([
              _buildDetailRow('BM', '7.5 %'),
              _buildDetailRow('PPN', '10 %'),
              _buildDetailRow('PPnBM', '0 %'),
              _buildDetailRow('PPh', '%'),
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
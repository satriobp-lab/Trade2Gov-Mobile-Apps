import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../../utils/app_colors.dart';
import '../../../../../../../utils/app_box_decoration.dart';

class PibDetailsDataBarangPage extends StatelessWidget {
  final String serialNumber;

  const PibDetailsDataBarangPage({
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
              _buildDetailRow('Kode HS / Seri', '8541.59.00/'),
              _buildDetailRow('Uraian Barang', 'IC 65200-0AGQ-05A'),
              _buildDetailRow('Merk', '-'),
              _buildDetailRow('Type', '-'),
              _buildDetailRow('Spec. Lain', '-'),
              _buildDetailRow('Negara Asal', 'TW - Taiwan, Province of China'),
            ]),

            // SEKSI KEMASAN
            _buildSectionTitle('Kemasan'),
            _buildInfoCard([
              _buildDetailRow('Jumlah / Kemasan', '0 / PK - Package'),
              _buildDetailRow('Netto', '45 Kilogram (KGM)'),
            ]),

            // SEKSI HARGA
            _buildSectionTitle('Harga'),
            _buildInfoCard([
              _buildDetailRow('Valuta', 'USD - United States Dollar'),
              _buildDetailRow('Nilai CIF', '1,250.00'),
              _buildDetailRow('Harga Ekspor', '1,200.00'),
              _buildDetailRow('Biaya Tambahan', '50.00'),
              _buildDetailRow('Diskon', '0.00'),
            ]),

            // SEKSI TARIF DAN FASILITAS (2 KOLOM)
            _buildSectionTitle('Tarif dan Fasilitas'),
            _buildInfoCard([
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Kolom Kiri (Tarif Dasar)
                  Expanded(
                    child: Column(
                      children: [
                        _buildTarifRow('BM', '0 %'),
                        _buildTarifRow('BMI', '0'),
                        _buildTarifRow('BMAD', '0'),
                        _buildTarifRow('BMPB', '0'),
                        _buildTarifRow('BMTP', '0'),
                        _buildTarifRow('Cukai', '0'),
                        _buildTarifRow('PPN', '11 %'),
                        _buildTarifRow('PPnBM', '0 %'),
                        _buildTarifRow('PPH', '0 %'),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Kolom Kanan (Fasilitas)
                  Expanded(
                    child: Column(
                      children: [
                        _buildTarifRow('Ditgg. Pemr', '0 %'),
                        _buildTarifRow('Ditgg. Pemr', '5 %'),
                        _buildTarifRow('Ditgg. Pemr', '5 %'),
                        _buildTarifRow('Ditgg. Pemr', '5 %'),
                        _buildTarifRow('Pelekatan Pita Cukai', '5 %'),
                        _buildTarifRow('Ditgg. Pemr', '100 %'),
                        _buildTarifRow('Ditgg. Pemr', '10 %'),
                        _buildTarifRow('Ditgg. Pemr', '5 %'),
                        _buildTarifRow('Ditgg. Pemr', '2 %'),
                      ],
                    ),
                  ),
                ],
              ),
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
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../../utils/app_colors.dart';
import '../../../../../../../utils/app_box_decoration.dart';
import '../../../../../../../widgets/network_edec_state_widget.dart';
import 'package:trade2gov/data/controllers/pibk/pibk_databarang_controller.dart';
import 'package:trade2gov/data/models/pibk/pibk_databarang_response_model.dart';

class PibkDetailsDataBarangPage extends StatelessWidget {
  final String car;
  final String serialNumber;

  const PibkDetailsDataBarangPage({
    super.key,
    required this.car,
    required this.serialNumber,
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
              '$car - Serial $serialNumber',
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
      body: FutureBuilder<PibkDataBarangResponseModel?>(
        future: PibkDataBarangController.getDataBarangDetail(
          car: car,
          serial: int.tryParse(serialNumber) ?? 0,
        ),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return NetworkEdecStateWidget(
              isLoading: true,
              isNoInternet: false,
              loadingText: "Loading PIBK Data Barang Details...",
              onRetry: () {},
              child: const SizedBox(),
            );
          }

          if (snapshot.hasError) {
            return NetworkEdecStateWidget(
              isLoading: false,
              isNoInternet: true,
              onRetry: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PibkDetailsDataBarangPage(
                      car: car,
                      serialNumber: serialNumber,
                    ),
                  ),
                );
              },
              child: const SizedBox(),
            );
          }

          final data = snapshot.data;

          if (data == null) {
            return const Center(child: Text("Data tidak ditemukan"));
          }

          final detil = data.detil;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Column(
              children: [

                // DATA BARANG
                _buildSectionTitle('Data Barang'),
                _buildInfoCard([
                  _buildDetailRow('Kode HS', _display(detil['NOHS'])),
                  _buildDetailRow('Uraian Barang', _display(detil['BRGURAI'])),
                  _buildDetailRow('Merk', _display(detil['MERK'])),
                  _buildDetailRow('Type', _display(detil['TIPE'])),
                  _buildDetailRow('Spec. Lain', _display(detil['SPFLAIN'])),
                  _buildDetailRow('Negara Asal', _display(detil['NEGARA_ASALUR'])),
                ]),

                // KEMASAN
                _buildSectionTitle('Kemasan'),
                _buildInfoCard([
                  _buildDetailRow(
                    'Jumlah / Kemasan',
                    '${_display(detil['KEMASJM'])} / ${_display(detil['KODE_KEMASANUR'])}',
                  ),
                  _buildDetailRow(
                    'Netto',
                    _display(detil['NETTODTL']),
                  ),
                ]),

                // HARGA
                _buildSectionTitle('Harga'),
                _buildInfoCard([
                  _buildDetailRow('Amount', _display(detil['JMLSAT'])),
                  _buildDetailRow('BT - Diskon', _display(detil['HDISKON'])),
                  _buildDetailRow('Jenis Satuan', _display(detil['KODE_SATUANUR'])),
                  _buildDetailRow('Kode Satuan', _display(detil['KDSAT'])),
                  _buildDetailRow('Harga Satuan', _display(detil['HARGA_SATUAN'])),
                  _buildDetailRow('Harga FOB', _display(detil['HINVOICE'])),
                  _buildDetailRow('Freight', _display(detil['HFREIGHT'])),
                  _buildDetailRow('Asuransi', _display(detil['HASURANSI'])),
                  _buildDetailRow('Harga CIF', _display(detil['DCIF'])),
                  _buildDetailRow('CIF (Rp)', _display(detil['HNDPBM'])),
                ]),

                // TARIF
                _buildSectionTitle('Tarif dan Fasilitas'),
                _buildInfoCard([
                  _buildTarifRow('BM', _percent(detil['TRPBM'])),
                  _buildTarifRow('PPN', _percent(detil['TRPPPN'])),
                  _buildTarifRow('PPnBM', _percent(detil['TRPPNBM'])),
                  _buildTarifRow('PPh', _percent(detil['TRPPH'])),
                ]),

                const SizedBox(height: 30),
              ],
            ),
          );
        },
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

  String _display(dynamic value) {
    if (value == null) return '-';

    if (value is String) {
      if (value.trim().isEmpty) return '-';
      return _toTitleCase(value);
    }

    if (value is num) {
      return value.toString();
    }

    return value.toString();
  }

  String _percent(dynamic value) {
    if (value == null) return '-';

    if (value is String) {
      if (value.trim().isEmpty) return '-';
      return '${value.trim()} %';
    }

    if (value is num) {
      return '$value %';
    }

    return '-';
  }

  String _toTitleCase(String text) {
    if (text.trim().isEmpty) return '-';

    return text
        .toLowerCase()
        .split(' ')
        .map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
  }
}
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../../utils/app_colors.dart';
import '../../../../../../../utils/app_box_decoration.dart';
import '../../../../../../../data/controllers/pib/pib_detailsdatabarang_controller.dart';
import '../../../../../../../data/models/pib/pib_detailsdatabarang_response_model.dart';

class PibDetailsDataBarangPage extends StatelessWidget {
  final String serialNumber;
  final String car;

  const PibDetailsDataBarangPage({
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
      body: FutureBuilder<PibDetailsDataBarangResponseModel>(
        future: PibDetailsDataBarangController.getDetails(
          car: car,
          serial: serialNumber,
        ),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final data = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Column(
              children: [

                // ================= DATA BARANG =================
                _buildSectionTitle('Data Barang'),
                _buildInfoCard([
                  _buildDetailRow(
                    'Kode HS / Seri',
                    '${_display(data.noHs)} / ${_display(data.serial)}',
                  ),
                  _buildDetailRow('Uraian Barang', _display(data.brgUrai)),
                  _buildDetailRow('Merk', _display(data.merk)),
                  _buildDetailRow('Type', _display(data.tipe)),
                  _buildDetailRow('Spec. Lain', _display(data.spfLain)),
                  _buildDetailRow(
                    'Negara Asal',
                    '${_display(data.brgAsal)} - ${_display(data.negaraAsal)}',
                  ),
                ]),

                // ================= KEMASAN =================
                _buildSectionTitle('Kemasan'),
                _buildInfoCard([
                  _buildDetailRow(
                    'Jumlah / Kemasan',
                    '${_display(data.jmlSat)} ${_display(data.kodeSatuan)} - ${_display(data.kodeSatuanUr)}'
                        ' / ${_display(data.jmlKemasan)} ${_display(data.kodeKemasan)} - ${_display(data.kodeKemasanUr)}',
                  ),
                  _buildDetailRow(
                    'Netto',
                    _display(data.netto),
                  ),
                ]),

                // ================= HARGA =================
                _buildSectionTitle('Harga'),
                _buildInfoCard([
                  _buildDetailRow('Amount', _display(data.nilaiInvoice)),
                  _buildDetailRow(
                    'BT - Diskon',
                    _display(data.biayaTambahan - data.diskon),
                  ),
                  _buildDetailRow('Jumlah Satuan', _display(data.jmlSat)),
                  _buildDetailRow('Kode Satuan', _display(data.kodeSatuan)),
                  _buildDetailRow('Harga Satuan', _display(data.hargaSatuan)),
                  _buildDetailRow('Harga FOB', _display(data.hargaFob)),
                  _buildDetailRow('Freight', _display(data.freight)),
                  _buildDetailRow('Asuransi', _display(data.asuransi)),
                  _buildDetailRow('Harga CIF', _display(data.cif)),
                  _buildDetailRow('CIF (Rp)', _display(data.cifRp)),
                ]),

                // ================= TARIF & FASILITAS =================
                _buildSectionTitle('Tarif dan Fasilitas'),
                _buildInfoCard([
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            _buildTarifRow('BM', _percent(data.trpBm)),
                            _buildTarifRow('BMI', _percent(data.trpBmIM)),
                            _buildTarifRow('BMAD', _percent(data.trpBmAD)),
                            _buildTarifRow('BMPB', _percent(data.trpBmPB)),
                            _buildTarifRow('BMTP', _percent(data.trpBmTP)),
                            _buildTarifRow('Cukai', _percent(data.trpCukai)),
                            _buildTarifRow('PPN', _percent(data.trpPpn)),
                            _buildTarifRow('PPnBM', _percent(data.trpPpnBm)),
                            _buildTarifRow('PPH', _percent(data.trpPph)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          children: [
                            _buildTarifRow('Ditgg. Pemr (BM)', _percent(data.fasBm)),
                            _buildTarifRow('Ditgg. Pemr (BMI)', _percent(data.fasBmIM)),
                            _buildTarifRow('Ditgg. Pemr (BMAD)', _percent(data.fasBmAD)),
                            _buildTarifRow('Ditgg. Pemr (BMPB)', _percent(data.fasBmPB)),
                            _buildTarifRow('Ditgg. Pemr (BMTP)', _percent(data.fasBmTP)),
                            _buildTarifRow('Pelekatan Pita Cukai', _percent(data.fasCuk)),
                            _buildTarifRow('Ditgg. Pemr (PPN)', _percent(data.fasPpn)),
                            _buildTarifRow('Ditgg. Pemr (PPnBM)', _percent(data.fasPbm)),
                            _buildTarifRow('Ditgg. Pemr (PPH)', _percent(data.fasPph)),
                          ],
                        ),
                      ),
                    ],
                  ),
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

    return value.toString();
  }

  String _percent(num? value) {
    if (value == null) return '-';
    return '$value %';
  }

  String _toTitleCase(String text) {
    if (text.trim().isEmpty) return '-';

    return text
        .toLowerCase()
        .split(' ')
        .map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase() + word.substring(1);
    })
        .join(' ');
  }
}
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../../utils/app_colors.dart';
import '../../../../../../../widgets/edec_loader.dart';
import '../../../../../../../utils/app_box_decoration.dart';
import '../../../../../../../data/controllers/peb/peb_detailsdatabarang_controller.dart';
import '../../../../../../../data/models/peb/peb_detailsdatabarang_response_model.dart';

class PebDetailsDataBarangPage extends StatelessWidget {
  final String serialNumber;
  final String car;

  const PebDetailsDataBarangPage({
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
      body: FutureBuilder(
        future: PebDetailsDataBarangController.getDetails(
          car: car,
          seriBrg: serialNumber,
        ),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const EdecLoader(),
                  const SizedBox(height: 12),
                  Text(
                    'Loading PEB Data Barang Details...',
                    style: GoogleFonts.lato(
                      color: AppColors.customColorRed,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final data = snapshot.data;

          if (data == null) {
            return const Center(child: Text("Data tidak ditemukan"));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Column(
              children: [

                // ===== DATA BARANG =====
                _buildSectionTitle('Data Barang'),
                _buildInfoCard([
                  _buildDetailRow(
                      'Kode HS / Seri',
                      '${data.hs ?? '-'} / ${data.seriBrg ?? '-'}'),
                  _buildDetailRow(
                      'Uraian Barang',
                      _toTitleCase(data.uraianBarang)),
                  _buildDetailRow('Merk', _toTitleCase(data.merk)),
                  _buildDetailRow('Type', _toTitleCase(data.type)),
                  _buildDetailRow('Ukuran', _toTitleCase(data.size)),
                  _buildDetailRow('Kode', data.kodeBarang ?? '-'),
                ]),

                // ===== KEMASAN =====
                _buildSectionTitle('Kemasan'),
                _buildInfoCard([
                  _buildDetailRow(
                    'Jumlah / Kemasan',
                    '${data.jumlahKoli ?? '-'} / ${data.jenisKoli ?? '-'} - ${data.uraianJenisKoli ?? ''}',
                  ),
                  _buildDetailRow(
                    'Netto',
                    '${data.netto ?? '-'} Kilogram (KGM)',
                  ),
                  _buildDetailRow(
                    'Volume',
                    data.volume?.toString() ?? '-',
                  ),
                  _buildDetailRow(
                    'Negara Asal',
                    '${data.negaraAsal ?? '-'} - ${data.uraianNegaraAsal ?? '-'}',
                  ),
                  _buildDetailRow(
                    'Daerah Asal Barang',
                    '${data.daerahAsal ?? '-'} - ${data.uraianDaerahAsal ?? '-'}',
                  ),
                ]),

                // ===== HARGA =====
                _buildSectionTitle('Harga'),
                _buildInfoCard([
                  _buildDetailRow(
                    'Harga FOB',
                    data.fob?.toString() ?? '-',
                  ),
                  _buildDetailRow(
                    'Jumlah Satuan',
                    data.jumlahSatuan?.toString() ?? '-',
                  ),
                  _buildDetailRow(
                    'Jenis Satuan',
                    '${data.jenisSatuan ?? '-'} - ${data.uraianJenisSatuan ?? ''}',
                  ),
                  _buildDetailRow(
                    'Harga Satuan',
                    '-',
                  ),
                ]),

                // ===== IZIN =====
                _buildSectionTitle('Izin Khusus'),
                _buildInfoCard([
                  _buildDetailRow('Jenis Izin', _displayValue(data.kdIzin)),
                  _buildDetailRow('Nomor', _displayValue(data.noIzin)),
                  _buildDetailRow('Tanggal', _displayValue(data.tglIzin)),
                ]),

                // ===== BEA KELUAR =====
                _buildSectionTitle('Bea Keluar'),
                _buildInfoCard([
                  _buildDetailRow(
                    'Jenis Tarif',
                    (data.tarifPe ?? 0) == 0 ? 'Tidak Ada' : 'Ada Tarif',
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

  String _toTitleCase(String? text) {
    if (text == null || text.isEmpty) return '-';

    return text
        .toLowerCase()
        .split(' ')
        .map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase() + word.substring(1);
    })
        .join(' ');
  }

  String _displayValue(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '-';
    }
    return value;
  }
}
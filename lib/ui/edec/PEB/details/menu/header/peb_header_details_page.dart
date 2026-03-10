import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../widgets/edec_loader.dart';
import '../../../../../../utils/app_box_decoration.dart';
import '../../../../../../data/controllers/peb/peb_header_controller.dart';
import '../../../../../../data/models/peb/peb_header_response_model.dart';

class PebHeaderDetailsPage extends StatefulWidget {
  final String car;

  const PebHeaderDetailsPage({
    super.key,
    required this.car,
  });

  @override
  State<PebHeaderDetailsPage> createState() =>
      _PebHeaderDetailsPageState();
}

class _PebHeaderDetailsPageState
    extends State<PebHeaderDetailsPage> {

  late Future<PebHeaderResponseModel?> _future;

  @override
  void initState() {
    super.initState();
    _future =
        PebHeaderController.getPebHeader(widget.car);
  }

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
              widget.car,
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
      body: FutureBuilder<PebHeaderResponseModel?>(
        future: _future,
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const EdecLoader(),
                  const SizedBox(height: 12),
                  Text(
                    'Loading PEB Header Details...',
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

          // 🔥 Kalau null / tidak ada data
          if (!snapshot.hasData || snapshot.data == null) {
            return _buildEmptyState();
          }

          final data = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Column(
              children: [

                // ================= DATA PEB =================
                _buildSectionTitle('Data PEB'),
                _buildInfoCard([
                  _buildDetailRow('Kantor Pabean',
                      '${data.kdKtr ?? '-'} - ${data.urKdKtr ?? '-'}'),
                  _buildDetailRow('Kantor Pabean Ekspor',
                      '${data.kdKtrEks ?? '-'} - ${data.urKdKtrEks ?? '-'}'),
                  _buildDetailRow('Nomor Aju', data.car ?? '-'),
                  _buildDetailRow('Header - No. Daftar',
                      '${data.noDaft ?? '-'} - ${data.tgDaft ?? '-'}'),
                  _buildDetailRow('Jenis Ekspor', data.urJneks ?? '-'),
                  _buildDetailRow('Kategori Ekspor', data.urKateks ?? '-'),
                  _buildDetailRow('Cara Pembayaran', data.urJnbyr ?? '-'),
                ]),

                // ================= EKSPORTIR =================
                _buildSectionTitle('Eksportir'),
                _buildInfoCard([
                  _buildDetailRow('Identitas', data.npwpEks ?? '-'),
                  _buildDetailRow('Nama', data.namaEks ?? '-'),
                  _buildDetailRow('Alamat', data.alamatEks ?? '-'),
                  _buildDetailRow('Status', data.urStatusH ?? '-'),
                  _buildDetailRow('Niper', data.niper ?? '-'),
                ]),

                // ================= PENERIMA =================
                _buildSectionTitle('Penerima'),
                _buildInfoCard([
                  _buildDetailRow('Nama', data.namaBeli ?? '-'),
                  _buildDetailRow('Alamat', data.alamatBeli ?? '-'),
                  _buildDetailRow('Negara',
                      '${data.negBeli ?? '-'} - ${data.urNegBeli ?? '-'}'),
                ]),

                // ================= PEMBELI 2 =================
                _buildSectionTitle('Pembeli'),
                _buildInfoCard([
                  _buildDetailRow('Nama', data.namaBeli2 ?? '-'),
                  _buildDetailRow('Alamat', data.alamatBeli2 ?? '-'),
                  _buildDetailRow('Negara',
                      '${data.negBeli2 ?? '-'} - ${data.urNegBeli2 ?? '-'}'),
                ]),

                // ================= PPJK =================
                _buildSectionTitle('PPJK'),
                _buildInfoCard([
                  _buildDetailRow('Identitas', data.npwpPpjk ?? '-'),
                  _buildDetailRow('Nama', data.namaPpjk ?? '-'),
                  _buildDetailRow('Alamat', data.alamatPpjk ?? '-'),
                ]),

                // ================= PENGANGKUTAN =================
                _buildSectionTitle('Data Pengangkutan'),
                _buildInfoCard([
                  _buildDetailRow('Cara Pengangkutan', data.urModa ?? '-'),
                  _buildDetailRow('Nama Sarana Pengangkut', data.carrier ?? '-'),
                  _buildDetailRow('Nomor Voyage/Flight', data.voy ?? '-'),
                  _buildDetailRow('Bendera Pengangkut',
                      '${data.bendera ?? '-'} - ${data.urBendera ?? '-'}'),
                  _buildDetailRow('Perkiraan Tanggal Ekspor', data.tgEks ?? '-'),
                  _buildDetailRow('Pelabuhan Muat Asal',
                      '${data.pelMuat ?? '-'} - ${data.urPelMuat ?? '-'}'),
                  _buildDetailRow('Pelabuhan Muat Ekspor',
                      '${data.pelMuatEks ?? '-'} - ${data.urPelMuatEks ?? '-'}'),
                  _buildDetailRow('Pelabuhan Bongkar',
                      '${data.pelBongkar ?? '-'} - ${data.urPelBongkar ?? '-'}'),
                  _buildDetailRow('Pelabuhan Tujuan',
                      '${data.pelTujuan ?? '-'} - ${data.urPelTujuan ?? '-'}'),
                  _buildDetailRow('Negara Tujuan',
                      '${data.negTuju ?? '-'} - ${data.urNegTuju ?? '-'}'),
                  _buildDetailRow('Lokasi Barang', data.kdLokBrg ?? '-'),
                  _buildDetailRow('KPBC Periksa',
                      '${data.kdKtrPriks ?? '-'} - ${data.urKdKtrPriks ?? '-'}'),
                  _buildDetailRow('Gudang PLB', data.gudangPlb ?? '-'),
                  _buildDetailRow('Cara Penyerahan Barang', data.delivery ?? '-'),
                  _buildDetailRow('Komoditi', data.urKmdt ?? '-'),
                  _buildDetailRow('Volume', '${data.volume ?? 0}'),
                  _buildDetailRow('Bruto', '${data.bruto ?? 0}'),
                  _buildDetailRow('Netto', '${data.netto ?? 0}'),
                  _buildDetailRow('Jumlah Barang', '${data.jumlahBarang ?? 0}'),
                  _buildDetailRow('Nilai Tukar Rupiah', '${data.nilKurs ?? 0}'),
                  _buildDetailRow('Nilai BK (Rupiah)', '${data.nilPe ?? 0}'),
                  _buildDetailRow('Penerimaan Pajak Lainnya',
                      '${data.nilPajakLain ?? 0}'),
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
              _formatValue(value),
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

  String _formatValue(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '-';
    }

    String result = value.trim();

    // ISO date biarkan
    final dateRegex = RegExp(r'^\d{4}-\d{2}-\d{2}');
    if (dateRegex.hasMatch(result)) {
      return result;
    }

    // hilangkan angka depan seperti "4 - Udara"
    result = result.replaceFirst(
      RegExp(r'^\d{1,2}\s*-\s*'),
      '',
    );

    final exceptions = ['PT', 'NPWP', 'API'];

    result = result
        .toLowerCase()
        .split(' ')
        .map((word) {
      if (word.isEmpty) return '';
      if (exceptions.contains(word.toUpperCase())) {
        return word.toUpperCase();
      }
      return word[0].toUpperCase() + word.substring(1);
    })
        .join(' ');

    return result;
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // 🔴 Circle Background
            Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.customColorRed.withOpacity(0.08),
              ),
              child: Icon(
                Icons.search_off_rounded,
                size: 70,
                color: AppColors.customColorRed,
              ),
            ),

            const SizedBox(height: 25),

            Text(
              "Data Header Tidak Ditemukan",
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.customColorRed,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "Detail header untuk CAR ini belum tersedia.\nSilakan pastikan nomor dokumen benar.",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: 13,
                color: AppColors.customColorGray,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
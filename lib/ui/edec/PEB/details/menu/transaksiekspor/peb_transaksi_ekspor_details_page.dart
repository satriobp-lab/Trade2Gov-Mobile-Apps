import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../../utils/app_colors.dart';
import '../../../../../../../utils/app_box_decoration.dart';
import '../../../../../../widgets/edec_loader.dart';
import 'package:trade2gov/data/controllers/peb/peb_transaksiekspor_controller.dart';
import 'package:trade2gov/data/models/peb/peb_transaksiekspor_response_model.dart';

class PebTransaksiEksporDetailsPage extends StatelessWidget {

  final String car;

  const PebTransaksiEksporDetailsPage({
    super.key,
    required this.car,
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
              'Transaksi Ekspor Details',
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
      body: FutureBuilder<PebTransaksiEksporResponseModel?>(
        future: PebTransaksiEksporController.getTransaksiEkspor(car: car),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const EdecLoader(),
                  const SizedBox(height: 12),
                  Text(
                    'Loading PEB Transaksi Ekspor Details...',
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
            return Center(child: Text("Terjadi kesalahan"));
          }

          final data = snapshot.data;

          if (data == null) {
            return _buildEmptyState();
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Column(
              children: [

                /// BANK DHE
                _buildSectionTitle('Bank DHE'),
                _buildInfoCard([
                  _buildDetailRow('Kode', data.kdBank ?? '-'),
                  _buildDetailRow('Uraian', data.lokBank ?? '-'),
                ]),

                /// NILAI
                _buildSectionTitle('Nilai'),
                _buildInfoCard([
                  _buildDetailRow(
                    'Valuta',
                    '${data.kdVal ?? '-'} - ${data.urKdVal ?? ''}',
                  ),
                  _buildDetailRow(
                    'FOB',
                    data.fob.toString(),
                  ),
                  _buildDetailRow(
                    'Nilai Freight',
                    data.freight.toString(),
                  ),
                  _buildDetailRow(
                    'Jenis Asuransi',
                    data.kdAss == '1'
                        ? 'Dalam Negeri'
                        : 'Luar Negeri',
                  ),
                  _buildDetailRow(
                    'Nilai Asuransi',
                    data.asuransi.toString(),
                  ),
                  _buildDetailRow(
                    'Nilai Maklon',
                    data.nilMaklon.toString(),
                  ),
                ]),
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

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.customColorRed.withOpacity(0.08),
              ),
              child: const Icon(
                Icons.handshake_rounded,
                size: 70,
                color: AppColors.customColorRed,
              ),
            ),

            const SizedBox(height: 25),

            Text(
              "Transaksi Ekspor Tidak Ditemukan",
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.customColorRed,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "Belum terdapat data transaksi ekspor\nuntuk CAR ini.\nSilakan periksa kembali data Anda.",
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
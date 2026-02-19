import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_box_decoration.dart';
import '../../../../../../data/controllers/pib/pib_header_controller.dart';
import '../../../../../../data/models/pib/pib_header_response_model.dart';

class PibHeaderDetailsPage extends StatefulWidget {
  final String car;

  const PibHeaderDetailsPage({
    super.key,
    required this.car,
  });

  @override
  State<PibHeaderDetailsPage> createState() =>
      _PibHeaderDetailsPageState();
}

class _PibHeaderDetailsPageState
    extends State<PibHeaderDetailsPage> {
  late Future<PibHeaderResponseModel> _futureHeader;

  @override
  void initState() {
    super.initState();
    _futureHeader =
        PibHeaderController.getHeader(widget.car);
  }

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
              'PIB Header Details',
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
            color:
            AppColors.customColorRed.withOpacity(0.3),
            height: 1.0,
            margin:
            const EdgeInsets.symmetric(horizontal: 25),
          ),
        ),
      ),
      body: FutureBuilder<PibHeaderResponseModel>(
        future: _futureHeader,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
                child: Text(
                    "Error: ${snapshot.error}"));
          }

          final data = snapshot.data!;
          final header = data.header;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5,
            ),
            child: Column(
              children: [
                _buildSectionTitle('Data PIB'),
                _buildInfoCard([
                  _buildDetailRow(
                      'Kantor Pabean',
                      '${header.kdKpbc} - ${header.urKpbc}'),
                  _buildDetailRow(
                      'No Aju', header.car),
                  _buildDetailRow(
                      'Jenis PIB',
                      data.jnPibMap[
                      header.jnPib] ??
                          header.jnPib),
                  _buildDetailRow(
                      'Jenis Impor',
                      data.jnImpMap[
                      header.jnImp] ??
                          header.jnImp),
                  _buildDetailRow(
                      'Cara Pembayaran',
                      data.crByrMap[
                      header.crByr] ??
                          header.crByr),
                ]),

                _buildSectionTitle('Pengirim'),
                _buildInfoCard([
                  _buildDetailRow(
                      'Nama', header.pasokNama),
                  _buildDetailRow(
                      'Alamat', header.pasokAlmt),
                  _buildDetailRow(
                      'Negara',
                      '${header.pasokNeg} - ${header.urPasokNeg}'),
                ]),

                _buildSectionTitle('Penjual'),
                _buildInfoCard([
                  _buildDetailRow(
                      'Nama', header.penjNama),
                  _buildDetailRow(
                      'Alamat', header.penjAlmt),
                  _buildDetailRow(
                      'Negara', header.penjNeg),
                ]),

                _buildSectionTitle('Importir'),
                _buildInfoCard([
                  _buildDetailRow(
                      'Identitas',
                      'NPWP - ${header.impNpwp}'),
                  _buildDetailRow(
                      'Nama', header.impNama),
                  _buildDetailRow(
                      'Alamat', header.impAlmt),
                  _buildDetailRow(
                      'No API',
                      '${header.apiKd} - ${header.apiNo}'),
                  _buildDetailRow('Status', header.impStatus),
                ]),

                _buildSectionTitle('Pemilik Barang'),
                _buildInfoCard([
                  _buildDetailRow(
                      'Identitas', header.impNpwp),
                  _buildDetailRow(
                      'Nama', header.impNama),
                  _buildDetailRow(
                      'Alamat', header.impAlmt),
                ]),

                _buildSectionTitle('PPJK'),
                _buildInfoCard([
                  _buildDetailRow('NPWP', header.ppjkNpwp),
                  _buildDetailRow('Nama', header.ppjkNama),
                  _buildDetailRow('Alamat', header.ppjkAlmt),
                  _buildDetailRow('NP-PPJK', header.ppjkNo),
                ]),

                _buildSectionTitle(
                    'Data Pengangkutan'),
                _buildInfoCard([
                  _buildDetailRow(
                      'Cara Pengangkutan',
                      data.modaMap[
                      header.moda] ??
                          header.moda),
                  _buildDetailRow(
                      'Nama Sarana Pengangkut',
                      header.angkutNama),
                  _buildDetailRow(
                      'Nomor Voyage/Flight',
                      header.angkutNo),
                  _buildDetailRow(
                      'Bendera Pengangkut',
                      header.urAngkutFl),
                  _buildDetailRow(
                      'Perkiraan Tanggal Tiba',
                      header.tgtiba),
                  _buildDetailRow(
                      'Pelabuhan Muat',
                      header.pelMuatUr),
                  _buildDetailRow(
                    'Pelabuhan Transit',
                    header.pelTransitUr,
                  ),
                  _buildDetailRow(
                      'Pelabuhan Tujuan',
                      header.pelBkrUr),
                  _buildDetailRow(
                    'Pemenuhan Persyaratan / Fasilitas Impor',
                    header.urKdFas,
                  ),
                  _buildDetailRow(
                    'Tempat Penimbunan',
                    header.urTmptBn,
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
      padding: const EdgeInsets.only(
          left: 5, bottom: 8, top: 15),
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
      child: Column(children: children),
    );
  }

  Widget _buildDetailRow(
      String label, String value) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
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
            padding:
            const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9F9),
              borderRadius:
              BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.customColorRed
                    .withOpacity(0.1),
              ),
            ),
            child: Text(
              _formatValue(value),
              style: GoogleFonts.roboto(
                fontSize: 12,
                color:
                AppColors.customColorGray,
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

    // ✅ Jika format ISO date (yyyy-mm-dd)
    final dateRegex = RegExp(r'^\d{4}-\d{2}-\d{2}');
    if (dateRegex.hasMatch(result)) {
      return result; // tampilkan apa adanya
    }

    // 🔹 Hilangkan angka di depan seperti "4 - Udara"
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
      return word[0].toUpperCase() +
          word.substring(1);
    })
        .join(' ');

    return result;
  }
}

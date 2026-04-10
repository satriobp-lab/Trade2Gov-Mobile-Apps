import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_box_decoration.dart';
import '../../../../../../widgets/edec_loader.dart';
import '../../../../../../widgets/network_edec_state_widget.dart';
import 'package:trade2gov/data/controllers/pibk/pibk_header_controller.dart';
import 'package:trade2gov/data/models/pibk/pibk_header_response_model.dart';


class PibkHeaderDetailsPage extends StatefulWidget {
  final String car;

  const PibkHeaderDetailsPage({super.key, required this.car});

  @override
  State<PibkHeaderDetailsPage> createState() =>
      _PibkHeaderDetailsPageState();
}

class _PibkHeaderDetailsPageState
    extends State<PibkHeaderDetailsPage> {

  late Future<PibkHeaderResponseModel?> _futureHeader;

  @override
  void initState() {
    super.initState();
    _futureHeader =
        PibkHeaderController.getHeader(widget.car);
  }

  String safe(dynamic value) {
    if (value == null || value.toString().isEmpty) {
      return "-";
    }
    return value.toString();
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
              'PIBK Header Details',
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
      body: FutureBuilder<PibkHeaderResponseModel?>(
        future: _futureHeader,
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return NetworkEdecStateWidget(
              isLoading: true,
              isNoInternet: false,
              loadingText: "Loading PIBK Header Details...",
              onRetry: () {},
              child: const SizedBox(),
            );
          }

          if (snapshot.hasError) {
            return NetworkEdecStateWidget(
              isLoading: false,
              isNoInternet: true,
              onRetry: () {
                setState(() {
                  _futureHeader =
                      PibkHeaderController.getHeader(widget.car);
                });
              },
              child: const SizedBox(),
            );
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return _buildEmptyState();
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

                /// =======================
                /// DATA PIBK
                /// =======================
                _buildSectionTitle('Data PIBK'),
                _buildInfoCard([
                  _buildDetailRow(
                    'Kantor Pabean',
                    "${safe(header["KDKPBC"])} - ${safe(header["URKPBC"])}", keepUppercase: true,
                  ),
                  _buildDetailRow(
                    'No Aju',
                    safe(header["CAR"]),
                    keepUppercase: true,
                  ),

                  _buildDetailRow(
                    'Jenis PIB',
                    header["JNPIB"] != null
                        ? safe(data.jnPib[header["JNPIB"].toString()])
                        : "-",
                  ),

                  _buildDetailRow(
                    'Jenis Impor',
                    header["JNIMP"] != null
                        ? safe(data.jnImp[header["JNIMP"].toString()])
                        : "-",
                  ),

                  _buildDetailRow(
                    'Cara Pembayaran',
                    header["CRBYR"] != null
                        ? safe(data.crByr[header["CRBYR"].toString()])
                        : "-",
                  ),
                ]),

                /// =======================
                /// PENGIRIM
                /// =======================
                _buildSectionTitle('Pengirim'),
                _buildInfoCard([
                  _buildDetailRow('Nama', safe(header["PASOKNAMA"])),
                  _buildDetailRow('Alamat', safe(header["PASOKALMT"])),
                  _buildDetailRow(
                    'Negara',
                    safe(header["PASOKNEG"]),
                    keepUppercase: true,
                  ),
                ]),

                /// =======================
                /// PENJUAL
                /// =======================
                _buildSectionTitle('Penjual'),
                _buildInfoCard([
                  _buildDetailRow('Nama', safe(header["PENJNAMA"])),
                  _buildDetailRow('Alamat', safe(header["PENJALMT"])),
                  _buildDetailRow(
                    'Negara',
                    safe(header["PASOKNEG"]),
                    keepUppercase: true,
                  ),
                ]),

                /// =======================
                /// IMPORTIR
                /// =======================
                _buildSectionTitle('Importir'),
                _buildInfoCard([
                  // _buildDetailRow(
                  //   'Identitas',
                  //   header["IMPID"] != null
                  //       ? (() {
                  //     int index =
                  //         int.tryParse(header["IMPID"].toString()) ?? 0;
                  //     if (index < data.impId.length) {
                  //       return data.impId[index].toString();
                  //     }
                  //     return "-";
                  //   })()
                  //       : "-",
                  // ),
                  _buildDetailRow('Identitas', safe(header["IMPNPWP"])),
                  _buildDetailRow('Nama', safe(header["IMPNAMA"])),
                  _buildDetailRow('Alamat', safe(header["IMPALMT"])),
                  _buildDetailRow('No API', safe(header["APINO"])),
                  _buildDetailRow('Status', safe(header["IMPSTATUS"])),
                ]),

                /// =======================
                /// PEMILIK BARANG
                /// =======================
                _buildSectionTitle('Pemilik Barang'),
                _buildInfoCard([
                  _buildDetailRow('Identitas', safe(header["INDID"])),
                  _buildDetailRow('Nama', safe(header["INDNAMA"])),
                  _buildDetailRow('Alamat', safe(header["INDALMT"])),
                ]),

                /// =======================
                /// PPJK
                /// =======================
                _buildSectionTitle('PPJK'),
                _buildInfoCard([
                  _buildDetailRow('NPWP', safe(header["PPJKNPWP"])),
                  _buildDetailRow('Nama', safe(header["PPJKNAMA"])),
                  _buildDetailRow('Alamat', safe(header["PPJKALMT"])),
                  _buildDetailRow('NP-PPJK', safe(header["PPJKNO"])),
                ]),

                /// =======================
                /// DATA PENGANGKUTAN
                /// =======================
                _buildSectionTitle('Data Pengangkutan'),
                _buildInfoCard([
                  _buildDetailRow(
                    'Cara Pengangkutan',
                    header["MODA"] != null
                        ? safe(data.moda[header["MODA"].toString()])
                        : "-",
                  ),
                  _buildDetailRow(
                      'Nama Sarana Pengangkut',
                      safe(header["ANGKUTNAMA"])),
                  _buildDetailRow(
                      'Nomor Voyage/Flight',
                      safe(header["ANGKUTNO"])),
                  _buildDetailRow(
                    'Bendera Pengangkut',
                    safe(header["URANGKUTFL"] ?? header["ANGKUTFL"]),
                    keepUppercase: true,
                  ),
                  _buildDetailRow(
                      'Perkiraan Tanggal Tiba',
                      safe(header["TGTIBA"])),
                  _buildDetailRow(
                    'Pelabuhan Muat',
                    safe(header["PELMUATUR"] ?? header["PELMUAT"]),
                  ),
                  _buildDetailRow(
                      'Pelabuhan Transit',
                      safe(header["PELTRANSIT"])),
                  _buildDetailRow(
                    'Pelabuhan Tujuan',
                    safe(header["PELBKRUR"] ?? header["PELBKR"]),
                  ),
                  _buildDetailRow(
                    'Pemenuhan Persyaratan / Fasilitas Impor',
                    safe(header["URKDFAS"] ?? header["KDFAS"]),
                  ),
                  _buildDetailRow(
                    'Tempat Penimbunan',
                    safe(header["URTMPTBN"] ?? header["TMPTBN"]),
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
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildDetailRow(
      String label,
      String value, {
        bool keepUppercase = false,
      }) {
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
            padding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9F9),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.customColorRed
                    .withOpacity(0.1),
              ),
            ),
            child: Text(
              _formatValue(
                value,
                keepUppercase: keepUppercase,
              ),
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

  String _formatValue(String? value,
      {bool keepUppercase = false}) {
    if (value == null || value.trim().isEmpty) {
      return '-';
    }

    String result = value.trim();

    result = result.replaceFirst(
      RegExp(r'^\d+\s*-\s*'),
      '',
    );

    if (keepUppercase) {
      return result.toUpperCase();
    }

    // Format Title Case
    final exceptions = ['PT', 'NPWP', 'API', 'CV'];

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
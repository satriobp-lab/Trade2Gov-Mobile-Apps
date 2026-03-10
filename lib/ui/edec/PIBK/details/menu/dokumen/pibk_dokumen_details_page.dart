import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_box_decoration.dart';
import '../../../../../../widgets/edec_loader.dart';
import 'package:trade2gov/data/controllers/pibk/pibk_dokumen_controller.dart';
import 'package:trade2gov/data/models/pibk/pibk_dokumen_response_model.dart';

class PibkDokumenDetailsPage extends StatefulWidget {
  final String car;

  const PibkDokumenDetailsPage({
    super.key,
    required this.car,
  });

  @override
  State<PibkDokumenDetailsPage> createState() =>
      _PibkDokumenDetailsPageState();
}

class _PibkDokumenDetailsPageState
    extends State<PibkDokumenDetailsPage> {

  late Future<List<PibkDokumenResponseModel>> _futureDokumen;

  @override
  void initState() {
    super.initState();
    _futureDokumen =
        PibkDokumenController.getPibkDokumen(widget.car);
  }

  @override
  Widget build(BuildContext context) {
    // Mock data untuk daftar dokumen PIB
    final List<Map<String, String>> dokumenList = [
      {
        'kode': '705',
        'nama': 'B/L',
        'no_dok': '1744557MAJHK277',
        'tgl_dok': '30-11-2025'
      },
      {
        'kode': '380',
        'nama': 'Invoice',
        'no_dok': '325892-A',
        'tgl_dok': '30-11-2025'
      },
    ];

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
        toolbarHeight: 80,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'PIBK Dokumen Details',
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
      body: FutureBuilder<List<PibkDokumenResponseModel>>(
        future: _futureDokumen,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const EdecLoader(),
                  const SizedBox(height: 12),
                  Text(
                    'Loading PIBK Dokumen Details...',
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

          final dokumenList = snapshot.data ?? [];

          if (dokumenList.isEmpty) {
            return _buildEmptyState();
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            itemCount: dokumenList.length,
            itemBuilder: (context, index) {
              final item = dokumenList[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: AppBox.primary(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: AppColors.customColorRed.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.description_rounded,
                              color: AppColors.customColorRed,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              '${item.kode} - ${item.jenis}',
                              style: GoogleFonts.lato(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppColors.customColorRed,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        height: 1.2,
                        color:
                        AppColors.customColorRed.withOpacity(0.25),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          _buildDetailRow(
                              'Nomor Dokumen', item.nomor),
                          const SizedBox(height: 8),
                          _buildDetailRow(
                              'Tanggal Dokumen', item.tanggal),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Helper widget untuk baris detail
  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130, // Lebar tetap untuk label agar titik dua sejajar
          child: Text(
            label,
            style: GoogleFonts.roboto(
              fontSize: 13,
              color: AppColors.customColorGray,
            ),
          ),
        ),
        Text(
          ': ',
          style: GoogleFonts.roboto(
            fontSize: 13,
            color: AppColors.customColorGray,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.roboto(
              fontSize: 13,
              color: AppColors.customColorGray,
            ),
          ),
        ),
      ],
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
                Icons.description_outlined,
                size: 70,
                color: AppColors.customColorRed,
              ),
            ),

            const SizedBox(height: 25),

            Text(
              "Dokumen Tidak Ditemukan",
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.customColorRed,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "Belum terdapat dokumen untuk CAR ini.\nSilakan periksa kembali data Anda.",
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
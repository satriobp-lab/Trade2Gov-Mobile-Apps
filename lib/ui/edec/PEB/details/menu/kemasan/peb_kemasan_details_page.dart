import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_box_decoration.dart';
import '../../../../../../widgets/edec_loader.dart';
import '../../../../../../data/controllers/peb/peb_kemasan_controller.dart';
import '../../../../../../data/models/peb/peb_kemasan_response_model.dart';

class PebKemasanDetailsPage extends StatelessWidget {
  final String car;

  const PebKemasanDetailsPage({
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
        toolbarHeight: 80,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'PEB Kemasan Details',
              style: GoogleFonts.lato(
                color: AppColors.customColorRed,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              car,
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
      body: FutureBuilder<List<PebKemasanResponseModel>>(
        future: PebKemasanController.getKemasan(car: car),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const EdecLoader(),
                  const SizedBox(height: 12),
                  Text(
                    'Loading PEB Kemasan Details...',
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
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 70,
                      color: AppColors.customColorRed,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Terjadi Kesalahan",
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.customColorRed,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Gagal memuat data kemasan.\nSilakan coba beberapa saat lagi.",
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

          final data = snapshot.data ?? [];

          if (data.isEmpty) {
            return _buildEmptyState();
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            itemCount: data.length,
            itemBuilder: (context, index) {

              final item = data[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: AppBox.primary(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // HEADER
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
                              Icons.all_inbox_rounded,
                              color: AppColors.customColorRed,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              '${item.kodeKemasan} - ${item.namaKemasan}',
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
                        color: AppColors.customColorRed.withOpacity(0.25),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          _buildDetailRow(
                            'Jumlah Kemasan',
                            item.jumlahKemasan?.toString() ?? '0',
                          ),
                          const SizedBox(height: 8),
                          _buildDetailRow(
                            'Merek Kemasan',
                            item.merkKemasan?.isNotEmpty == true
                                ? item.merkKemasan!
                                : '-',
                          ),
                          const SizedBox(height: 8),
                          _buildDetailRow(
                            'Seri',
                            item.jenisKemasan ?? '-',
                          ),
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

  // Helper widget untuk baris detail (Konsisten dengan Dokumen Page)
  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
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
                Icons.all_inbox_outlined,
                size: 70,
                color: AppColors.customColorRed,
              ),
            ),

            const SizedBox(height: 25),

            Text(
              "Data Kemasan Tidak Ditemukan",
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.customColorRed,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "Belum terdapat data kemasan untuk CAR ini.\nSilakan periksa kembali data Anda.",
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
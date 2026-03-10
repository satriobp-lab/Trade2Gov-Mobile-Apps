import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_box_decoration.dart';
import '../../../../../../widgets/edec_loader.dart';
import 'detailsdatabarang/pibk_details_data_barang_page.dart';
import 'package:trade2gov/data/controllers/pibk/pibk_listdatabarang_controller.dart';
import 'package:trade2gov/data/models/pibk/pibk_listdatabarang_response_model.dart';


class PibkListDataBarangPage extends StatelessWidget {
  final String car;

  const PibkListDataBarangPage({
    super.key,
    required this.car,
  });

  @override
  Widget build(BuildContext context) {
    // Mock data untuk daftar barang
    final List<Map<String, String>> barangList = [
      {'serial': 'Serial 1', 'hs': '8471.49.10'},
      {'serial': 'Serial 2', 'hs': '3907.30.90'},
      {'serial': 'Serial 3', 'hs': '2915.21.00'},
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
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'PIBK List Data Barang',
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
      body: FutureBuilder<List<PibkListDataBarangResponseModel>>(
        future: PibkListDataBarangController.getListDataBarang(car),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const EdecLoader(),
                  const SizedBox(height: 12),
                  Text(
                    'Loading PIBK List Barang...',
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

          final barangList = snapshot.data ?? [];

          if (barangList.isEmpty) {
            return _buildEmptyState();
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            itemCount: barangList.length,
            itemBuilder: (context, index) {
              final item = barangList[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: AppBox.primary(),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.customColorRed.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.inventory_2_rounded,
                        color: AppColors.customColorRed,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Serial ${item.serial}',
                            style: GoogleFonts.lato(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.customColorGray,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'HS : ${item.kodeHs.isNotEmpty ? item.kodeHs : '-'}',
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              color: AppColors.customColorGray.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PibkDetailsDataBarangPage(
                              car: car,
                              serialNumber: item.serial.toString(),
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.customColorRed,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'View Details',
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
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

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon bulat
            Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.customColorRed.withOpacity(0.08),
              ),
              child: const Icon(
                Icons.inventory_2_outlined,
                size: 70,
                color: AppColors.customColorRed,
              ),
            ),

            const SizedBox(height: 25),

            // Title
            Text(
              "Data Barang Tidak Ditemukan",
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.customColorRed,
              ),
            ),

            const SizedBox(height: 10),

            // Subtitle
            Text(
              "Belum terdapat data barang untuk CAR ini.\nSilakan periksa kembali data Anda.",
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
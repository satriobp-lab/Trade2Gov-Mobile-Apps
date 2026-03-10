import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_box_decoration.dart';
import 'detailsdatabarang/peb_details_data_barang_page.dart';
import '../../../../../../widgets/edec_loader.dart';
import 'package:trade2gov/data/controllers/peb/peb_listdatabarang_controller.dart';
import 'package:trade2gov/data/models/peb/peb_listdatabarang_response_model.dart';


class PebListDataBarangPage extends StatefulWidget {
  final String car;

  const PebListDataBarangPage({
    super.key,
    required this.car,
  });

  @override
  State<PebListDataBarangPage> createState() =>
      _PebListDataBarangPageState();
}

class _PebListDataBarangPageState
    extends State<PebListDataBarangPage> {

  late Future<List<PebListDataBarangResponseModel>> _futureBarang;

  @override
  void initState() {
    super.initState();
    _futureBarang =
        PebListDataBarangController.getListDataBarang(car: widget.car);
  }

  @override
  Widget build(BuildContext context) {
    // Mock data untuk daftar barang
    final List<Map<String, String>> barangList = [
      {'serial': 'Serial 1', 'hs': '4813.10.00'},
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
              'PEB List Data Barang',
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
      body: FutureBuilder<List<PebListDataBarangResponseModel>>(
        future: _futureBarang,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const EdecLoader(),
                  const SizedBox(height: 12),
                  Text(
                    'Loading PEB List Data Barang Details...',
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
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // Icon Bulat
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.customColorRed.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.inventory_2_rounded,
                        color: AppColors.customColorRed,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Info Text (SAMA SEPERTI SEBELUMNYA)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Serial ${item.seriBrg ?? '-'}",
                            style: GoogleFonts.lato(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.customColorGray,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'HS : ${item.kodeHs ?? '-'}',
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              color: AppColors.customColorGray.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Button View Details (TETAP)
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PebDetailsDataBarangPage(
                              car: widget.car, // 🔥 kirim CAR dari halaman list
                              serialNumber: (item.seriBrg ?? '').toString(),
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.customColorRed,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
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
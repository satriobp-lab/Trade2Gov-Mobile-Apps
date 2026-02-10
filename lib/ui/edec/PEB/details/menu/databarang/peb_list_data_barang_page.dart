import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_box_decoration.dart';
import 'detailsdatabarang/peb_details_data_barang_page.dart';


class PebListDataBarangPage extends StatelessWidget {
  const PebListDataBarangPage({super.key});

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
      body: ListView.builder(
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
                // Icon Bulat untuk Nomor Serial
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

                // Info Text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['serial']!,
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.customColorGray,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'HS : ${item['hs']}',
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          color: AppColors.customColorGray.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),

                // Button View Details
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PebDetailsDataBarangPage(
                          serialNumber: item['serial']!,
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
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_box_decoration.dart';
import 'detailspeborpe/pkbe_peb_or_pe_details_page.dart';

class PkbePebOrPeListPage extends StatelessWidget {
  const PkbePebOrPeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulasi data list
    final List<Map<String, String>> pebList = [
      {
        'kpbc': '040300',
        'no_peb': '122',
        'tgl_peb': '28-10-2017',
        'dok': '1',
        'no_pe': '1',
        'tgl_pe': '28-10-2017',
        'trans': 'Y',
        'keterangan': 'Test',
      },
      {
        'kpbc': '040300',
        'no_peb': '123',
        'tgl_peb': '29-10-2017',
        'dok': '2',
        'no_pe': '2',
        'tgl_pe': '29-10-2017',
        'trans': 'N',
        'keterangan': 'Sample data 2',
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
              'PEB / PE List',
              style: GoogleFonts.lato(
                color: AppColors.customColorRed,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '060000-000398-20251217-201062',
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
        itemCount: pebList.length,
        itemBuilder: (context, index) {
          final item = pebList[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: AppBox.primary(),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. BAGIAN HEADER (Circle Icon + Info)
                Row(
                  children: [
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Data PEB #${index + 1}',
                            style: GoogleFonts.lato(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.customColorRed,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'KPBC : ${item['kpbc']}',
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              color: AppColors.customColorGray.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                Divider(color: AppColors.customColorRed.withOpacity(0.4)),
                const SizedBox(height: 12),

                // 2. BAGIAN KONTEN (Grid Field Data)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          _buildDataField('No. PEB', item['no_peb']!),
                          _buildDataField('Tgl. PEB', item['tgl_peb']!),
                          _buildDataField('Dok', item['dok']!),
                          _buildDataField('Trans', item['trans']!),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        children: [
                          _buildDataField('No. PE / PPB', item['no_pe']!),
                          _buildDataField('Tgl. PE / PPB', item['tgl_pe']!),
                          _buildDataField('Keterangan', item['keterangan']!),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                Divider(color: AppColors.customColorRed.withOpacity(0.4)),
                const SizedBox(height: 12),

                // 3. BAGIAN BUTTON (View Details di Paling Bawah)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PkbePebOrPeDetailsPage(
                            data: item, // kirim data list ke halaman detail
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.customColorRed,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'View Details',
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
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

  Widget _buildDataField(String label, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.roboto(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.customColorRed.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 1),
          Text(
            value,
            style: GoogleFonts.roboto(
              fontSize: 12,
              color: AppColors.customColorGray,
            ),
          ),
        ],
      ),
    );
  }
}
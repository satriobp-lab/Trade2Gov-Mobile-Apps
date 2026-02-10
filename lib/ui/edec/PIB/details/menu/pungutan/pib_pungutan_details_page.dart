import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_box_decoration.dart';

class PibPungutanDetailsPage extends StatelessWidget {
  const PibPungutanDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Struktur data pungutan
    final List<Map<String, dynamic>> pungutanList = [
      {
        'title': 'BM',
        'data': {
          'Dibayar': '-',
          'Ditanggung Pemerintah': '-',
          'Ditunda': '-',
          'Tidak Dipungut': '-',
          'Dibebaskan': '-',
          'Telah Dilunasi': '-',
        }
      },
      {
        'title': 'BM KITE',
        'data': {
          'Dibayar': '-',
          'Ditanggung Pemerintah': '37.298.000',
          'Ditunda': '-',
          'Tidak Dipungut': '-',
          'Dibebaskan': '-',
          'Telah Dilunasi': '-',
        }
      },
      {
        'title': 'BM Anti Dumming',
        'data': {
          'Dibayar': '-',
          'Ditanggung Pemerintah': '-',
          'Ditunda': '-',
          'Tidak Dipungut': '-',
          'Dibebaskan': '-',
          'Telah Dilunasi': '-',
        }
      },
      {
        'title': 'PPN',
        'data': {
          'Dibayar': '-',
          'Ditanggung Pemerintah': '-',
          'Ditunda': '-',
          'Tidak Dipungut': '-',
          'Dibebaskan': '-',
          'Telah Dilunasi': '-',
        }
      },
      {
        'title': 'Pph',
        'data': {
          'Dibayar': '-',
          'Ditanggung Pemerintah': '-',
          'Ditunda': '-',
          'Tidak Dipungut': '-',
          'Dibebaskan': '-',
          'Telah Dilunasi': '-',
        }
      },
      {
        'title': 'Total',
        'isTotal': true,
        'data': {
          'Dibayar': '350.798.000',
          'Ditanggung Pemerintah': '37.298.000',
          'Ditunda': '-',
          'Tidak Dipungut': '-',
          'Dibebaskan': '-',
          'Telah Dilunasi': '-',
        }
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
              'PIB Pungutan Details',
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
        itemCount: pungutanList.length,
        itemBuilder: (context, index) {
          final item = pungutanList[index];
          return _buildPungutanCard(
            title: item['title'],
            data: item['data'],
            isTotal: item['isTotal'] ?? false,
          );
        },
      ),
    );
  }

  Widget _buildPungutanCard({
    required String title,
    required Map<String, String> data,
    bool isTotal = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: AppBox.primary().copyWith(
        // Jika Total, berikan sedikit nuansa berbeda pada border
        border: isTotal
            ? Border.all(color: AppColors.customColorRed, width: 2)
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Judul Pungutan
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(
                  isTotal ? Icons.summarize_rounded : Icons.price_check_rounded,
                  color: AppColors.customColorRed,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: GoogleFonts.lato(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.customColorRed,
                  ),
                ),
              ],
            ),
          ),

          // Divider
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              height: 1.0,
              color: AppColors.customColorRed.withOpacity(0.20),
            ),
          ),

          // Body: Rincian Pungutan
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: data.entries.map((entry) {
                // Beri highlight warna hijau/merah jika ada nilainya (bukan '-')
                bool hasValue = entry.value != '-';

                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 160,
                        child: Text(
                          entry.key,
                          style: GoogleFonts.roboto(
                            fontSize: 13,
                            color: AppColors.customColorGray.withOpacity(0.8),
                          ),
                        ),
                      ),
                      Text(': ', style: TextStyle(color: AppColors.customColorGray)),
                      Expanded(
                        child: Text(
                          entry.value,
                          textAlign: TextAlign.right,
                          style: GoogleFonts.roboto(
                            fontSize: 13,
                            fontWeight: hasValue ? FontWeight.bold : FontWeight.normal,
                            color: hasValue
                                ? (isTotal ? AppColors.customColorRed : AppColors.customColorGreen)
                                : AppColors.customColorGray,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
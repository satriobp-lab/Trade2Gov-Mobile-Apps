import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_box_decoration.dart';
import '../../../../../../widgets/edec_loader.dart';
import 'package:trade2gov/data/controllers/pib/pib_pungutan_controller.dart';
import 'package:trade2gov/data/models/pib/pib_pungutan_response_model.dart';

class PibPungutanDetailsPage extends StatelessWidget {
  final String car;

  const PibPungutanDetailsPage({
    super.key,
    required this.car,
  });

  @override
  Widget build(BuildContext context) {
    // Struktur data pungutan
    final Map<String, String> pungutanCodeMap = {
      "1": "BEA MASUK",
      "10": "BMTP",
      "11": "BMIM",
      "12": "BMPB",
      "2": "PPN",
      "3": "PPNBM",
      "4": "PPH",
      "5": "CUKAI TEMBAKAU",
      "6": "MMEA",
      "7": "ETIL ALKOHOL",
      "8": "BM KITE",
      "9": "BMAD",
    };

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
      body: FutureBuilder<PibPungutanResponseModel?>(
        future: PibPungutanController.getPungutan(car.replaceAll('-', '')),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const EdecLoader(),
                  const SizedBox(height: 12),
                  Text(
                    'Loading PIB Pungutan Details...',
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

          final response = snapshot.data;

          if (response == null) {
            return const Center(child: Text("Tidak ada data"));
          }

          // final mapping
          final Map<String, String> pungutanCodeMap = {
            "1": "BEA MASUK",
            "10": "BMTP",
            "11": "BMIM",
            "12": "BMPB",
            "2": "PPN",
            "3": "PPNBM",
            "4": "PPH",
            "5": "CUKAI TEMBAKAU",
            "6": "MMEA",
            "7": "ETIL ALKOHOL",
            "8": "BM KITE",
            "9": "BMAD",
          };

          final List<Map<String, dynamic>> pungutanList = [];

          for (final entry in pungutanCodeMap.entries) {
            final code = entry.key;
            final title = entry.value;

            pungutanList.add({
              'title': title,
              'data': response.getByCode(code)?.toUiMap() ?? {
                'Dibayar': '-',
                'Ditanggung Pemerintah': '-',
                'Ditunda': '-',
                'Tidak Dipungut': '-',
                'Dibebaskan': '-',
                'Telah Dilunasi': '-',
              }
            });
          }

          // TOTAL
          pungutanList.add({
            'title': 'TOTAL',
            'isTotal': true,
            'data': response.getByCode('TOTAL')?.toUiMap() ?? {
              'Dibayar': '-',
              'Ditanggung Pemerintah': '-',
              'Ditunda': '-',
              'Tidak Dipungut': '-',
              'Dibebaskan': '-',
              'Telah Dilunasi': '-',
            }
          });

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            itemCount: pungutanList.length,
            itemBuilder: (context, index) {
              final item = pungutanList[index];

              return _buildPungutanCard(
                title: item['title'] as String,
                data: Map<String, String>.from(item['data'] as Map),
                isTotal: (item['isTotal'] ?? false) as bool,
              );
            },
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
                // green or red highlight
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
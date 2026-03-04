import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_box_decoration.dart';
import 'package:trade2gov/data/controllers/pibk/pibk_pungutan_controller.dart';
import 'package:trade2gov/data/models/pibk/pibk_pungutan_response_model.dart';

class PibkPungutanDetailsPage extends StatelessWidget {
  final String car;

  const PibkPungutanDetailsPage({
    super.key,
    required this.car,
  });

  @override
  Widget build(BuildContext context) {
    Map<String, String> pungutanDescription = {
      "1": "BEA MASUK",
      "2": "PPN",
      "3": "PPNBM",
      "4": "PPH",
      "5": "CUKAI TEMBAKAU",
      "6": "MMEA",
      "7": "ETIL ALKOHOL",
      "8": "BM KITE",
      "9": "BMAD",
      "10": "BMTP",
      "11": "BMIM",
      "12": "BMPB",
    };
    // Struktur data pungutan
    final List<Map<String, dynamic>> pungutanList = [
      {
        'title': 'BM',
        'data': {
          'Nilai': '614.000',
        }
      },
      {
        'title': 'BM Anti Dumping',
        'data': {
          'Nilai': '2.513.000',
        }
      },
      {
        'title': 'Cukai Minuman',
        'data': {
          'Nilai': '696.986',
        }
      },
      {
        'title': 'Total',
        'isTotal': true,
        'data': {
          'Total Pungutan': '3.823.986',
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
              'PIBK Pungutan Details',
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
      body: FutureBuilder<PibkPungutanResponseModel?>(
        future: PibkPungutanController.getPungutan(car),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final data = snapshot.data;

          if (data == null) {
            return _buildEmptyState();
          }

          if (data.pungutanMap.isEmpty || data.total == 0) {
            return _buildEmptyState();
          }

          final List<Map<String, dynamic>> pungutanList = [];

          data.pungutanMap.forEach((code, value) {
            pungutanList.add({
              'title': pungutanDescription[code] ?? code,
              'data': {
                'Nilai': _formatRupiah(value),
              }
            });
          });

          // Tambahkan TOTAL
          pungutanList.add({
            'title': 'Total',
            'isTotal': true,
            'data': {
              'Total Pungutan': _formatRupiah(data.total),
            }
          });

          return ListView.builder(
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

  String _formatRupiah(int value) {
    return value
        .toString()
        .replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
          (match) => '.',
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
                Icons.price_check_outlined,
                size: 70,
                color: AppColors.customColorRed,
              ),
            ),
            const SizedBox(height: 25),
            Text(
              "Pungutan Tidak Ditemukan",
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.customColorRed,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Belum terdapat data pungutan untuk CAR ini.\nSilakan periksa kembali data Anda.",
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
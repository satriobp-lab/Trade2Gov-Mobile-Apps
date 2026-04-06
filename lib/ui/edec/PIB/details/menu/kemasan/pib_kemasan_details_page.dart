import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../widgets/edec_loader.dart';
import '../../../../../../utils/app_box_decoration.dart';
import '../../../../../../data/controllers/pib/pib_kemasan_controller.dart';
import '../../../../../../data/models/pib/pib_kemasan_response_model.dart';

class PibKemasanDetailsPage extends StatefulWidget {
  final String car;

  const PibKemasanDetailsPage({
    super.key,
    required this.car,
  });

  @override
  State<PibKemasanDetailsPage> createState() =>
      _PibKemasanDetailsPageState();
}

class _PibKemasanDetailsPageState extends State<PibKemasanDetailsPage> {

  late Future<List<PibKemasanResponseModel>> _futureKemasan;

  @override
  void initState() {
    super.initState();
    _futureKemasan =
        PibKemasanController.getKemasan(widget.car.replaceAll('-', ''));
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
        toolbarHeight: 80,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'PIB Kemasan Details',
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
      body: FutureBuilder<List<PibKemasanResponseModel>>(
        future: _futureKemasan,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const EdecLoader(),
                  const SizedBox(height: 12),
                  Text(
                    'Loading PIB Kemasan...',
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

          final kemasanList = snapshot.data ?? [];

          if (kemasanList.isEmpty) {
            return const Center(child: Text("Tidak ada data kemasan"));
          }

          return ListView.builder(
            padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            itemCount: kemasanList.length,
            itemBuilder: (context, index) {
              final item = kemasanList[index];

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
                              '${item.jenisKemasan} - ${item.namaKemasan}',
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
                      padding:
                      const EdgeInsets.symmetric(horizontal: 16),
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
                              'Jumlah Kemasan', item.jumlahDisplay),
                          const SizedBox(height: 8),
                          _buildDetailRow(
                              'Merek Kemasan', item.formattedMerk),
                          const SizedBox(height: 8),
                          _buildDetailRow(
                              'Seri', item.seriDisplay),
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
}
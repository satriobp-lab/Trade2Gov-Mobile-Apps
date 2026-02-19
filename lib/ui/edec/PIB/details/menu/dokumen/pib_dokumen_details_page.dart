import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_box_decoration.dart';
import 'package:trade2gov/data/controllers/pib/pib_dokumen_controller.dart';
import 'package:trade2gov/data/models/pib/pib_dokumen_response_model.dart';

class PibDokumenDetailsPage extends StatefulWidget {
  final String car;

  const PibDokumenDetailsPage({
    super.key,
    required this.car,
  });

  @override
  State<PibDokumenDetailsPage> createState() =>
      _PibDokumenDetailsPageState();
}

class _PibDokumenDetailsPageState extends State<PibDokumenDetailsPage> {

  late Future<List<PibDokumenResponseModel>> _futureDokumen;

  @override
  void initState() {
    super.initState();
    _futureDokumen =
        PibDokumenController.getDokumen(widget.car);
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
              'PIB Dokumen Details',
              style: GoogleFonts.lato(
                color: AppColors.customColorRed,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.car, // ✅ tampilkan CAR asli
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
      body: FutureBuilder<List<PibDokumenResponseModel>>(
        future: _futureDokumen,
        builder: (context, snapshot) {

          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
                child: Text("Error: ${snapshot.error}"));
          }

          final dokumenList = snapshot.data ?? [];

          if (dokumenList.isEmpty) {
            return const Center(
                child: Text("Tidak ada dokumen"));
          }

          // 🔥 UI SAMA PERSIS seperti sebelumnya
          return ListView.builder(
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 20),
            itemCount: dokumenList.length,
            itemBuilder: (context, index) {
              final item = dokumenList[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: AppBox.primary(),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    // ICON + TITLE
                    Padding(
                      padding:
                      const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration:
                            BoxDecoration(
                              color: AppColors
                                  .customColorRed
                                  .withOpacity(0.1),
                              shape:
                              BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons
                                  .description_rounded,
                              color: AppColors
                                  .customColorRed,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              '${item.kode} - ${item.jenis}',
                              style:
                              GoogleFonts.lato(
                                fontSize: 15,
                                fontWeight:
                                FontWeight
                                    .bold,
                                color: AppColors
                                    .customColorRed,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Divider
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(
                          horizontal: 16),
                      child: Container(
                        height: 1.2,
                        color: AppColors
                            .customColorRed
                            .withOpacity(0.25),
                      ),
                    ),

                    // Detail Section
                    Padding(
                      padding:
                      const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                        children: [
                          _buildDetailRow(
                              'Nomor Dokumen',
                              item.nomor),
                          const SizedBox(
                              height: 8),
                          _buildDetailRow(
                              'Tanggal Dokumen',
                              item.tanggal),
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

  Widget _buildDetailRow(
      String label, String value) {
    return Row(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(
            label,
            style: GoogleFonts.roboto(
              fontSize: 13,
              color:
              AppColors.customColorGray,
            ),
          ),
        ),
        Text(
          ': ',
          style: GoogleFonts.roboto(
            fontSize: 13,
            color:
            AppColors.customColorGray,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.roboto(
              fontSize: 13,
              color:
              AppColors.customColorGray,
            ),
          ),
        ),
      ],
    );
  }
}

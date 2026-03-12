import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_box_decoration.dart';
import 'detailsdatabarang/peb_details_data_barang_page.dart';
import '../../../../../../widgets/edec_loader.dart';
import '../../../../../../widgets/animated_inverse_red_button.dart';
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

  int _currentPage = 0;
  final int _rowsPerPage = 10;

  @override
  void initState() {
    super.initState();
    _futureBarang =
        PebListDataBarangController.getListDataBarang(car: widget.car);
  }

  List<PebListDataBarangResponseModel> _getPagedData(
      List<PebListDataBarangResponseModel> data) {
    final start = _currentPage * _rowsPerPage;
    final end = start + _rowsPerPage;

    if (start >= data.length) return [];

    return data.sublist(
      start,
      end > data.length ? data.length : end,
    );
  }

  Widget _buildPagination(int totalData) {
    final totalPage = (totalData / _rowsPerPage).ceil();

    if (totalPage <= 1) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 10, 25, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          /// PREVIOUS
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: _currentPage > 0
                  ? () {
                setState(() {
                  _currentPage--;
                });
              }
                  : null,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                child: Row(
                  children: [
                    Icon(
                      Icons.chevron_left_rounded,
                      color: _currentPage > 0
                          ? AppColors.customColorRed
                          : Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "Previous",
                      style: GoogleFonts.lato(
                        color: _currentPage > 0
                            ? AppColors.customColorRed
                            : Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// PAGE INDICATOR
          Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.customColorRed.withOpacity(0.5),
              ),
            ),
            child: Text(
              "Page ${_currentPage + 1} / $totalPage",
              style: GoogleFonts.lato(
                fontWeight: FontWeight.bold,
                color: AppColors.customColorRed,
              ),
            ),
          ),

          /// NEXT
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: (_currentPage + 1) < totalPage
                  ? () {
                setState(() {
                  _currentPage++;
                });
              }
                  : null,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                child: Row(
                  children: [
                    Text(
                      "Next",
                      style: GoogleFonts.lato(
                        color: (_currentPage + 1) < totalPage
                            ? AppColors.customColorRed
                            : Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: (_currentPage + 1) < totalPage
                          ? AppColors.customColorRed
                          : Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
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

          final allData = snapshot.data ?? [];
          final data = _getPagedData(allData);

          if (allData.isEmpty) {
            return _buildEmptyState();
          }

          return Column(
            children: [

              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 20),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final item = data[index];

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
                              color: AppColors.customColorRed
                                  .withOpacity(0.1),
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
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
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
                                    color: AppColors.customColorGray
                                        .withOpacity(0.7),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          AnimatedInverseRedButton(
                            width: 110,
                            height: 34,
                            text: "View Details",
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PebDetailsDataBarangPage(
                                        car: widget.car,
                                        serialNumber:
                                        (item.seriBrg ?? '')
                                            .toString(),
                                      ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              _buildPagination(allData.length),
            ],
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
            Text(
              "Data Barang Tidak Ditemukan",
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.customColorRed,
              ),
            ),
            const SizedBox(height: 10),
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
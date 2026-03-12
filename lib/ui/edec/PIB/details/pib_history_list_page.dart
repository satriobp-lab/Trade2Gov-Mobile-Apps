import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_box_decoration.dart';
import 'menu/pib_details_menu_page.dart';
import '../../../../widgets/edec_loader.dart';
import '../../../../widgets/animated_inverse_red_button.dart';
import 'package:trade2gov/data/controllers/pib/pib_historylist_controller.dart';
import 'package:trade2gov/data/models/pib/pib_historylist_response_model.dart';


class PibHistoryListPage extends StatefulWidget {
  const PibHistoryListPage({super.key});

  @override
  State<PibHistoryListPage> createState() => _PibHistoryListPageState();
}

class _PibHistoryListPageState extends State<PibHistoryListPage> {
  final TextEditingController _searchController = TextEditingController();

  late Future<List<PibHistoryListResponseModel>> _futurePib;

  List<PibHistoryListResponseModel> _allData = [];
  List<PibHistoryListResponseModel> _filteredData = [];

  int _currentPage = 0;
  final int _rowsPerPage = 10;

  @override
  void initState() {
    super.initState();
    // ⛔ Sembunyikan navigation bar bawah (immersive mode)
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _futurePib = PibHistoryListController.getPibHistory().then((value) {
      _allData = value;
      _filteredData = value;
      return value;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    // ✅ Kembalikan navigation bar saat keluar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
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
        title: Text(
          'PIB History List',
          style: GoogleFonts.lato(
            color: AppColors.customColorRed,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
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
      body: FutureBuilder<List<PibHistoryListResponseModel>>(
        future: _futurePib,
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const EdecLoader(),
                  const SizedBox(height: 12),
                  Text(
                    'Loading PIB history...',
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
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }

          if (_allData.isEmpty) {
            _allData = snapshot.data ?? [];
            _filteredData = _allData;
          }

          /// Kondisi 1: API kosong dari awal
          if (_allData.isEmpty) {
            return _buildInitialEmptyState();
          }

          /// Kondisi 2: hasil search kosong
          if (_filteredData.isEmpty) {
            return _buildEmptyState();
          }

          final data = _getPagedData();

          return Column(
            children: [

              /// ✅ Search muncul hanya setelah load selesai
              _buildSearchBar(),

              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final item = data[index];
                    return _buildHistoryCard(item);
                  },
                ),
              ),
              _buildPagination(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHistoryCard(PibHistoryListResponseModel item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: AppBox.primary(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Nomor Dokumen & Icon Box
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  item.noAju,
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.customColorRed,
                  ),
                ),
              ),
              const Icon(Icons.inventory_2_rounded,
                  color: AppColors.customColorRed, size: 22),
            ],
          ),
          const SizedBox(height: 8),

          // Kantor & Deskripsi
          Text(
            '${item.kdKpbc ?? '-'} > ${item.urKpbc ?? '-'}',
            style: GoogleFonts.roboto(
              fontSize: 13,
              color: AppColors.customColorGray.withOpacity(0.8),
            ),
          ),

          const SizedBox(height: 8),
          // Kantor & Deskripsi
          Text(
            toTitleCase(item.indNama ?? '-'),
            style: GoogleFonts.roboto(
              fontSize: 13,
              color: AppColors.customColorGray.withOpacity(0.8),
            ),
          ),

          // const Divider(height: 20, thickness: 0.8),
          //divider beda warna
          Divider(
            height: 20,
            thickness: 0.8,
            color: AppColors.customColorRed.withOpacity(0.6),
          ),


          // Detail Info (Date, Barang, Container)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoItem(Icons.calendar_today_rounded, item.tglAju ?? '-'),
              _buildInfoItem(Icons.bar_chart_outlined, 'Barang: ${item.jmBrg}'),
              _buildInfoItem(Icons.local_shipping_rounded, 'Container: ${item.jmCont}'),
            ],
          ),
          const SizedBox(height: 15),

          // Action Button
          SizedBox(
            width: double.infinity,
            child: AnimatedInverseRedButton(
              width: double.infinity,
              height: 38,
              text: "View Details",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PibDetailsMenuPage(
                      car: item.noAju,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.customColorGray.withOpacity(0.7)),
        const SizedBox(width: 5),
        Text(
          label,
          style: GoogleFonts.roboto(
            fontSize: 12,
            color: AppColors.customColorGray,
          ),
        ),
      ],
    );
  }

  void _applyFlexibleSearch(String keyword) {
    final query = keyword.trim().toLowerCase();

    setState(() {
      _currentPage = 0;

      if (query.isEmpty) {
        _filteredData = _allData;
      } else {
        _filteredData = _allData.where((item) {
          final noAju = (item.noAju ?? '').toLowerCase();
          final car = (item.car ?? '').toLowerCase();
          final pibNo = (item.pibNo ?? '').toLowerCase();
          final pibTg = (item.pibTg ?? '').toLowerCase();
          final tglAju = (item.tglAju ?? '').toLowerCase();
          final kdKpbc = (item.kdKpbc ?? '').toLowerCase();

          return noAju.contains(query) ||
              car.contains(query) ||
              pibNo.contains(query) ||
              pibTg.contains(query) ||
              tglAju.contains(query) ||
              kdKpbc.contains(query);
        }).toList();
      }
    });
  }


  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 20, 25, 10),
      child: Container(
        decoration: AppBox.primary().copyWith(
          color: AppColors.whiteColor,
        ),
        child: TextField(
          controller: _searchController,
          style: GoogleFonts.roboto(fontSize: 14),
          onChanged: _applyFlexibleSearch,
          onSubmitted: _applyFlexibleSearch,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: 'Cari nomor dokumen...',
            hintStyle: GoogleFonts.roboto(
              color: AppColors.customColorGray.withOpacity(0.5),
              fontSize: 14,
            ),
            prefixIcon: const Icon(
              Icons.search_rounded,
              color: AppColors.customColorRed,
            ),
            border: InputBorder.none,
            contentPadding:
            const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ),
    );
  }

  //helper
  String toTitleCase(String text) {
    if (text.isEmpty) return text;

    return text
        .toLowerCase()
        .split(' ')
        .map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1);
    })
        .join(' ');
  }

  List<PibHistoryListResponseModel> _getPagedData() {
    final start = _currentPage * _rowsPerPage;
    final end = start + _rowsPerPage;

    if (start >= _filteredData.length) return [];

    return _filteredData.sublist(
      start,
      end > _filteredData.length ? _filteredData.length : end,
    );
  }

  Widget _buildPagination() {
    final totalPage = (_filteredData.length / _rowsPerPage).ceil();

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
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
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
              child: Icon(
                Icons.inventory_2_outlined,
                size: 70,
                color: AppColors.customColorRed,
              ),
            ),

            const SizedBox(height: 25),

            Text(
              "Data PIB Tidak Ditemukan",
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.customColorRed,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "Tidak ada data PIB yang sesuai dengan pencarian.\nSilakan periksa kembali kata kunci Anda.",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: 13,
                color: AppColors.customColorGray,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: 160,
              height: 40,
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {

                    /// reset search
                    _searchController.clear();

                    /// reset pagination
                    _currentPage = 0;

                    /// fetch ulang data
                    _futurePib = PibHistoryListController.getPibHistory().then((value) {
                      _allData = value;
                      _filteredData = value;
                      return value;
                    });

                  });
                },
                icon: const Icon(Icons.refresh_rounded, size: 18),
                label: const Text("Refresh"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.customColorRed,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialEmptyState() {
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
              "Belum Ada Data PIB",
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.customColorRed,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "Saat ini belum terdapat data PIB yang tersedia.\nSilakan cek kembali secara berkala.",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: 13,
                color: AppColors.customColorGray,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: 160,
              height: 40,
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _futurePib = PibHistoryListController.getPibHistory().then((value) {
                      _allData = value;
                      _filteredData = value;
                      return value;
                    });
                  });
                },
                icon: const Icon(Icons.refresh_rounded, size: 18),
                label: const Text("Refresh"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.customColorRed,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


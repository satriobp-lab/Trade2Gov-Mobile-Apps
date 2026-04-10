import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_box_decoration.dart';
import 'menu/pibk_details_menu_page.dart';
import '../../../../widgets/network_edec_state_widget.dart';
import '../../../../../../widgets/edec_loader.dart';
import '../../../../widgets/animated_inverse_red_button.dart';
import 'package:trade2gov/data/controllers/pibk/pibk_historylist_controller.dart';
import 'package:trade2gov/data/models/pibk/pibk_historylist_response_model.dart';

class PibkHistoryListPage extends StatefulWidget {
  const PibkHistoryListPage({super.key});

  @override
  State<PibkHistoryListPage> createState() => _PibkHistoryListPageState();
}

class _PibkHistoryListPageState extends State<PibkHistoryListPage> {
  late Future<List<PibkHistoryListResponseModel>> _futurePibk;

  List<PibkHistoryListResponseModel> _allData = [];
  List<PibkHistoryListResponseModel> _filteredData = [];

  int _currentPage = 0;
  final int _rowsPerPage = 10;

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    _futurePibk = PibkHistoryListController.getPibkHistory().then((value) {
      _allData = value;
      _filteredData = value;
      return value;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  void _search(String keyword) {
    setState(() {
      if (keyword.isEmpty) {
        _filteredData = _allData;
      } else {
        _filteredData = _allData.where((item) {
          return item.car.toLowerCase().contains(keyword.toLowerCase());
        }).toList();
      }
    });
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
          'PIBK History List',
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
      body: FutureBuilder<List<PibkHistoryListResponseModel>>(
        future: _futurePibk,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return NetworkEdecStateWidget(
              isLoading: true,
              isNoInternet: false,
              loadingText: "Loading PIBK history...",
              onRetry: () {},
              child: const SizedBox(),
            );
          }

          if (snapshot.hasError) {
            return NetworkEdecStateWidget(
              isLoading: false,
              isNoInternet: true,
              onRetry: () {
                setState(() {
                  _futurePibk = PibkHistoryListController.getPibkHistory().then((value) {
                    _allData = value;
                    _filteredData = value;
                    return value;
                  });
                });
              },
              child: const SizedBox(),
            );
          }

          /// isi data dari snapshot
          if (_allData.isEmpty) {
            _allData = snapshot.data ?? [];
            _filteredData = _allData;
          }

          /// kalau tetap kosong baru tampilkan empty state
          /// Kondisi 1: API kosong dari awal
          if (_allData.isEmpty) {
            return _buildInitialEmptyState();
          }

          /// Kondisi 2: hasil search kosong
          if (_filteredData.isEmpty) {
            return _buildEmptyState();
          }

          return Column(
            children: [
              _buildSearchBar(),
              Expanded(
                child: _filteredData.isEmpty && _allData.isNotEmpty
                    ? _buildEmptyState()
                    : Builder(
                  builder: (context) {
                    final pageData = _getPagedData();

                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      itemCount: pageData.length,
                      itemBuilder: (context, index) {
                        final item = pageData[index];
                        return _buildHistoryCard(item);
                      },
                    );
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

  Widget _buildHistoryCard(PibkHistoryListResponseModel item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: AppBox.primary(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nomor Dokumen
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  item.car,
                  style: GoogleFonts.roboto(
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

          // Kantor
          Text(
            '${item.kdKpbc ?? '-'} > ${item.urKpbc ?? '-'}',
            style: GoogleFonts.roboto(
              fontSize: 13,
              color: AppColors.customColorGray,
            ),
          ),

          const SizedBox(height: 8),

          // Nama Importir
          Text(
            toTitleCase(
              item.impNama?.isNotEmpty == true ? item.impNama! : '-',
            ),
            style: GoogleFonts.roboto(
              fontSize: 13,
              color: AppColors.customColorGray,
            ),
          ),

          Divider(
            height: 20,
            thickness: 0.8,
            color: AppColors.customColorRed.withOpacity(0.6),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoItem(
                Icons.calendar_today_rounded,
                item.tanggal ?? '-',
              ),
              _buildInfoItem(
                Icons.bar_chart_outlined,
                'Barang: ${item.jmBrg ?? 0}',
              ),
            ],
          ),

          const SizedBox(height: 15),

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
                    builder: (context) => PibkDetailsMenuPage(
                      car: item.car,
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

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            /// ICON
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

            /// TITLE
            Text(
              "Data PIBK Tidak Ditemukan",
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.customColorRed,
              ),
            ),

            const SizedBox(height: 10),

            /// DESCRIPTION
            Text(
              "Tidak ada data PIBK yang sesuai dengan pencarian.\nSilakan periksa kembali kata kunci Anda.",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: 13,
                color: AppColors.customColorGray,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 25),

            /// REFRESH BUTTON
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
                    _futurePibk =
                        PibkHistoryListController.getPibkHistory().then((value) {
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

  String toTitleCase(String text) {
    if (text.isEmpty) return text;

    return text
        .toLowerCase()
        .split(' ')
        .map((word) =>
    word.isEmpty ? word : word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  void _applyFlexibleSearch(String keyword) {
    final query = keyword.trim().toLowerCase();

    setState(() {
      _currentPage = 0;

      if (query.isEmpty) {
        _filteredData = _allData;
      } else {
        _filteredData = _allData.where((item) {
          final car = (item.car ?? '').toLowerCase();                 // Nomor Aju (CAR)
          final noDaftar = (item.kdKpbc ?? '').toLowerCase();       // Nomor Daftar
          final tglDaftar = (item.tanggal ?? '').toLowerCase();       // Tanggal Daftar

          return car.contains(query) ||
              noDaftar.contains(query) ||
              tglDaftar.contains(query);
        }).toList();
      }
    });
  }

  List<PibkHistoryListResponseModel> _getPagedData() {
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
              "Belum Ada Data PIBK",
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.customColorRed,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "Saat ini belum terdapat data PIBK yang tersedia.\nSilakan cek kembali secara berkala.",
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
                    _futurePibk =
                        PibkHistoryListController.getPibkHistory().then((value) {
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
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_box_decoration.dart';
import 'menu/pibk_details_menu_page.dart';
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
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (_allData.isEmpty) {
            return _buildEmptyState();
          }

          return Column(
            children: [
              _buildSearchBar(),
              Expanded(
                child: _filteredData.isEmpty
                    ? _buildEmptySearchState()
                    : ListView.builder(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  itemCount: _filteredData.length,
                  itemBuilder: (context, index) {
                    final item = _filteredData[index];
                    return _buildHistoryCard(item);
                  },
                ),
              ),
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

          // Nama Importir (tidak caps semua)
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
            height: 38,
            child: ElevatedButton(
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
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.customColorRed,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'View Details',
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
          style: GoogleFonts.roboto(fontSize: 14), // ✅ Sama seperti PEB
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inventory_2_outlined,
              size: 70,
              color: AppColors.customColorRed),
          const SizedBox(height: 20),
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
            "Data PIBK yang Anda ajukan akan muncul di sini.",
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              fontSize: 13,
              color: AppColors.customColorGray,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptySearchState() {
    return const Center(
      child: Text("Data tidak ditemukan"),
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
}
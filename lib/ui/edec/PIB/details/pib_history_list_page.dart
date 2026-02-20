import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_box_decoration.dart';
import 'menu/pib_details_menu_page.dart';
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

  final TextEditingController _noAjuController = TextEditingController();
  final TextEditingController _pibNoController = TextEditingController();
  final TextEditingController _pibTgController = TextEditingController();

  List<PibHistoryListResponseModel> _allData = [];
  List<PibHistoryListResponseModel> _filteredData = [];

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
      body: Column(
        children: [
          // 🔍 Search Bar Section
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 20, 25, 10),
            child: Container(
              decoration: AppBox.primary().copyWith(
                color: AppColors.whiteColor,
              ),
              child: TextField(
                controller: _searchController,
                style: GoogleFonts.roboto(fontSize: 14),
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
                  // ICON ENTER
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.send_outlined,
                      color: AppColors.customColorRed,
                    ),
                    onPressed: () {
                      final keyword = _searchController.text;
                      _applyFlexibleSearch(keyword);
                    },
                  ),


                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  // Enter dari keyboard juga jalan
                  _applyFlexibleSearch(value);
                },
              ),
            ),
          ),

          // 📄 List of History
          Expanded(
            child: FutureBuilder<List<PibHistoryListResponseModel>>(
              future: _futurePib,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
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

                final data = _filteredData;


                if (data.isEmpty) {
                  return const Center(child: Text("Tidak ada data"));
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final item = data[index];
                    return _buildHistoryCard(item);
                  },
                );
              },
            ),
          ),
        ],
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
            height: 38,
            child: ElevatedButton(
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
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.customColorRed,
                elevation: 0,
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
      if (query.isEmpty) {
        _filteredData = _allData;
      } else {
        _filteredData = _allData.where((item) {
          final noAjuMatch =
          item.noAju.toLowerCase().contains(query);

          final pibNoMatch =
          (item.pibNo ?? '').toLowerCase().contains(query);

          final pibTgMatch =
          (item.pibTg ?? '').toLowerCase().contains(query);

          return noAjuMatch || pibNoMatch || pibTgMatch;
        }).toList();
      }
    });
  }


  Widget _buildSearchField(
      TextEditingController controller, String hint) {
    return Container(
      decoration: AppBox.primary().copyWith(
        color: AppColors.whiteColor,
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: AppColors.customColorRed,
          ),
          border: InputBorder.none,
          contentPadding:
          const EdgeInsets.symmetric(vertical: 12),
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

}
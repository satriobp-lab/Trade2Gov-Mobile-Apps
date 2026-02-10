import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_box_decoration.dart';
import 'menu/pkbe_details_menu_page.dart';

class PkbeHistoryListPage extends StatefulWidget {
  const PkbeHistoryListPage({super.key});

  @override
  State<PkbeHistoryListPage> createState() => _PkbeHistoryListPageState();
}

class _PkbeHistoryListPageState extends State<PkbeHistoryListPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // ⛔ Sembunyikan navigation bar bawah (immersive mode)
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
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
          'PKBE History List',
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
                      // TODO: panggil fungsi search
                      debugPrint('Search: $keyword');
                    },
                  ),

                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  // Enter dari keyboard juga jalan
                  debugPrint('Search submit: $value');
                },
              ),
            ),
          ),

          // 📄 List of History
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: 5, // Contoh jumlah data
              itemBuilder: (context, index) {
                return _buildHistoryCard();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryCard() {
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
                  '060000-000398-20251217-201062',
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

          // Kantor & Deskripsi
          Text(
            '040300 > KPU Tanjung Priok',
            style: GoogleFonts.roboto(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.customColorGray,
            ),
          ),

          const SizedBox(height: 8),
          // Kantor & Deskripsi
          Text(
            'Daicel Corporation',
            style: GoogleFonts.roboto(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.customColorGray,
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
              _buildInfoItem(Icons.calendar_today_rounded, '17-12-2025'),
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
                    builder: (context) => const PkbeDetailsMenuPage(),
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
}
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_box_decoration.dart';
import 'menu/peb_details_menu_page.dart';
import '../../../../widgets/edec_loader.dart';
import 'package:trade2gov/data/controllers/peb/peb_historylist_controller.dart';
import 'package:trade2gov/data/models/peb/peb_historylist_response_model.dart';


class PebHistoryListPage extends StatefulWidget {
  const PebHistoryListPage({super.key});

  @override
  State<PebHistoryListPage> createState() => _PebHistoryListPageState();
}

class _PebHistoryListPageState extends State<PebHistoryListPage> {
  final TextEditingController _searchController = TextEditingController();

  late Future<List<PebHistoryListResponseModel>> _futurePeb;
  List<PebHistoryListResponseModel> _allData = [];
  List<PebHistoryListResponseModel> _filteredData = [];

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    _futurePeb = PebHistoryListController.getPebHistory().then((value) {
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
          'PEB History List',
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
      body: FutureBuilder<List<PebHistoryListResponseModel>>(
        future: _futurePeb,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const EdecLoader(),
                  const SizedBox(height: 12),
                  Text(
                    'Loading PEB history...',
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

          final data = _filteredData;

          if (data.isEmpty) {
            return _buildEmptyState();
          }

          return Column(
            children: [
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
            ],
          );
        },
      ),
    );
  }

  Widget _buildHistoryCard(PebHistoryListResponseModel item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: AppBox.primary(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Nomor Dokumen
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  item.noAju,
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
            '${item.kdKtr ?? '-'} > ${item.urKtr ?? '-'}',
            style: GoogleFonts.roboto(
              fontSize: 13,
              color: AppColors.customColorGray.withOpacity(0.8),
            ),
          ),

          const SizedBox(height: 8),

          // Nama Exportir
          Text(
            toTitleCase(item.namaEks?.isNotEmpty == true
                ? item.namaEks!
                : '-'),
            style: GoogleFonts.roboto(
              fontSize: 13,
              color: AppColors.customColorGray.withOpacity(0.8),
            ),
          ),

          Divider(
            height: 20,
            thickness: 0.8,
            color: AppColors.customColorRed.withOpacity(0.6),
          ),

          // Detail Info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoItem(
                Icons.calendar_today_rounded,
                item.tglAju ?? '-',
              ),
              _buildInfoItem(
                Icons.bar_chart_outlined,
                'Barang: ${item.jmBrg}',
              ),
              _buildInfoItem(
                Icons.local_shipping_rounded,
                'Container: ${item.jmCont}',
              ),
            ],
          ),

          const SizedBox(height: 15),

          // Button
          SizedBox(
            width: double.infinity,
            height: 38,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PebDetailsMenuPage(
                      car: item.car ?? '',
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

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Circle Background
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
              "Belum Ada Data PEB",
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.customColorRed,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "Data PEB yang Anda ajukan akan muncul di sini.\nSilakan lakukan pengajuan terlebih dahulu.",
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
                    _futurePeb =
                        PebHistoryListController.getPebHistory();
                  });
                },
                icon: const Icon(Icons.refresh_rounded, size: 18),
                label: const Text("Refresh"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.customColorRed,
                  foregroundColor: Colors.white, // <-- ini bikin icon + text putih
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
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
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

  void _applyFlexibleSearch(String keyword) {
    final query = keyword.trim().toLowerCase();

    setState(() {
      if (query.isEmpty) {
        _filteredData = _allData;
      } else {
        _filteredData = _allData.where((item) {
          final noAju = (item.noAju ?? '').toLowerCase();   // Nomor Aju
          final car = (item.car ?? '').toLowerCase();       // CAR
          final tglAju = (item.tglAju ?? '').toLowerCase(); // Tanggal Aju
          final kdKtr = (item.kdKtr ?? '').toLowerCase();   // Kantor (opsional)

          return noAju.contains(query) ||
              car.contains(query) ||
              tglAju.contains(query) ||
              kdKtr.contains(query);
        }).toList();
      }
    });
  }
}

//dibawah ini belum ada data apinya.
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter/services.dart';
// import '../../../../utils/app_colors.dart';
// import '../../../../utils/app_box_decoration.dart';
// import 'menu/peb_details_menu_page.dart';
//
// class PebHistoryListPage extends StatefulWidget {
//   const PebHistoryListPage({super.key});
//
//   @override
//   State<PebHistoryListPage> createState() => _PebHistoryListPageState();
// }
//
// class _PebHistoryListPageState extends State<PebHistoryListPage> {
//   final TextEditingController _searchController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     // ⛔ Sembunyikan navigation bar bawah (immersive mode)
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
//   }
//
//   @override
//   void dispose() {
//     _searchController.dispose();
//     // ✅ Kembalikan navigation bar saat keluar
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.whiteColor,
//       appBar: AppBar(
//         backgroundColor: AppColors.whiteColor,
//         elevation: 0,
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new_rounded,
//               color: AppColors.customColorRed),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           'PEB History List',
//           style: GoogleFonts.lato(
//             color: AppColors.customColorRed,
//             fontWeight: FontWeight.bold,
//             fontSize: 22,
//           ),
//         ),
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(1.0),
//           child: Container(
//             color: AppColors.customColorRed.withOpacity(0.3),
//             height: 1.0,
//             margin: const EdgeInsets.symmetric(horizontal: 25),
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           // 🔍 Search Bar Section
//           Padding(
//             padding: const EdgeInsets.fromLTRB(25, 20, 25, 10),
//             child: Container(
//               decoration: AppBox.primary().copyWith(
//                 color: AppColors.whiteColor,
//               ),
//               child: TextField(
//                 controller: _searchController,
//                 style: GoogleFonts.roboto(fontSize: 14),
//                 decoration: InputDecoration(
//                   hintText: 'Cari nomor dokumen...',
//                   hintStyle: GoogleFonts.roboto(
//                     color: AppColors.customColorGray.withOpacity(0.5),
//                     fontSize: 14,
//                   ),
//                   prefixIcon: const Icon(
//                     Icons.search_rounded,
//                     color: AppColors.customColorRed,
//                   ),
//                   // ICON ENTER
//                   suffixIcon: IconButton(
//                     icon: const Icon(
//                       Icons.send_outlined,
//                       color: AppColors.customColorRed,
//                     ),
//                     onPressed: () {
//                       final keyword = _searchController.text;
//                       // TODO: panggil fungsi search
//                       debugPrint('Search: $keyword');
//                     },
//                   ),
//
//                   border: InputBorder.none,
//                   contentPadding: const EdgeInsets.symmetric(vertical: 12),
//                 ),
//                 textInputAction: TextInputAction.search,
//                 onSubmitted: (value) {
//                   // Enter dari keyboard juga jalan
//                   debugPrint('Search submit: $value');
//                 },
//               ),
//             ),
//           ),
//
//           // 📄 List of History
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               itemCount: 5, // Contoh jumlah data
//               itemBuilder: (context, index) {
//                 return _buildHistoryCard();
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildHistoryCard() {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 15),
//       padding: const EdgeInsets.all(16),
//       decoration: AppBox.primary(),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header: Nomor Dokumen & Icon Box
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Text(
//                   '301019-9CB5DF-20251007-000009',
//                   style: GoogleFonts.roboto(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.customColorRed,
//                   ),
//                 ),
//               ),
//               const Icon(Icons.inventory_2_rounded,
//                   color: AppColors.customColorRed, size: 22),
//             ],
//           ),
//           const SizedBox(height: 8),
//
//           // Kantor & Deskripsi
//           Text(
//             '040300 > KPU Tanjung Priok',
//             style: GoogleFonts.roboto(
//               fontSize: 13,
//               fontWeight: FontWeight.w500,
//               color: AppColors.customColorGray,
//             ),
//           ),
//
//           const SizedBox(height: 8),
//           // Kantor & Deskripsi
//           Text(
//             'Daicel Corporation',
//             style: GoogleFonts.roboto(
//               fontSize: 13,
//               fontWeight: FontWeight.w500,
//               color: AppColors.customColorGray,
//             ),
//           ),
//           // const Divider(height: 20, thickness: 0.8),
//           //divider beda warna
//           Divider(
//             height: 20,
//             thickness: 0.8,
//             color: AppColors.customColorRed.withOpacity(0.6),
//           ),
//
//
//           // Detail Info (Date, Barang, Container)
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               _buildInfoItem(Icons.calendar_today_rounded, '17-12-2025'),
//               _buildInfoItem(Icons.bar_chart_outlined, 'Barang: 2'),
//               _buildInfoItem(Icons.local_shipping_rounded, 'Container: 2'),
//             ],
//           ),
//           const SizedBox(height: 15),
//
//           // Action Button
//           SizedBox(
//             width: double.infinity,
//             height: 38,
//             child: ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const PebDetailsMenuPage(),
//                   ),
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.customColorRed,
//                 elevation: 0,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               child: Text(
//                 'View Details',
//                 style: GoogleFonts.roboto(
//                   color: Colors.white,
//                   fontSize: 13,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildInfoItem(IconData icon, String label) {
//     return Row(
//       children: [
//         Icon(icon, size: 16, color: AppColors.customColorGray.withOpacity(0.7)),
//         const SizedBox(width: 5),
//         Text(
//           label,
//           style: GoogleFonts.roboto(
//             fontSize: 12,
//             color: AppColors.customColorGray,
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:trade2gov/ui/edec/PEB/details/menu/container/peb_cointaner_details_page.dart';
import 'package:trade2gov/ui/edec/PEB/details/menu/respon/peb_respon_details_page.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_box_decoration.dart';
import '../../details/menu/header/peb_header_details_page.dart';
import 'databarang/peb_list_data_barang_page.dart';
import 'dokumen/peb_dokumen_details_page.dart';
import 'kemasan/peb_kemasan_details_page.dart';
import 'container/peb_cointaner_details_page.dart';
import '../../details/menu/respon/peb_respon_details_page.dart';
import 'transaksiekspor/peb_transaksi_ekspor_details_page.dart';

class PebDetailsMenuPage extends StatefulWidget {
  const PebDetailsMenuPage({super.key});

  @override
  State<PebDetailsMenuPage> createState() => _PebDetailsMenuPageState();
}

class _PebDetailsMenuPageState extends State<PebDetailsMenuPage> {
  int? activeIndex;

  @override
  void initState() {
    super.initState();
    // ⛔ Sembunyikan navigation bar bawah (immersive mode)
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    // ✅ Kembalikan navigation bar saat keluar page
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Definisi Menu sesuai instruksi icon yang diberikan
    final List<Map<String, dynamic>> menuItems = [
      {'label': 'Header', 'icon': Icons.web_rounded},
      {'label': 'Data Barang', 'icon': Icons.inventory_2_rounded},
      {'label': 'Dokumen', 'icon': Icons.description_rounded},
      {'label': 'Kemasan', 'icon': Icons.all_inbox_rounded},
      {'label': 'Container', 'icon': Icons.local_shipping_rounded},
      {'label': 'Transaksi Ekspor', 'icon': Icons.handshake_rounded},
      {'label': 'Respon', 'icon': Icons.hourglass_bottom_rounded},
      {'label': 'Print', 'icon': Icons.local_printshop_rounded},
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
              'PEB Details Menu',
              style: GoogleFonts.lato(
                color: AppColors.customColorRed,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '301019-9CB5DF-20251007-000009',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Grid Menu 3 Kolom
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 20,
                childAspectRatio: 0.75, // Ruang untuk label di luar kotak
              ),
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final item = menuItems[index];
                return _buildMenuTile(
                  index,
                  item['label'],
                  item['icon'],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuTile(int index, String label, IconData icon) {
    final bool isActive = activeIndex == index;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        setState(() {
          activeIndex = index;
        });
        //clicked menu
        switch (label) {
          case 'Header':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PebHeaderDetailsPage(),
              ),
            );
            break;

          case 'Data Barang':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PebListDataBarangPage(),
              ),
            );
            break;

          case 'Dokumen':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PebDokumenDetailsPage(),
              ),
            );
            break;

          case 'Kemasan':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PebKemasanDetailsPage(),
              ),
            );
            break;

          case 'Container':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PebContainerDetailsPage(),
              ),
            );
            break;

          case 'Transaksi Ekspor':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PebTransaksiEksporDetailsPage(),
              ),
            );
            break;

          case 'Respon':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PebResponDetailsPage(),
              ),
            );
            break;

          case 'Print':
            _showPrintOptions();
            break;
        }
      },
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: double.infinity,
              decoration:
              isActive ? AppBox.menuActive() : AppBox.menu(),
              child: Center(
                child: CircleAvatar(
                  radius: 26,
                  backgroundColor: isActive
                      ? AppColors.whiteColor.withOpacity(0.2)
                      : AppColors.customColorRed.withOpacity(0.12),
                  child: Icon(
                    icon,
                    size: 26,
                    color: isActive
                        ? AppColors.whiteColor
                        : AppColors.customColorRed,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.roboto(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isActive
                  ? AppColors.customColorRed
                  : AppColors.customColorGray,
            ),
          ),
        ],
      ),
    );
  }

  void _showPrintOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.picture_as_pdf),
                title: const Text('Print PEB'),
                onTap: () {
                  Navigator.pop(context);
                  // open pdf
                },
              ),
              ListTile(
                leading: const Icon(Icons.folder_open),
                title: const Text('Buka Folder Dokumen'),
                onTap: () {
                  Navigator.pop(context);
                  // open folder
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
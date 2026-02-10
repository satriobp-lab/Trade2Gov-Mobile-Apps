import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:trade2gov/ui/edec/PIB/details/menu/container/pib_cointaner_details_page.dart';
import 'package:trade2gov/ui/edec/PIB/details/menu/harga/pib_harga_details_page.dart';
import 'package:trade2gov/ui/edec/PIB/details/menu/pungutan/pib_pungutan_details_page.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_box_decoration.dart';
import 'header/pib_header_details_page.dart';
import 'databarang/pib_list_data_barang_page.dart';
import 'dokumen/pib_dokumen_details_page.dart';
import 'kemasan/pib_kemasan_details_page.dart';
import 'container/pib_cointaner_details_page.dart';
import 'harga/pib_harga_details_page.dart';
import 'pungutan/pib_pungutan_details_page.dart';
import 'respon/pib_respon_details_page.dart';


class PibDetailsMenuPage extends StatefulWidget {
  const PibDetailsMenuPage({super.key});

  @override
  State<PibDetailsMenuPage> createState() => _PibDetailsMenuPageState();
}

class _PibDetailsMenuPageState extends State<PibDetailsMenuPage> {
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
      {'label': 'Data Harga', 'icon': Icons.price_change_rounded},
      {'label': 'Pungutan', 'icon': Icons.price_check_rounded},
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
              'PIB Details Menu',
              style: GoogleFonts.lato(
                color: AppColors.customColorRed,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '060000-000398-20251217-201062',
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
        //clicked header menu
        switch (label) {
          case 'Header':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PibHeaderDetailsPage(),
              ),
            );
            break;

          case 'Data Barang':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PibListDataBarangPage(),
              ),
            );
            break;

          case 'Dokumen':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PibDokumenDetailsPage(),
              ),
            );
            break;

          case 'Kemasan':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PibKemasanDetailsPage(),
              ),
            );
            break;

          case 'Container':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PibContainerDetailsPage(),
              ),
            );
            break;

          case 'Data Harga':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PibHargaDetailsPage(),
              ),
            );
            break;

          case 'Pungutan':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PibPungutanDetailsPage(),
              ),
            );
            break;

          case 'Respon':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PibResponDetailsPage(),
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
                title: const Text('Print PIB'),
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
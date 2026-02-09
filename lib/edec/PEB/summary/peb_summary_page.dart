import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_box_decoration.dart';
import 'package:flutter/services.dart';

class PebSummaryPage extends StatefulWidget {
  const PebSummaryPage({super.key});

  @override
  State<PebSummaryPage> createState() => _PebSummaryPageState();
}

class _PebSummaryPageState extends State<PebSummaryPage> {

  @override
  void initState() {
    super.initState();

    // ⛔ sembunyikan navigation bar bawah
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
    );
  }

  @override
  void dispose() {
    // ✅ balikin navigation bar saat keluar page
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Daftar status summary PEB sesuai instruksi
    final List<Map<String, dynamic>> summaryData = [
      {'label': 'Total PEB', 'value': '85'},
      {'label': 'PEB BCF3.09/Notul PEB', 'value': '2'},
      {'label': 'PEB Checking', 'value': '5'},
      {'label': 'PEB Completed', 'value': '40'},
      {'label': 'PEB Delivered', 'value': '15'},
      {'label': 'PEB Edit', 'value': '3'},
      {'label': 'PEB Err. Comm.', 'value': '0'},
      {'label': 'PEB NPE', 'value': '12'},
      {'label': 'PEB NPP(Penolakan) Notul PEB', 'value': '1'},
      {'label': 'PEB Persetujuan Notul PEB', 'value': '1'},
      {'label': 'PEB Queued', 'value': '0'},
      {'label': 'PEB Ready', 'value': '4'},
      {'label': 'PEB Selesai Proses', 'value': '2'},
      {'label': 'PEB Validated', 'value': '0'},
    ];

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.customColorRed),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'PEB Summary',
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
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 1.5, // Disesuaikan sedikit agar label panjang muat
        ),
        itemCount: summaryData.length,
        itemBuilder: (context, index) {
          final item = summaryData[index];
          final bool isTotal = item['label'] == 'Total PEB';

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: isTotal ? AppBox.menuActive() : AppBox.primary(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item['label'],
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isTotal ? Colors.white : AppColors.customColorGray,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  item['value'],
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isTotal ? Colors.white : AppColors.customColorRed,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
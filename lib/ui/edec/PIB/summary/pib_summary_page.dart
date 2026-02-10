import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_box_decoration.dart';
import 'package:flutter/services.dart';

class PibSummaryPage extends StatefulWidget {
  const PibSummaryPage({super.key});

  @override
  State<PibSummaryPage> createState() => _PibSummaryPageState();
}

class _PibSummaryPageState extends State<PibSummaryPage> {

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
    // Daftar status summary PIB sesuai instruksi
    final List<Map<String, dynamic>> summaryData = [
      {'label': 'Total PIB', 'value': '100'},
      {'label': 'PIB BC11', 'value': '12'},
      {'label': 'PIB Billing', 'value': '5'},
      {'label': 'PIB Completed', 'value': '45'},
      {'label': 'PIB Delivered', 'value': '30'},
      {'label': 'PIB Edit', 'value': '2'},
      {'label': 'PIB Err. Comm.', 'value': '0'},
      {'label': 'PIB INP/DNP', 'value': '1'},
      {'label': 'PIB NPBL NSW', 'value': '0'},
      {'label': 'PIB NPD', 'value': '3'},
      {'label': 'PIB Proses', 'value': '10'},
      {'label': 'PIB Queued', 'value': '0'},
      {'label': 'PIB Ready', 'value': '8'},
      {'label': 'PIB Reject', 'value': '4'},
      {'label': 'PIB Reject NSW', 'value': '1'},
      {'label': 'PIB SPJK', 'value': '2'},
      {'label': 'PIB SPJM', 'value': '15'},
      {'label': 'PIB SPKNP', 'value': '0'},
      {'label': 'PIB SPPB', 'value': '20'},
      {'label': 'PIB SPTNP', 'value': '2'},
      {'label': 'PIB Validated', 'value': '12'},
      {'label': 'PIB Validating', 'value': '0'},
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
        title: Text(
          'PIB Summary',
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
          childAspectRatio: 1.5,
        ),
        itemCount: summaryData.length,
        itemBuilder: (context, index) {
          final item = summaryData[index];
          final bool isTotal = item['label'] == 'Total PIB';

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
                  maxLines: 1,
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
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_box_decoration.dart';
import 'package:flutter/services.dart';

class PebSummaryPage extends StatefulWidget {
  final List<String> pebList;

  const PebSummaryPage({
    super.key,
    required this.pebList,
  });

  @override
  State<PebSummaryPage> createState() => _PebSummaryPageState();
}

class _PebSummaryPageState extends State<PebSummaryPage> {
  final List<String> masterLabels = [
    'Total PEB',
    'PEB BCF3.09/Notul PEB',
    'PEB CHECKING',
    'PEB COMPLETED',
    'PEB DELIVERED',
    'PEB EDIT.',
    'PEB ERR. COMM',
    'PEB NPE',
    'PEB NPP(Penolakan) Notul PEB',
    'PEB Persetujuan Notul PEB',
    'PEB QUEUED',
    'PEB READY',
    'PEB Selesai Proses',
    'PEB VALIDATED',
  ];

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

  List<Map<String, dynamic>> _parseSummary() {
    final backendMap = _convertBackendToMap();

    return masterLabels.map((label) {
      return {
        'label': label,
        'value': backendMap[label] ?? '0', // 👈 DEFAULT 0
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = _parseSummary();
    // // Daftar status summary PEB sesuai instruksi
    // final List<Map<String, dynamic>> summaryData = [
    //   {'label': 'Total PEB', 'value': '85'},
    //   {'label': 'PEB BCF3.09/Notul PEB', 'value': '2'},
    //   {'label': 'PEB Checking', 'value': '5'},
    //   {'label': 'PEB Completed', 'value': '40'},
    //   {'label': 'PEB Delivered', 'value': '15'},
    //   {'label': 'PEB Edit', 'value': '3'},
    //   {'label': 'PEB Err. Comm.', 'value': '0'},
    //   {'label': 'PEB NPE', 'value': '12'},
    //   {'label': 'PEB NPP(Penolakan) Notul PEB', 'value': '1'},
    //   {'label': 'PEB Persetujuan Notul PEB', 'value': '1'},
    //   {'label': 'PEB Queued', 'value': '0'},
    //   {'label': 'PEB Ready', 'value': '4'},
    //   {'label': 'PEB Selesai Proses', 'value': '2'},
    //   {'label': 'PEB Validated', 'value': '0'},
    // ];

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
                  _prettyLabel(item['label']),
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

  //helper
  String _formatLabel(String text) {
    return text
        .toLowerCase()
        .split(' ')
        .map((word) =>
    word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '')
        .join(' ');
  }

  Map<String, String> _convertBackendToMap() {
    final Map<String, String> result = {};

    for (var item in widget.pebList) {
      final parts = item.split(':');

      if (parts.length >= 2) {
        final label = parts[0].trim();
        final value = parts[1].trim();

        result[label] = value;
      }
    }
    return result;
  }

  String _prettyLabel(String text) {
    return text
        .split(' ')
        .map((word) {
      if (word == 'PEB') return 'PEB';
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    })
        .join(' ');
  }
}
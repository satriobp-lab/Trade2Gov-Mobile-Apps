import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:trade2gov/ui/edec/PIB/details/pib_history_list_page.dart';
import 'package:trade2gov/ui/edec/PEB/details/peb_history_list_page.dart';
import 'package:trade2gov/ui/edec/PIBK/details/pibk_history_list_page.dart';
import 'package:trade2gov/ui/edec/PKBE/details/pkbe_history_list_page.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_box_decoration.dart';
import 'PIB/summary/pib_summary_page.dart';
import 'PEB/summary/peb_summary_page.dart'; // Import halaman PEB baru
import 'PKBE/summary/pkbe_summary_page.dart';
import 'PIBK/summary/pibk_summary_page.dart';
import 'package:flutter/cupertino.dart';
import '../../data/controllers/edec_controller.dart';
import '../../core/app_cache.dart';


class EdecPage extends StatefulWidget {
  const EdecPage({super.key});

  @override
  State<EdecPage> createState() => _EdecPageState();
}

class _EdecPageState extends State<EdecPage> {
  // final Map<String, int> documentData = {
  //   'PIB': 100,
  //   'PEB': 85,
  //   'PKBE': 45,
  //   'PIBK': 30,
  // };

  Map<String, int> documentData = {};
  bool isLoading = true;

  final Map<String, Color> chartColors = {
    'PIB': AppColors.customColorRed,
    'PEB': const Color(0xFFF4A261),
    'PKBE': const Color(0xFF2A9D8F),
    'PIBK': const Color(0xFF264653),
  };

  @override
  void initState() {
    super.initState();
    _loadDashboard();
  }

  Future<void> _loadDashboard() async {
    try {
      final data = await EdecController.getDashboard();

      setState(() {
        documentData = {
          'PIB': data.pib,
          'PEB': data.peb,
          'PKBE': data.pkbe,
          'PIBK': data.pibk,
        };
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {

    if (isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Center(
          child: CupertinoActivityIndicator(
            radius: 15,
          ),
        ),
      );
    }

    int totalDocs = documentData.values.fold(0, (sum, item) => sum + item);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'e-Declaration',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Chart Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: AppBox.primary(),
              child: Column(
                children: [
                  Text(
                    'Dokumen Kepabeanan',
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.customColorGray,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 180,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        PieChart(
                          PieChartData(
                            sectionsSpace: 2,
                            centerSpaceRadius: 50,
                            sections: _buildChartSections(),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '$totalDocs',
                              style: GoogleFonts.roboto(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.customColorGray,
                              ),
                            ),
                            Text(
                              'Total',
                              style: GoogleFonts.roboto(
                                fontSize: 12,
                                color: AppColors.customColorGray.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 15,
                    runSpacing: 10,
                    alignment: WrapAlignment.center,
                    children: documentData.keys.map((key) {
                      return _buildLegendItem(key, chartColors[key]!);
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Text(
              'Daftar Dokumen',
              style: GoogleFonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.customColorRed,
              ),
            ),
            const SizedBox(height: 15),
            ...documentData.entries.map((entry) {
              return _buildDocumentCard(entry.key, entry.value);
            }).toList(),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _buildChartSections() {
    return documentData.entries.map((entry) {
      return PieChartSectionData(
        color: chartColors[entry.key],
        value: entry.value.toDouble(),
        title: '',
        radius: 25,
        showTitle: false,
      );
    }).toList();
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.roboto(fontSize: 12, color: AppColors.customColorGray),
        ),
      ],
    );
  }

  Widget _buildDocumentCard(String title, int count) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: AppBox.primary(),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '$title ',
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.customColorGray,
                        ),
                      ),
                      TextSpan(
                        text: '($count)',
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.customColorRed,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Icon(Icons.description_outlined, color: AppColors.customColorRed),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 35,
                  child: OutlinedButton(
                    onPressed: () {
                      // Navigasi Berdasarkan Tipe Dokumen
                      if (title == 'PIB') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PibSummaryPage(
                              pibList: AppCache.edecDashboard?.pibList ?? [],
                            ),
                          ),
                        );
                      } else if (title == 'PEB') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PebSummaryPage()),
                        );
                      } else if (title == 'PKBE') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PkbeSummaryPage()),
                        );
                      } else if (title == 'PIBK') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PibkSummaryPage()),
                        );
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.customColorRed),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text(
                      'Summary',
                      style: GoogleFonts.roboto(
                        color: AppColors.customColorRed,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SizedBox(
                  height: 35,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigasi Berdasarkan Tipe Dokumen
                      if (title == 'PIB') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PibHistoryListPage()),
                        );
                      } else if (title == 'PEB') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PebHistoryListPage()),
                        );
                      } else if (title == 'PKBE') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PkbeHistoryListPage()),
                        );
                      } else if (title == 'PIBK') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PibkHistoryListPage()),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.customColorRed,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text(
                      'Details',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
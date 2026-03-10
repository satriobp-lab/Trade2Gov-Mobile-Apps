import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:trade2gov/ui/edec/PIB/details/pib_history_list_page.dart';
import 'package:trade2gov/ui/edec/PEB/details/peb_history_list_page.dart';
import 'package:trade2gov/ui/edec/PIBK/details/pibk_history_list_page.dart';
import 'package:trade2gov/ui/edec/PKBE/details/pkbe_history_list_page.dart';
import 'package:trade2gov/ui/edec/TPB/details/tpb_history_list_page.dart';
import '../../utils/app_colors.dart';
import '../../widgets/edec_loader.dart';
import '../../utils/app_box_decoration.dart';
import 'PIB/summary/pib_summary_page.dart';
import 'PEB/summary/peb_summary_page.dart'; // Import halaman PEB baru
import 'PKBE/summary/pkbe_summary_page.dart';
import 'PIBK/summary/pibk_summary_page.dart';
import 'TPB/summary/tpb_summary_page.dart';
import 'package:flutter/cupertino.dart';
import '../../data/controllers/edec_controller.dart';
import '../../core/app_cache.dart';


class EdecPage extends StatefulWidget {
  const EdecPage({super.key});

  @override
  State<EdecPage> createState() => _EdecPageState();
}

class _EdecPageState extends State<EdecPage>
    with SingleTickerProviderStateMixin {
  // final Map<String, int> documentData = {
  //   'PIB': 100,
  //   'PEB': 85,
  //   'PKBE': 45,
  //   'PIBK': 30,
  // };

  Map<String, int> documentData = {};
  bool isLoading = true;

  late AnimationController _controller;
  late Animation<double> _animation;

  final Map<String, Color> chartColors = {
    'PIB': AppColors.customColorRed,
    'PEB': const Color(0xFFF4A261),
    'PIBK': const Color(0xFF2A9D8F),
    // 'PKBE': const Color(0xFF264653),
    'TPB': const Color(0xFF6A4C93),
  };

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // ubah sesuai rasa
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );

    _loadDashboard();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadDashboard() async {
    try {
      final data = await EdecController.getDashboard();

      setState(() {
        documentData = {
          'PIB': data.pib,
          'PEB': data.peb,
          // 'PKBE': data.pkbe,
          'PIBK': data.pibk,
          'TPB': 187,
        };
        isLoading = false;
      });

      // 🔥 START ANIMATION DI SINI
      _controller.forward(from: 0);

    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {

    if (isLoading) {
      return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const EdecLoader(),
              const SizedBox(height: 12),
              Text(
                'Loading e-Dec dashboard...',
                style: GoogleFonts.lato(
                  color: AppColors.customColorRed,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
    }

    int totalDocs = (documentData.values
        .fold(0, (sum, item) => sum + item) *
        _animation.value)
        .toInt();

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
                        AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) {
                            return ClipPath(
                              clipper: PieRevealClipper(_animation.value),
                              child: PieChart(
                                PieChartData(
                                  sectionsSpace: 2,
                                  centerSpaceRadius: 50,
                                  sections: documentData.entries.map((entry) {
                                    return PieChartSectionData(
                                      color: chartColors[entry.key],
                                      value: entry.value.toDouble(),
                                      title: '',
                                      radius: 25,
                                      showTitle: false,
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        ),
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0, end: 1),
                          duration: const Duration(seconds: 2),
                          curve: Curves.easeOutCubic,
                          builder: (context, value, child) {
                            int totalDocs = (documentData.values
                                .fold(0, (sum, item) => sum + item) *
                                value)
                                .toInt();

                            return Column(
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
                            );
                          },
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
        value: entry.value.toDouble() * _animation.value,
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
                          MaterialPageRoute(
                            builder: (context) => PebSummaryPage(
                              pebList: AppCache.edecDashboard?.pebList ?? [],
                            ),
                          ),
                        );
                      // } else if (title == 'PKBE') {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => PkbeSummaryPage(
                      //         pkbeList: AppCache.edecDashboard?.pkbeList ?? [],
                      //       ),
                      //     ),
                      //   );
                      } else if (title == 'PIBK') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PibkSummaryPage(
                              pibkList: AppCache.edecDashboard?.pibkList ?? [],
                            ),
                          ),
                        );
                      } else if (title == 'TPB') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TpbSummaryPage(),
                          ),
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
                      // } else if (title == 'PKBE') {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(builder: (context) => const PkbeHistoryListPage()),
                      //   );
                      } else if (title == 'PIBK') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PibkHistoryListPage()),
                        );
                      } else if (title == 'TPB') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TpbHistoryListPage()),
                        );
                      }
                      // } else if (title == 'TPB') {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(
                      //       content: Text('TPB Details masih dalam pengembangan'),
                      //     ),
                      //   );
                      // }
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

  void _startChartAnimation() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _controller.forward();
      }
    });
  }
}

class PieRevealClipper extends CustomClipper<Path> {
  final double progress;

  PieRevealClipper(this.progress);

  @override
  Path getClip(Size size) {
    final path = Path();

    // ✅ Kalau sudah 100%, tampilkan full chart
    if (progress >= 0.999) {
      path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));
      return path;
    }

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    path.moveTo(center.dx, center.dy);

    path.arcTo(
      Rect.fromCircle(center: center, radius: radius),
      -90 * (3.1415926535 / 180),
      2 * 3.1415926535 * progress,
      false,
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant PieRevealClipper oldClipper) {
    return oldClipper.progress != progress;
  }
}
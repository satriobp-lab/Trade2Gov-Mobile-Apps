import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_box_decoration.dart';
import 'package:flutter/services.dart';

class TpbSummaryPage extends StatefulWidget {
  const TpbSummaryPage({super.key});

  @override
  State<TpbSummaryPage> createState() => _TpbSummaryPageState();
}

class _TpbSummaryPageState extends State<TpbSummaryPage> {

  /// DUMMY DATA
  final Map<String, Map<String, String>> dummyTpbData = {
    "BC23": {
      "CHECKING": "1",
      "EDIT": "46",
      "ERR. COMM.": "20",
      "QUEUED": "8",
      "READY": "15",
      "REVISE": "1",
      "SPTNP": "2",
      "VALIDATED": "3",
    },
    "BC25": {
      "CHECKING": "1",
      "EDIT": "72",
      "ERR. COMM.": "17",
      "QUEUED": "9",
      "READY": "25",
      "VALIDATING": "1",
    },
    "BC261": {
      "EDIT": "49",
      "ERR. COMM.": "9",
      "QUEUED": "1",
      "READY": "7",
    },
    "BC262": {
      "DELIVERED": "1",
      "EDIT": "31",
      "ERR. COMM.": "12",
      "QUEUED": "2",
      "READY": "2",
    },
    "BC27": {
      "EDIT": "21",
      "ERR. COMM.": "5",
      "QUEUED": "2",
      "READY": "3",
    },
    "BC40": {
      "EDIT": "25",
      "ERR. COMM.": "9",
      "QUEUED": "3",
      "READY": "15",
    },
    "BC41": {
      "EDIT": "16",
      "ERR. COMM.": "10",
      "QUEUED": "2",
      "READY": "4",
    },
  };

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
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
          'TPB Summary',
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
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: dummyTpbData.entries.map((entry) {
          return _buildBcSection(entry.key, entry.value);
        }).toList(),
      ),
    );
  }

  Widget _buildBcSection(String bcCode, Map<String, String> statuses) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// 🔴 BC TITLE
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 12),
          child: Text(
            bcCode,
            style: GoogleFonts.lato(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.customColorRed,
            ),
          ),
        ),

        /// GRID STATUS
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: statuses.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 1.5,
          ),
          itemBuilder: (context, index) {
            final label = statuses.keys.elementAt(index);
            final value = statuses[label] ?? "0";

            return Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 10),
              decoration: AppBox.primary(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _prettyLabel(label),
                    style: GoogleFonts.roboto(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.customColorGray,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.customColorRed,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  String _prettyLabel(String text) {
    return text
        .split(' ')
        .map((word) =>
    word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }
}
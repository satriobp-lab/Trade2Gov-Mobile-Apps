import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../utils/app_colors.dart';
import '../utils/app_box_decoration.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final MobileScannerController _controller = MobileScannerController();
  String? scannedCode;
  bool isScanned = false;

  @override
  void dispose() {
    _controller.dispose();
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
        toolbarHeight: 80,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: AppColors.customColorRed),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Scan QR Code',
              style: GoogleFonts.lato(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.customColorRed,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Scan dokumen PIB / Tracking',
              style: GoogleFonts.lato(
                fontSize: 13,
                color: AppColors.customColorGray,
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            margin: const EdgeInsets.symmetric(horizontal: 25),
            color: AppColors.customColorRed.withOpacity(0.3),
          ),
        ),
      ),

      body: Column(
        children: [
          // ================= CAMERA =================
          Container(
            margin: const EdgeInsets.all(20),
            height: 260,
            decoration: AppBox.primary(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: MobileScanner(
                controller: _controller,
                onDetect: (barcode) {
                  if (isScanned) return;

                  final String? code = barcode.barcodes.first.rawValue;
                  if (code != null) {
                    setState(() {
                      scannedCode = code;
                      isScanned = true;
                    });
                    _controller.stop();
                  }
                },
              ),
            ),
          ),

          // ================= RESULT =================
          if (isScanned) _buildResultCard(),

          if (!isScanned)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Arahkan kamera ke QR Code',
                style: GoogleFonts.roboto(
                  fontSize: 13,
                  color: AppColors.customColorGray,
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ================= RESULT CARD =================
  Widget _buildResultCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        decoration: AppBox.primary(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: AppColors.customColorRed.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.qr_code_rounded,
                      color: AppColors.customColorRed,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Rincian Respon',
                      style: GoogleFonts.lato(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.customColorRed,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Divider
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 1.2,
                color: AppColors.customColorRed.withOpacity(0.25),
              ),
            ),

            // Detail
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildDetailRow('Kode', scannedCode ?? '-'),
                  const SizedBox(height: 8),
                  _buildDetailRow('Tanggal', '14-01-2026'),
                  const SizedBox(height: 8),
                  _buildDetailRow('Waktu', '09:57:26'),
                ],
              ),
            ),

            // Button
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: redirect ke Tracking / PIB
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.customColorRed,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Lihat Detail',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: GoogleFonts.roboto(
              fontSize: 13,
              color: AppColors.customColorGray,
            ),
          ),
        ),
        Text(
          ': ',
          style: GoogleFonts.roboto(
            fontSize: 13,
            color: AppColors.customColorGray,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.roboto(
              fontSize: 13,
              color: AppColors.customColorGray,
            ),
          ),
        ),
      ],
    );
  }
}

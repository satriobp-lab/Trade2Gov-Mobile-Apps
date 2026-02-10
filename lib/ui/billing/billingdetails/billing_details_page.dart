import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_box_decoration.dart';

class BillingDetailsPage extends StatelessWidget {
  const BillingDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.customColorRed,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Billing Details',
          style: GoogleFonts.lato(
            color: AppColors.customColorRed,
            fontWeight: FontWeight.bold,
            fontSize: width * 0.05,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            margin: const EdgeInsets.symmetric(horizontal: 24),
            color: AppColors.customColorRed.withOpacity(0.25),
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 30),
        children: [
          /// MAIN BILLING CARD
          Container(
            padding: const EdgeInsets.all(18),
            decoration: AppBox.primary(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// HEADER
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.customColorRed.withOpacity(0.08),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.receipt_long_outlined,
                        color: AppColors.customColorRed,
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: 14),

                    /// TITLE & PERIOD
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tagihan Terbit',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w600,
                              fontSize: width * 0.04,
                              color: AppColors.customColorGray,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'December 2025',
                            style: GoogleFonts.roboto(
                              fontSize: width * 0.032,
                              color: AppColors.customColorGray.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// AMOUNT
                    Text(
                      'Rp 13.281.740',
                      textAlign: TextAlign.end,
                      style: GoogleFonts.lato(
                        fontSize: width * 0.042,
                        fontWeight: FontWeight.bold,
                        color: AppColors.customColorGreen,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Divider(
                  thickness: 1,
                  color: AppColors.customColorRed.withOpacity(0.3),
                ),

                const SizedBox(height: 12),

                /// DETAIL SECTION
                _DetailRow(
                  label: 'Bea Masuk',
                  value: 'Rp 200.000',
                ),
                _DetailRow(
                  label: 'PPN',
                  value: 'Rp 1.500.000',
                ),
                _DetailRow(
                  label: 'PPh',
                  value: 'Rp 1.581.740',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width * 0.30, // FIXED LABEL WIDTH
            child: Text(
              label,
              style: GoogleFonts.roboto(
                fontSize: width * 0.035,
                fontWeight: FontWeight.w500,
                color: AppColors.customColorGray,
              ),
            ),
          ),

          Text(
            ":",
            style: GoogleFonts.roboto(
              fontSize: width * 0.035,
              fontWeight: FontWeight.w500,
              color: AppColors.customColorGray,
            ),
          ),

          const SizedBox(width: 8),

          Expanded(
            child: Text(
              value,
              style: GoogleFonts.roboto(
                fontSize: width * 0.035,
                color: AppColors.customColorGray,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

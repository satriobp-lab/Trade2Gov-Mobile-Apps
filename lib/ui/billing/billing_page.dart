import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trade2gov/data/models/billing_response_model.dart';
import 'package:trade2gov/data/controllers/billing_controller.dart';
import '../../utils/app_colors.dart';
import 'billingdetails/billing_details_page.dart';
import '../../utils/app_box_decoration.dart';

class BillingPage extends StatelessWidget {
  const BillingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Billing',
          style: GoogleFonts.lato(
            color: AppColors.customColorRed,
            fontWeight: FontWeight.bold,
            fontSize: width * 0.055,
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

      /// 🔥 DATA FROM API
      body: FutureBuilder(
        future: BillingController.fetchBilling(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.customColorRed,
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Gagal memuat billing',
                style: GoogleFonts.lato(color: Colors.red),
              ),
            );
          }

          final data = snapshot.data as List<BillingResponseModel>;

          if (data.isEmpty) {
            return Center(
              child: Text(
                'Tidak ada data billing',
                style: GoogleFonts.lato(),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
            itemCount: data.length,
            separatorBuilder: (_, __) => const SizedBox(height: 14),
            itemBuilder: (context, index) {
              final item = data[index];

              return _BillingCard(
                title: 'Tagihan Terbit',
                period: item.periodeTagihan.replaceAll('-', ' '),
                amount: formatRupiah(item.billingTotal),
              );
            },
          );
        },
      ),
    );
  }
}

String formatRupiah(int value) {
  return 'Rp ${value.toString().replaceAllMapped(
    RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
        (m) => '${m[1]}.',
  )}';
}


// final List<Map<String, String>> billingData = [
//   {
//     'title': 'Tagihan Terbit',
//     'period': 'December 2025',
//     'amount': 'Rp 13.281.740',
//   },
//   {
//     'title': 'Tagihan Terbit',
//     'period': 'November 2025',
//     'amount': 'Rp 3.281.740',
//   },
//   {
//     'title': 'Tagihan Terbit',
//     'period': 'October 2025',
//     'amount': 'Rp 3.281.740',
//   },
// ];

class _BillingCard extends StatelessWidget {
  final String title;
  final String period;
  final String amount;

  const _BillingCard({
    required this.title,
    required this.period,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Material(
      borderRadius: BorderRadius.circular(18),
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const BillingDetailsPage(),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: AppBox.primary(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
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

              /// TEXT
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.lato(
                        fontSize: width * 0.038,
                        fontWeight: FontWeight.w600,
                        color: AppColors.customColorGray,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      period,
                      style: GoogleFonts.roboto(
                        fontSize: width * 0.032,
                        color: AppColors.customColorGray.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),

              /// AMOUNT
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  amount,
                  textAlign: TextAlign.end,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.lato(
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.bold,
                    color: AppColors.customColorGreen,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

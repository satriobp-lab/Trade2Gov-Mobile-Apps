import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';
import 'mailboxmasuk/mailboxmasuk_page.dart';
import 'mailboxterbaca/mailboxterbaca_page.dart';

class MailboxTab extends StatelessWidget {
  const MailboxTab({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            'Mailbox',
            style: GoogleFonts.lato(
              color: AppColors.customColorRed,
              fontWeight: FontWeight.bold,
              fontSize: width * 0.055, // responsive
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48.0),
            child: Column(
              children: [
                TabBar(
                  dividerColor: Colors.transparent, // ✅ Menghilangkan garis abu-abu default
                  indicatorColor: AppColors.customColorRed,
                  indicatorWeight: 3,
                  indicatorPadding: const EdgeInsets.symmetric(horizontal: 20),
                  labelColor: AppColors.customColorRed,
                  unselectedLabelColor: AppColors.customColorRed.withOpacity(0.5),
                  labelStyle: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.045, // responsive
                  ),
                  tabs: const [
                    Tab(text: 'Masuk'),
                    Tab(text: 'Terbaca'),
                  ],
                ),
                // Garis line kustom di bawah tab sesuai dengan gaya Call Center / Billing
                Container(
                  color: AppColors.customColorRed.withOpacity(0.3),
                  height: 1.0,
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                ),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            MailboxMasukPage(),
            MailboxTerbacaPage(),
          ],
        ),
      ),
    );
  }
}
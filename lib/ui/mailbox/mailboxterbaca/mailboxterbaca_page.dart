import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_box_decoration.dart';

class MailboxTerbacaPage extends StatelessWidget {
  const MailboxTerbacaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      itemCount: 2,
      itemBuilder: (context, index) {
        return _buildReadMailItem(
          context,
          'Pesan Terbaca: Konfirmasi Pembayaran',
        );
      },
    );
  }

  Widget _buildReadMailItem(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: AppBox.primary().copyWith(
        color: Colors.white,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            _showMailPreview(context, title);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.customColorGray.withOpacity(0.1),
                  ),
                  child: Icon(
                    Icons.drafts_outlined,
                    color: AppColors.customColorGray,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.roboto(
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                      color: AppColors.customColorGray.withOpacity(0.7),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showMailPreview(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 25),
          child: Container(
            width: double.infinity,
            decoration: AppBox.primary(),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.drafts_outlined,
                      color: AppColors.customColorGray.withOpacity(0.5),
                      size: 28,
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Text(
                        title,
                        style: GoogleFonts.roboto(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppColors.customColorGray,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Divider(
                  color: AppColors.customColorGray.withOpacity(0.2),
                  thickness: 1,
                ),
                const SizedBox(height: 15),
                Text(
                  'Detail informasi pesan yang sudah terbaca mengenai konfirmasi pembayaran Anda telah kami proses.',
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    color: AppColors.customColorGray,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  '19 Oktober 2025',
                  style: GoogleFonts.lato(
                    fontSize: 12,
                    color: AppColors.customColorGray.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
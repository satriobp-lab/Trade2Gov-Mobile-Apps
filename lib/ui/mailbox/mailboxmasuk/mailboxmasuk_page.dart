import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_box_decoration.dart';

class MailboxMasukPage extends StatelessWidget {
  const MailboxMasukPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      itemCount: 4,
      itemBuilder: (context, index) {
        return _buildMailItem(
          context,
          'Respon Penerimaan Data PIB Diterima',
        );
      },
    );
  }

  Widget _buildMailItem(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: AppBox.primary(),
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
                    color: AppColors.customColorRed.withOpacity(0.1),
                  ),
                  child: Icon(
                    Icons.email_outlined,
                    color: AppColors.customColorRed,
                    size: 22,
                  ),
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
                    const Icon(
                      Icons.email_outlined,
                      color: AppColors.customColorRed,
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
                  color: AppColors.customColorRed.withOpacity(0.3),
                  thickness: 1,
                ),
                const SizedBox(height: 15),
                Text(
                  'Respon Penerimaan Data PIB Diterima. AJU : 00000000016720182901200451.',
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    color: AppColors.customColorGray,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  '20 Oktober 2025',
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
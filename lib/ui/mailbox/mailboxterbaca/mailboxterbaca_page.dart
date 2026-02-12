import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_box_decoration.dart';
import '../../../data/models/mailbox_response_model.dart';

class MailboxTerbacaPage extends StatelessWidget {
  final List<MailboxResponseModel> mails;

  const MailboxTerbacaPage({
    super.key,
    required this.mails,
  });

  @override
  Widget build(BuildContext context) {
    if (mails.isEmpty) {
      return const Center(child: Text("Belum ada pesan terbaca"));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: mails.length,
      itemBuilder: (context, index) {
        final mail = mails[index];

        return Material(
          borderRadius: BorderRadius.circular(18),
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () async {
              await _showPreview(context, mail.message);
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: AppBox.primary().copyWith(color: Colors.white),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.customColorGray.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.drafts_outlined,
                      color: AppColors.customColorGray,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      mail.message,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                        fontSize: 13,
                        color: AppColors.customColorGray.withOpacity(0.7),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showPreview(BuildContext context, String message) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Detail Pesan"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Tutup"),
          ),
        ],
      ),
    );
  }
}
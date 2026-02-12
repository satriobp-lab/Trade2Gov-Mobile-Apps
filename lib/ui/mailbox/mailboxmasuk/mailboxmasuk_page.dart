import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_box_decoration.dart';
import '../../../data/models/mailbox_response_model.dart';

class MailboxMasukPage extends StatelessWidget {
  final List<MailboxResponseModel> mails;
  final Function(MailboxResponseModel) onRead;

  const MailboxMasukPage({
    super.key,
    required this.mails,
    required this.onRead,
  });

  @override
  Widget build(BuildContext context) {
    if (mails.isEmpty) {
      return const Center(child: Text("Tidak ada pesan"));
    }

    final width = MediaQuery.of(context).size.width;

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
              onRead(mail); // setelah dialog ditutup
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: AppBox.primary(),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.customColorRed.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8), // rectangular
                    ),
                    child: const Icon(
                      Icons.mark_email_unread_outlined,
                      color: AppColors.customColorRed,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      _toTitleCase(mail.message),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                        fontSize: 13,
                        color: AppColors.customColorGray,
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
        content: Text(_toTitleCase(message)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Tutup"),
          ),
        ],
      ),
    );
  }

  String _toTitleCase(String? text) {
    if (text == null || text.isEmpty) return '-';

    return text
        .toLowerCase()
        .split(' ')
        .map((word) =>
    word.isNotEmpty
        ? word[0].toUpperCase() + word.substring(1)
        : '')
        .join(' ');
  }
}

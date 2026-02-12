import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/app_colors.dart';
import '../../data/controllers/mailbox_controller.dart';
import '../../data/models/mailbox_response_model.dart';
import 'mailboxmasuk/mailboxmasuk_page.dart';
import 'mailboxterbaca/mailboxterbaca_page.dart';
import '../../data/securestorage/secure_storage_service.dart';
import '../../core/app_cache.dart';

class MailboxTab extends StatefulWidget {
  const MailboxTab({super.key});

  @override
  State<MailboxTab> createState() => _MailboxTabState();
}

class _MailboxTabState extends State<MailboxTab>
    with SingleTickerProviderStateMixin {

  late TabController _tabController;

  List<MailboxResponseModel> masukList = [];
  List<MailboxResponseModel> terbacaList = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    final data = AppCache.mailboxList;

    masukList = data;
    terbacaList = [];
    _isLoading = false;
  }

  Future<void> _loadMailbox() async {
    try {
      final data = await MailboxController.fetchMailbox();
      final terbaca = await SecureStorageService().getReadMails();

      setState(() {
        terbacaList = terbaca;
        masukList = data.where((m) =>
        !terbaca.any((t) =>
        t.idUser == m.idUser &&
            t.message == m.message)).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _markAsRead(MailboxResponseModel mail) async {
    setState(() {
      masukList.remove(mail);
      terbacaList.add(mail);
    });

    await SecureStorageService().saveReadMails(terbacaList);
    _tabController.animateTo(1);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Mailbox',
          style: GoogleFonts.lato(
            color: AppColors.customColorRed,
            fontWeight: FontWeight.bold,
            fontSize: width * 0.055,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.customColorRed,
          labelColor: AppColors.customColorRed,
          unselectedLabelColor:
          AppColors.customColorRed.withOpacity(0.5),
          tabs: const [
            Tab(text: 'Masuk'),
            Tab(text: 'Terbaca'),
          ],
        ),
      ),
      body: _isLoading
          ? _buildLoading()
          : TabBarView(
        controller: _tabController,
        children: [
          MailboxMasukPage(
            mails: masukList,
            onRead: _markAsRead,
          ),
          MailboxTerbacaPage(
            mails: terbacaList,
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(
            color: AppColors.customColorRed,
          ),
          const SizedBox(height: 20),
          Text(
            "Loading mailbox...",
            style: GoogleFonts.lato(
              fontWeight: FontWeight.w600,
              color: AppColors.customColorRed,
            ),
          ),
        ],
      ),
    );
  }
}

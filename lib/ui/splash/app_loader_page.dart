import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/app_colors.dart';
import '../../data/securestorage/secure_storage_service.dart';
import '../../main_navigation.dart';
import '../../data/controllers/billing_controller.dart';
import '../../data/controllers/mailbox_controller.dart';
import '../../data/controllers/profile_controller.dart';
import '../../core/app_cache.dart';

class AppLoaderPage extends StatefulWidget {
  const AppLoaderPage({super.key});

  @override
  State<AppLoaderPage> createState() => _AppLoaderPageState();
}

class _AppLoaderPageState extends State<AppLoaderPage> {
  String _name = '';

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final storage = SecureStorageService();
    final name = await storage.getUserName();

    setState(() {
      _name = name ?? '';
    });

    try {
      // 🔥 PRELOAD BILLING
      final billing = await BillingController.fetchBilling();
      AppCache.billingList = billing;

      // 🔥 PRELOAD MAILBOX
      final mailbox = await MailboxController.fetchMailbox();
      AppCache.mailboxList = mailbox;

      // 🔥 PRELOAD PROFILE
      final profile = await ProfileController.fetchProfile();
      AppCache.profile = profile;

    } catch (e) {
      debugPrint("Preload error: $e");
    }

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MainNavigation()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image.asset(
            //   'assets/images/t2g-logo.png',
            //   width: 280,
            // ),
            const SizedBox(height: 25),
            Text(
              'Preparing your workspace...',
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.customColorRed,
              ),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              color: AppColors.customColorRed,
              strokeWidth: 2.5,
            ),
          ],
        ),
      ),
    );
  }
}

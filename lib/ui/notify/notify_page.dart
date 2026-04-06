import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_cache.dart';
import '../home/home_page.dart';
import '../billing/billing_page.dart';
import '../callcenter/call_center_page.dart';
import '../mailbox/mailbox_tab.dart';
import '../profile/profile_page.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_box_decoration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main_navigation.dart';

class NotifyPage extends StatefulWidget {
  const NotifyPage({super.key});

  @override
  State<NotifyPage> createState() => _NotifyPageState();
}

class _NotifyPageState extends State<NotifyPage> {
  int _selectedIndex = 0;
  List<Map<String, dynamic>> notifications = [];

  // List halaman untuk Bottom Navigation
  final List<Widget> _pages = [
    const NotifyContent(), // Konten Notifikasi utama
    const BillingPage(),
    const CallCenterPage(),
    const MailboxTab(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {

    // jika klik HOME → kembali ke dashboard utama
    if (index == 0) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const MainNavigation(initialIndex: 0),
        ),
            (route) => false,
      );
      return;
    }

    // selain HOME tetap pakai IndexedStack
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.customColorRed,
        unselectedItemColor: AppColors.customColorGray,
        selectedLabelStyle: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 12),
        unselectedLabelStyle: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 12),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long_rounded), label: 'Billing'),
          BottomNavigationBarItem(icon: Icon(Icons.support_agent_rounded), label: 'Call Center'),
          BottomNavigationBarItem(icon: Icon(Icons.email_outlined), label: 'Mailbox'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

class NotifyContent extends StatefulWidget {
  const NotifyContent({super.key});

  @override
  State<NotifyContent> createState() => _NotifyContentState();
}

class _NotifyContentState extends State<NotifyContent> {

  List<Map<String, dynamic>> notifications = [];

  @override
  void initState() {
    super.initState();
    _checkFirstInstall();
  }

  static const _keyNotificationRead = 'notification_read';
  Future<void> _checkFirstInstall() async {
    final prefs = await SharedPreferences.getInstance();

    String? installDate = prefs.getString('install_date');
    bool isRead = prefs.getBool(_keyNotificationRead) ?? false;

    if (installDate == null) {
      final now = DateTime.now();
      installDate = '${now.day}/${now.month}/${now.year}';
      await prefs.setString('install_date', installDate);
    }

    notifications = [
      {
        'title': 'Selamat Datang',
        'desc': 'Terima kasih telah mempercayai dan menggunakan aplikasi ini.',
        'time': installDate,
        'type': 'info',
        'read': isRead
      }
    ];

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // final List<Map<String, String>> notifications = [
    //   {
    //     'title': 'Tagihan Baru Terbit',
    //     'desc': 'Tagihan periode Januari 2026 telah diterbitkan. Silahkan cek menu Billing.',
    //     'time': '2 Jam yang lalu',
    //     'type': 'billing'
    //   },
    //   {
    //     'title': 'Pesan Baru di Mailbox',
    //     'desc': 'Anda menerima dokumen respon e-Declaration dari sistem Bea Cukai.',
    //     'time': '5 Jam yang lalu',
    //     'type': 'mail'
    //   },
    //   {
    //     'title': 'Update Sistem',
    //     'desc': 'Sistem T2G akan melakukan pemeliharaan rutin pada pukul 23:00 WIB.',
    //     'time': 'Kemarin',
    //     'type': 'info'
    //   },
    //   {
    //     'title': 'Status Dokumen Berubah',
    //     'desc': 'Dokumen ekspor anda dengan nomor ref #8821 telah disetujui.',
    //     'time': '2 Hari yang lalu',
    //     'type': 'status'
    //   },
    // ];

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.customColorRed,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          'Notifications',
          style: GoogleFonts.lato(
            color: AppColors.customColorRed,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.done_all_rounded,
                  color: AppColors.customColorRed,
                ),
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();

                    setState(() {
                      for (var item in notifications) {
                        item['read'] = true;
                      }
                    });

                    await prefs.setBool(_keyNotificationRead, true);
                  }
              ),

              if (getUnreadCount() > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      getUnreadCount().toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
            ],
          )
        ],
      ),
      body: notifications.isEmpty
          ? _buildEmptyState()
          : ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: notifications.length,
        separatorBuilder: (context, index) => const SizedBox(height: 15),
        itemBuilder: (context, index) {
          final item = notifications[index];
          return _buildNotificationItem(item);
        },
      ),
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> item) {
    IconData getIcon() {
      switch (item['type']) {
        case 'billing':
          return Icons.receipt_long_rounded;
        case 'mail':
          return Icons.email_outlined;
        case 'info':
          return Icons.info_outline_rounded;
        default:
          return Icons.notifications_none_rounded;
      }
    }

    return GestureDetector(
      onTap: () async {
        final prefs = await SharedPreferences.getInstance();

        setState(() {
          item['read'] = true;
        });

        await prefs.setBool(_keyNotificationRead, true);
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: AppBox.primary(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// DOT UNREAD INDICATOR
            if (item['read'] == false)
              Container(
                margin: const EdgeInsets.only(top: 6, right: 8),
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),

            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.customColorRed.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                getIcon(),
                color: AppColors.customColorRed,
                size: 24,
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item['title'],
                          style: GoogleFonts.lato(
                            fontSize: 14,
                            fontWeight: item['read']
                                ? FontWeight.bold
                                : FontWeight.w900,
                            color: AppColors.customColorGray,
                          ),
                        ),
                      ),
                      Text(
                        item['time'],
                        style: GoogleFonts.lato(
                          fontSize: 11,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    item['desc'],
                    style: GoogleFonts.roboto(
                      fontSize: 12,
                      color: AppColors.customColorGray.withOpacity(0.8),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off_outlined,
            size: 80,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 20),
          Text(
            'Belum ada notifikasi',
            style: GoogleFonts.lato(
              fontSize: 16,
              color: Colors.grey[500],
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  int getUnreadCount() {
    return notifications.where((n) => n['read'] == false).length;
  }
}
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trade2gov/ui/edec/edec_page.dart';
import 'package:trade2gov/ui/scan/scan_page.dart';
import '../../utils/page_transition.dart';
import '../about/about_page.dart';
import '../notify/notify_page.dart';
import '../scan/scan_page.dart';
import '../../main_navigation.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_box_decoration.dart';
import '../../data/securestorage/secure_storage_service.dart';
import '../../ui/login/login_page.dart';
import '../../data/controllers/billing_controller.dart';
import '../../data/models/billing_response_model.dart';
import '../../core/app_cache.dart';
import '../../data/models/profile_response_model.dart';
import '../../ui/splash/app_loader_page.dart';
import '../kurs/kurs_page.dart';
import '../tracking/tracking_page.dart';
import '../information/information_page.dart';
import 'package:flutter/services.dart';
import '../../widgets/animated_inverse_red_button.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onOpenInformation;
  final VoidCallback onOpenKurs;
  final VoidCallback onOpenTracking;
  final VoidCallback onOpenEdec;
  final Map<String, GlobalKey> bottomNavKeys;


  const HomePage({
    super.key,
    required this.onOpenInformation,
    required this.onOpenKurs,
    required this.onOpenTracking,
    required this.onOpenEdec,
    required this.bottomNavKeys,
  });


  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  int _guideStep = 0;

  late List<Map<String, dynamic>> _guides;
  OverlayEntry? _currentGuide;

  final GlobalKey _burgerKey = GlobalKey();
  final GlobalKey _notifyKey = GlobalKey();
  final GlobalKey _kursKey = GlobalKey();
  final GlobalKey _trackingKey = GlobalKey();
  final GlobalKey _informationKey = GlobalKey();
  final GlobalKey _edecKey = GlobalKey();

  //untuk menu Kurs / Tracking / Information
  int _activeMenu = -1;
  int _activeProduct = -1;

  bool _snackbarShown = false;

  BillingResponseModel? _latestBilling;
  bool _isBillingLoading = true;
  bool _isNoInternet = false;

  //profile drawer_loadLatestBilling
  ProfileResponseModel? _profile;

  DateTime? _lastBackPressed;

  @override
  void initState() {
    super.initState();

    _profile = AppCache.profile;

    if (AppCache.billingList.isNotEmpty) {
      _latestBilling = AppCache.billingList.first;
      _isBillingLoading = false;
    } else {
      _loadLatestBilling();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkFirstLaunchGuide();
    });

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(
      begin: 8,
      end: 18,
    ).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isActive = _activeProduct == 0;

    if (_isNoInternet) {
      return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.wifi_off,
                size: 70,
                color: AppColors.customColorRed,
              ),
              const SizedBox(height: 15),
              Text(
                "No Internet Connection",
                style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.customColorGray,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Please check your internet connection",
                style: GoogleFonts.lato(
                  fontSize: 14,
                  color: AppColors.customColorGray.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isBillingLoading = true;
                    _isNoInternet = false;
                  });
                  _loadLatestBilling();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.whiteColor,
                  foregroundColor: AppColors.customColorRed,
                  side: const BorderSide(
                    color: AppColors.customColorRed,
                  ),
                ),
                child: const Text("Retry"),
              ),
            ],
          ),
        ),
      );
    }

    return WillPopScope(
        onWillPop: () async {
          final now = DateTime.now();

          // BACK PERTAMA
          if (_lastBackPressed == null ||
              now.difference(_lastBackPressed!) > const Duration(seconds: 2)) {

            _lastBackPressed = now;

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Tekan sekali lagi untuk keluar",
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                backgroundColor: AppColors.customColorRed,
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                duration: const Duration(seconds: 2),
              ),
            );

            return false;
          }

          // BACK KEDUA → KONFIRMASI
          final shouldExit = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Keluar Aplikasi"),
              content: const Text("Apakah anda yakin ingin keluar?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text("Yes"),
                ),
              ],
            ),
          );

          if (shouldExit == true) {
            SystemNavigator.pop();
          }

          return false;
        },
    child:
    Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            key: _burgerKey,
            icon: const Icon(
              Icons.menu_outlined,
              color: AppColors.customColorRed,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        titleSpacing: 0,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Image.asset(
            'assets/images/t2g-logo.png',
            height: 24,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
          ),
        ),
        actions: [
          // IconButton(
          //   icon: const Icon(
          //     Icons.qr_code_scanner_outlined,
          //     color: AppColors.customColorRed,
          //   ),
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => const ScanPage()),
          //     );
          //   },
          // ),
          IconButton(
            key: _notifyKey,
            icon: const Icon(
              Icons.notifications_on_outlined,
              color: AppColors.customColorRed,
            ),
            onPressed: () {
              Navigator.push(
                context,
                PageTransition.slide(const NotifyPage()),
              );
            },
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Flow Diagram Section
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColors.customColorRed,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Text(
                    'Diagram Alir Proses T2G',
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/t2g-flow-diagram.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),

            // Icon Grid Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildMenuIcon(Icons.attach_money_outlined, 'Kurs', 0, key: _kursKey),
                  _buildMenuIcon(Icons.location_on_outlined, 'Tracking', 1, key: _trackingKey),
                  _buildMenuIcon(Icons.newspaper_outlined, 'Information', 2, key: _informationKey),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Section Konten Utama
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- KOTAK STATUS TAGIHAN ---
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: AppBox.primary(),
                    child: _isBillingLoading
                        ? _buildBillingLoading()
                        : _latestBilling == null
                        ? _buildNoBilling()
                        : _buildBillingContent(),
                  ),

                  const SizedBox(height: 25),

                  // --- SECTION PRODUK DIGUNAKAN ---
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Produk Digunakan',
                          style: GoogleFonts.lato(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.customColorRed,
                          ),
                        ),
                        const SizedBox(height: 10),

                        InkWell(
                          key: _edecKey,
                          onTapDown: (_) {
                            setState(() => _activeProduct = 0);
                          },
                          onTapCancel: () {
                            setState(() => _activeProduct = -1);
                          },
                          onTap: () {
                            Future.delayed(const Duration(milliseconds: 120), () {
                              widget.onOpenEdec();
                              setState(() => _activeProduct = -1);
                            });
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 120),
                            transform: Matrix4.translationValues(
                              0,
                              isActive ? 4 : 0,
                              0,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                            decoration: isActive
                                ? AppBox.menuActive()
                                : AppBox.primary(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'assets/images/e-declaration.jpg',
                                  height: 80,
                                  width: 140,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'e-Declaration',
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: isActive
                                        ? Colors.white
                                        : AppColors.customColorGray,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),


                  const SizedBox(height: 25),

                  // --- SECTION DESCRIPTION PRODUCT ---
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Description Product',
                          style: GoogleFonts.lato(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.customColorRed,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: AppBox.primary(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Logo di Tengah
                              Image.asset(
                                'assets/images/e-declaration.jpg',
                                height: 80,
                                width: 140,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) => const Icon(
                                  Icons.description_outlined,
                                  color: AppColors.customColorRed,
                                  size: 60,
                                ),
                              ),
                              const SizedBox(height: 8),
                              // Text e-Declaration
                              Text(
                                'e-Declaration',
                                style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  color: AppColors.customColorGray,
                                ),
                              ),
                              const SizedBox(height: 12),
                              // Garis Line Warna Custom Red
                              Container(
                                height: 1.5,
                                width: 300,
                                color: AppColors.customColorRed,
                              ),
                              const SizedBox(height: 15),
                              // Deskripsi Lengkap
                              Text(
                                "e-Declaration adalah aplikasi Trade2Government yang memungkinkan pengguna menyiapkan, mengirim, mencetak, dan mengelola seluruh dokumen deklarasi kepabeanan—impor, ekspor, kawasan berikat, kedatangan sarana pengangkut, dan muatan kapal—secara online kapan saja dan di mana saja, terintegrasi langsung dengan sistem Bea & Cukai menggunakan standar keamanan dan penyampaian dokumen sesuai rekomendasi World Customs Organization (WCO), dengan seluruh respon diterima otomatis oleh sistem.",
                                style: GoogleFonts.roboto(
                                  fontSize: 12,
                                  height: 1.6,
                                  color: AppColors.customColorGray,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // --- SECTION INFORMASI DAN BERITA ---
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Informasi dan Berita',
                        style: GoogleFonts.lato(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.customColorRed,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: AppBox.primary(),
                        child: Text(
                          "Belum ada informasi dan berita apapun saat ini",
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            color: AppColors.customColorGray,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    )
    );
  }

  Widget _buildMenuIcon(IconData icon, String label, int index, {Key? key}) {
    final bool isActive = _activeMenu == index;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkResponse(
          key: key,
          onTapDown: (_) {
            setState(() => _activeMenu = index);
          },
          onTapCancel: () {
            setState(() => _activeMenu = -1);
          },
          onTap: () {
            Future.delayed(const Duration(milliseconds: 100), () {
              if (index == 0) Navigator.push(
                context,
                PageTransition.slide(
                  KursPage(
                    onBackToHome: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
              if (index == 1) Navigator.push(
                context,
                PageTransition.slide(
                  TrackingPage(
                    onBackToHome: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
              if (index == 2) Navigator.push(
                context,
                PageTransition.slide(
                  InformationPage(
                    onBackToHome: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
              setState(() => _activeMenu = -1);
            });
          },
          borderRadius: BorderRadius.circular(14),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 70,
            height: 70,
            decoration: isActive ? AppBox.menuActive() : AppBox.menu(),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive
                      ? Colors.white.withOpacity(0.2)
                      : AppColors.customColorRed.withOpacity(0.1),
                ),
                child: Icon(
                  icon,
                  size: 26,
                  color: isActive
                      ? Colors.white
                      : AppColors.customColorRed,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.lato(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: isActive
                ? AppColors.customColorRed
                : AppColors.customColorGray,
          ),
        ),
      ],
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 20),
            color: AppColors.whiteColor,
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage('assets/images/person-image.png'),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _profile?.nama ?? '-',
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.customColorRed,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        _profile?.email ?? '-',
                        style: GoogleFonts.lato(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          color: AppColors.customColorRed,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          _drawerItem(Icons.home_rounded, 'Home', true, () {
            Navigator.pop(context); // Tutup drawer saja karena sudah di home
          }),
          _drawerItem(Icons.info_outline_rounded, 'About Us', false, () {
            Navigator.pop(context); // Tutup drawer
            Navigator.push(
              context,
              PageTransition.slide(const AboutPage()),
            );
          }),
          // _drawerItem(Icons.e_mobiledata_rounded, 'e-Dec', false, () {
          //   Navigator.pop(context); // Tutup drawer
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => const EdecPage()),
          //   );
          // }),
          const Spacer(),
          _drawerItem(Icons.logout_rounded, 'Logout', false, () {
            _logout(context);
          }),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String label, bool isActive, VoidCallback onTap) {
    return ListTile(
      leading: Icon(
        icon,
        color: isActive ? AppColors.customColorRed : AppColors.customColorGray,
      ),
      title: Text(
        label,
        style: GoogleFonts.lato(
          fontWeight: FontWeight.bold,
          color: isActive ? AppColors.customColorRed : AppColors.customColorGray,
        ),
      ),
      onTap: onTap,
    );
  }

  Future<void> _logout(BuildContext context) async {
    final storage = SecureStorageService();

    // hapus session
    await storage.clearSession();

    // reset cache aplikasi
    AppCache.profile = null;
    AppCache.billingList.clear();
    AppCache.welcomeShown = false;

    if (!context.mounted) return;

    Navigator.pop(context);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const AppLoaderPage()),
          (route) => false,
    );
  }

  Future<void> _showWelcomeSnackbar() async {
    if (AppCache.welcomeShown) return;

    final storage = SecureStorageService();
    final name = await storage.getUserName();

    if (!mounted || name == null || name.isEmpty) return;

    AppCache.welcomeShown = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Welcome again, $name 👋',
            style: GoogleFonts.lato(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          backgroundColor: AppColors.customColorRed,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    });
  }

  Future<void> _loadLatestBilling() async {
    try {
      final data = await BillingController.fetchBilling();

      if (data.isNotEmpty) {
        setState(() {
          _latestBilling = data.first;
          _isBillingLoading = false;
          _isNoInternet = false;
        });
      } else {
        setState(() {
          _isBillingLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isBillingLoading = false;
        _isNoInternet = true;
      });
    }
  }

  Widget _buildBillingLoading() {
    return Row(
      children: [
        const CircularProgressIndicator(
          color: AppColors.customColorRed,
          strokeWidth: 2,
        ),
        const SizedBox(width: 16),
        Text(
          "Memuat tagihan terbaru...",
          style: GoogleFonts.lato(
            fontWeight: FontWeight.w600,
            color: AppColors.customColorGray,
          ),
        ),
      ],
    );
  }

  Widget _buildNoBilling() {
    return Text(
      "Tidak ada tagihan saat ini",
      style: GoogleFonts.lato(
        fontWeight: FontWeight.w600,
        color: AppColors.customColorGray,
      ),
    );
  }

  Widget _buildBillingContent() {
    final billing = _latestBilling!;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Status:',
                    style: GoogleFonts.roboto(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.customColorGray,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Tagihan terbit',
                    style: GoogleFonts.roboto(
                      fontSize: 13,
                      color: AppColors.customColorGray,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                formatRupiah(billing.billingTotal),
                style: GoogleFonts.lato(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF389635),
                ),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Text(
                    'Periode:',
                    style: GoogleFonts.roboto(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.customColorGray,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    billing.periodeTagihan.replaceAll('-', ' '),
                    style: GoogleFonts.roboto(
                      fontSize: 13,
                      color: AppColors.customColorGray,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        AnimatedInverseRedButton(
          text: "Lihat Tagihan",
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              PageTransition.slide(
                const MainNavigation(initialIndex: 1),
              ),
                  (route) => false,
            );
          },
        )
      ],
    );
  }

  String formatRupiah(int value) {
    return 'Rp ${value.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]}.',
    )}';
  }

  Future<void> _checkFirstLaunchGuide() async {
    final storage = SecureStorageService();
    final isFirst = await storage.isFirstLaunch();

    if (!isFirst) return;

    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;

    _showGuideSequence();

    await storage.setFirstLaunchDone();
  }

  void _showGuideSequence() {

    _guides = [
      {"key": _burgerKey, "text": "Gunakan menu ini untuk membuka navigasi utama aplikasi."},
      {"key": _notifyKey, "text": "Di sini Anda dapat melihat notifikasi terbaru dari sistem."},
      {"key": _kursKey, "text": "Menu ini menampilkan informasi kurs pajak terbaru."},
      {"key": _trackingKey, "text": "Gunakan menu ini untuk melakukan tracking dokumen kepabeanan Anda."},
      {"key": _informationKey, "text": "Berisi berbagai berita dan informasi terbaru terkait layanan."},
      {"key": _edecKey, "text": "Akses layanan e-Declaration untuk mengelola dokumen kepabeanan Anda."},
      {"key": widget.bottomNavKeys["home"], "text": "Halaman utama aplikasi tempat Anda melihat ringkasan informasi."},
      {"key": widget.bottomNavKeys["billing"], "text": "Di sini Anda dapat melihat dan memeriksa tagihan layanan Anda."},
      {"key": widget.bottomNavKeys["call center"], "text": "Hubungi tim dukungan kami melalui menu Call Center."},
      {"key": widget.bottomNavKeys["mailbox"], "text": "Cek pesan atau pemberitahuan sistem yang dikirim kepada Anda."},
      {"key": widget.bottomNavKeys["profile"], "text": "Kelola informasi akun dan profil Anda melalui menu ini."},
    ];

    _guideStep = 0;

    _showGuideStep();
  }

  void _showGuideStep() {

    if (_guideStep >= _guides.length) {
      _currentGuide?.remove();
      return;
    }

    final item = _guides[_guideStep];

    final key = item["key"] as GlobalKey;
    final text = item["text"] as String;

    _showGuide(key, text);
  }

  void _showGuide(GlobalKey key, String text) {
    final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    final screenHeight = MediaQuery.of(context).size.height;

    double textTop;
    bool showBelow = position.dy < screenHeight * 0.5;
    bool isBottomArea = position.dy > screenHeight * 0.75;

    const double textSpacing = 30; // jarak antara highlight dan text

    if (showBelow) {
      // highlight di atas → text di bawah
      textTop = position.dy + size.height + textSpacing;
    } else {
      // highlight di bawah → text di atas
      textTop = position.dy - textSpacing - 60;
    }

    _currentGuide?.remove();

    _currentGuide = OverlayEntry(
      builder: (context) => AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          bool isIconOnly = key == _burgerKey || key == _notifyKey;
          return Stack(
            children: [

              CustomPaint(
                size: MediaQuery.of(context).size,
                painter: GuidePainter(
                  rect: Rect.fromLTWH(
                    position.dx - 6,
                    position.dy - 6,
                    size.width + 12,
                    size.height + (isIconOnly ? 12 : 30),
                  ),
                  pulse: _pulseAnimation.value,
                ),
              ),

              // TEXT PENJELASAN
              Positioned(
                top: textTop,
                left: 30,
                right: 30,
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      height: 1.6,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),

              // SKIP BUTTON
              Positioned(
                top: isBottomArea ? 50 : null,
                bottom: isBottomArea ? null : 40,
                left: 20,
                child: TextButton(
                  onPressed: () {
                    _currentGuide?.remove();
                  },
                  child: Text(
                    "Skip",
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),

              // NEXT BUTTON
              Positioned(
                top: isBottomArea ? 50 : null,
                bottom: isBottomArea ? null : 40,
                right: 20,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    _guideStep++;
                    _showGuideStep();
                  },
                  child: Text(
                    _guideStep == _guides.length - 1 ? "Finish" : "Next",
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );

    Overlay.of(context).insert(_currentGuide!);
  }
}

class GuidePainter extends CustomPainter {

  final Rect rect;
  final double pulse;

  GuidePainter({
    required this.rect,
    required this.pulse,
  });

  @override
  void paint(Canvas canvas, Size size) {

    final overlayPaint = Paint()
      ..color = Colors.black.withOpacity(0.85);

    final clearPaint = Paint()
      ..blendMode = BlendMode.clear;

    canvas.saveLayer(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint(),
    );

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      overlayPaint,
    );

    final rrect = RRect.fromRectAndRadius(
      rect.inflate(10),
      const Radius.circular(14),
    );

    canvas.drawRRect(rrect, clearPaint);

    canvas.restore();

    // PULSE GLOW
    final glowPaint = Paint()
      ..color = Colors.white.withOpacity(0.45)
      ..style = PaintingStyle.stroke
      ..strokeWidth = pulse;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        rect.inflate(pulse),
        const Radius.circular(16),
      ),
      glowPaint,
    );
  }

  @override
  bool shouldRepaint(covariant GuidePainter oldDelegate) => true;
}
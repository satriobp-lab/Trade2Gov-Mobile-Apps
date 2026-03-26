import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../ui/home/home_page.dart';
import 'ui/billing/billing_page.dart';
import 'ui/callcenter/call_center_page.dart';
import 'ui/mailbox/mailbox_tab.dart';
import 'ui/profile/profile_page.dart';

import 'ui/information/information_page.dart';
import 'ui/kurs/kurs_page.dart';
import 'ui/tracking/tracking_page.dart';
import 'ui/edec/edec_page.dart';

import 'ui/home/section/home_section.dart';
import '../utils/app_colors.dart';

class MainNavigation extends StatefulWidget {
  final int initialIndex;

  const MainNavigation({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  final GlobalKey _homeNavKey = GlobalKey();
  final GlobalKey _billingNavKey = GlobalKey();
  final GlobalKey _callCenterNavKey = GlobalKey();
  final GlobalKey _mailboxNavKey = GlobalKey();
  final GlobalKey _profileNavKey = GlobalKey();

  late int _selectedIndex;
  HomeSection _homeSection = HomeSection.home;

  bool _hideBottomNav() {
    return _homeSection == HomeSection.kurs ||
        _homeSection == HomeSection.information ||
        _homeSection == HomeSection.tracking;
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  // ===== HOME TAB SWITCHER =====
  Widget _buildHomeTab() {
    switch (_homeSection) {
      case HomeSection.information:
        return InformationPage(
          onBackToHome: _backToHome,
        );
      case HomeSection.kurs:
        return KursPage(
          onBackToHome: _backToHome,
        );
      case HomeSection.tracking:
        return TrackingPage(
          onBackToHome: _backToHome,
        );
      case HomeSection.edec:
        return const EdecPage();
      case HomeSection.home:
      default:
      return HomePage(
        onOpenInformation: _openInformation,
        onOpenKurs: _openKurs,
        onOpenTracking: _openTracking,
        onOpenEdec: _openEdec,
        bottomNavKeys: {
          "home": _homeNavKey,
          "billing": _billingNavKey,
          "call center": _callCenterNavKey,
          "mailbox": _mailboxNavKey,
          "profile": _profileNavKey,
        },
      );
    }
  }


  void _backToHome() {
    setState(() {
      _selectedIndex = 0;
      _homeSection = HomeSection.home;
    });
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        _homeSection = HomeSection.home;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 450),
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: IndexedStack(
          key: ValueKey(_selectedIndex),
          index: _selectedIndex,
          children: [
            _buildHomeTab(),
            const BillingPage(),
            const CallCenterPage(),
            const MailboxTab(),
            const ProfilePage(),
          ],
        ),
      ),
      bottomNavigationBar: _hideBottomNav()
          ? null
          : BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.customColorRed,
        unselectedItemColor: AppColors.customColorGray,
        selectedLabelStyle: GoogleFonts.lato(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        unselectedLabelStyle: GoogleFonts.lato(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded, key: _homeNavKey),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_rounded, key: _billingNavKey),
            label: 'Billing',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.support_agent_rounded, key: _callCenterNavKey),
            label: 'Call Center',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.email_outlined, key: _mailboxNavKey),
            label: 'Mailbox',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, key: _profileNavKey),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // ===== CALLBACKS DARI HOME =====
  void _openInformation() {
    setState(() {
      _selectedIndex = 0;
      _homeSection = HomeSection.information;
    });
  }

  void _openKurs() {
    setState(() {
      _selectedIndex = 0;
      _homeSection = HomeSection.kurs;
    });
  }

  void _openTracking() {
    setState(() {
      _selectedIndex = 0;
      _homeSection = HomeSection.tracking;
    });
  }

  void _openEdec() {
    setState(() {
      _selectedIndex = 0;
      _homeSection = HomeSection.edec;
    });
  }
}


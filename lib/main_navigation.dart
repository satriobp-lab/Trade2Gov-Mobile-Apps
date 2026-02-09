import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../home/home_page.dart';
import '../billing/billing_page.dart';
import '../callcenter/call_center_page.dart';
import '../mailbox/mailbox_tab.dart';
import '../profile/profile_page.dart';

import '../information/information_page.dart';
import '../kurs/kurs_page.dart';
import '../tracking/tracking_page.dart';
import '../edec/edec_page.dart';

import '../home/section/home_section.dart';
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
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildHomeTab(),
          const BillingPage(),
          const CallCenterPage(),
          const MailboxTab(),
          const ProfilePage(),
        ],
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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_rounded),
            label: 'Billing',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.support_agent_rounded),
            label: 'Call Center',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.email_outlined),
            label: 'Mailbox',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
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


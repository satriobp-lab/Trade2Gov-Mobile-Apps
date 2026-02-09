import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';
import '../utils/app_box_decoration.dart';

class InformationPage extends StatefulWidget {
  final VoidCallback onBackToHome;

  const InformationPage({
    super.key,
    required this.onBackToHome,
  });

  @override
  State<InformationPage> createState() => _InformationPageState();
}


class _InformationPageState extends State<InformationPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Daftar path gambar sesuai instruksi Anda
  final List<String> _infoImages = [
    'assets/images/information-pdeinternet.png',
    'assets/images/information-integrated.png',
    'assets/images/information-simplicity.png',
    'assets/images/information-innovative.png',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _infoImages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.customColorRed,
          ),
          onPressed: widget.onBackToHome,
        ),
        automaticallyImplyLeading: false,
        title: Text(
          'Information',
          style: GoogleFonts.lato(
            color: AppColors.customColorRed,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: AppColors.customColorRed.withOpacity(0.3),
            height: 1.0,
            margin: const EdgeInsets.symmetric(horizontal: 25),
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                // Slider Container
                Container(
                  height: 220,
                  decoration: AppBox.menuActive().copyWith(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // PageView untuk Gambar
                      PageView.builder(
                        controller: _pageController,
                        onPageChanged: (int index) {
                          setState(() {
                            _currentPage = index;
                          });
                        },
                        itemCount: _infoImages.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                _infoImages[index],
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  color: Colors.white24,
                                  child: const Icon(Icons.image, color: Colors.white, size: 50),
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      // Tombol Panah Kiri
                      if (_currentPage > 0)
                        Positioned(
                          left: 10,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 28),
                            onPressed: _previousPage,
                          ),
                        ),

                      // Tombol Panah Kanan
                      if (_currentPage < _infoImages.length - 1)
                        Positioned(
                          right: 10,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 28),
                            onPressed: _nextPage,
                          ),
                        ),

                      // Indikator Titik (Dots)
                      Positioned(
                        bottom: 15,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            _infoImages.length,
                                (index) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentPage == index
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.4),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_box_decoration.dart';

class TrackingPage extends StatefulWidget {
  final VoidCallback onBackToHome;

  const TrackingPage({
    super.key,
    required this.onBackToHome,
  });

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}



class _TrackingPageState extends State<TrackingPage> {
  String? _selectedDocument;
  String? _tempSelectedDocument; // Untuk menampung pilihan sementara di dialog
  final TextEditingController _kpbcController = TextEditingController();
  final TextEditingController _nomorAjuController = TextEditingController();

  @override
  void dispose() {
    _kpbcController.dispose();
    _nomorAjuController.dispose();
    super.dispose();
  }

  // Fungsi untuk menampilkan Custom Dialog pilihan dokumen
  void _showDocumentDialog() {
    _tempSelectedDocument = _selectedDocument; // Reset pilihan sementara ke pilihan saat ini

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dokumen',
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.customColorRed,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Divider(color: AppColors.customColorRed.withOpacity(0.5), thickness: 1),

                    // Opsi PIB
                    RadioListTile<String>(
                      title: Text('PIB', style: GoogleFonts.roboto(fontSize: 14)),
                      value: 'PIB',
                      groupValue: _tempSelectedDocument,
                      activeColor: AppColors.customColorRed,
                      onChanged: (value) {
                        setDialogState(() => _tempSelectedDocument = value);
                      },
                    ),

                    // Opsi PEB
                    RadioListTile<String>(
                      title: Text('PEB', style: GoogleFonts.roboto(fontSize: 14)),
                      value: 'PEB',
                      groupValue: _tempSelectedDocument,
                      activeColor: AppColors.customColorRed,
                      onChanged: (value) {
                        setDialogState(() => _tempSelectedDocument = value);
                      },
                    ),

                    Divider(color: AppColors.customColorRed.withOpacity(0.5), thickness: 1),

                    // Tombol Aksi
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.roboto(
                              color: AppColors.customColorRed,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _selectedDocument = _tempSelectedDocument;
                            });
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Ok',
                            style: GoogleFonts.roboto(
                              color: AppColors.customColorRed,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
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
          'Tracking',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Field Dokumen (Sekarang menggunakan InkWell untuk trigger Dialog)
            _buildLabel('Dokumen'),
            const SizedBox(height: 10),
            InkWell(
              onTap: _showDocumentDialog,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 55,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: AppBox.primary(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedDocument ?? 'Choose Document',
                      style: GoogleFonts.roboto(
                        color: _selectedDocument == null
                            ? AppColors.customColorGray.withOpacity(0.5)
                            : AppColors.customColorGray,
                        fontSize: 14,
                      ),
                    ),
                    const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColors.customColorRed
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Field KPBC
            _buildLabel('KPBC'),
            const SizedBox(height: 10),
            Container(
              height: 55,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: AppBox.primary(),
              alignment: Alignment.center,
              child: TextField(
                controller: _kpbcController,
                style: GoogleFonts.roboto(color: AppColors.customColorGray, fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Input KPBC',
                  hintStyle: GoogleFonts.roboto(
                    color: AppColors.customColorGray.withOpacity(0.5),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Field Nomor Aju
            _buildLabel('Nomor Aju'),
            const SizedBox(height: 10),
            Container(
              height: 55,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: AppBox.primary(),
              alignment: Alignment.center,
              child: TextField(
                controller: _nomorAjuController,
                style: GoogleFonts.roboto(color: AppColors.customColorGray, fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Input Nomor Aju',
                  hintStyle: GoogleFonts.roboto(
                    color: AppColors.customColorGray.withOpacity(0.5),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Search Button
            Center(
              child: SizedBox(
                width: 180,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    // if (_selectedDocument == null) {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(
                    //       content: Text(
                    //         'Silakan pilih dokumen terlebih dahulu',
                    //         style: GoogleFonts.roboto(color: Colors.white),
                    //       ),
                    //       backgroundColor: Colors.red,
                    //     ),
                    //   );
                    //   return;
                    // }
                    //
                    // if (_kpbcController.text.trim().isEmpty) {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(
                    //       content: Text(
                    //         'Silakan isi KPBC terlebih dahulu',
                    //         style: GoogleFonts.roboto(color: Colors.white),
                    //       ),
                    //       backgroundColor: Colors.red,
                    //     ),
                    //   );
                    //   return;
                    // }
                    //
                    // if (_nomorAjuController.text.trim().isEmpty) {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(
                    //       content: Text(
                    //         'Silakan isi Nomor Aju terlebih dahulu',
                    //         style: GoogleFonts.roboto(color: Colors.white),
                    //       ),
                    //       backgroundColor: Colors.red,
                    //     ),
                    //   );
                    //   return;
                    // }

                    // 🔥 Maintenance Mode
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        title: Text(
                          'Maintenance',
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                            color: AppColors.customColorRed,
                          ),
                        ),
                        content: Text(
                          'Fitur Tracking saat ini sedang dalam maintenance.\n\nSilakan coba kembali nanti.',
                          style: GoogleFonts.roboto(
                            color: AppColors.customColorGray,
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'OK',
                              style: GoogleFonts.roboto(
                                color: AppColors.customColorRed,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.customColorRed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 2,
                  ),
                  child: Text(
                    'Search',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.lato(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: AppColors.customColorRed,
      ),
    );
  }
}
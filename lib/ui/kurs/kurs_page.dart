import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_box_decoration.dart';

class KursPage extends StatefulWidget {
  final VoidCallback onBackToHome;

  const KursPage({
    super.key,
    required this.onBackToHome,
  });

  @override
  State<KursPage> createState() => _KursPageState();
}


class _KursPageState extends State<KursPage> {
  final TextEditingController _dateController = TextEditingController();
  String? _selectedValuta;

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
          onPressed: widget.onBackToHome, // 🔥 balik ke home
        ),
        automaticallyImplyLeading: false,
        title: Text(
          'Kurs',
          style: GoogleFonts.lato(
            color: AppColors.customColorRed,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        // Menggunakan gaya bottom yang sama dengan InformationPage
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
            // Field Tanggal
            Text(
              'Tanggal',
              style: GoogleFonts.lato(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.customColorRed,
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  setState(() {
                    _dateController.text = "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                  });
                }
              },
              child: Container(
                height: 55,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: AppBox.primary(),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_month_outlined, color: AppColors.customColorRed),
                    const SizedBox(width: 15),
                    Text(
                      _dateController.text.isEmpty ? 'Input Tanggal' : _dateController.text,
                      style: GoogleFonts.roboto(
                        color: _dateController.text.isEmpty
                            ? AppColors.customColorGray.withOpacity(0.5)
                            : AppColors.customColorGray,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Field Valuta
            Text(
              'Valuta',
              style: GoogleFonts.lato(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.customColorRed,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 55,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: AppBox.primary(),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedValuta,
                  hint: Row(
                    children: [
                      const Icon(Icons.attach_money_rounded, color: AppColors.customColorRed),
                      const SizedBox(width: 15),
                      Text(
                        'Choose Valuta',
                        style: GoogleFonts.roboto(
                          color: AppColors.customColorGray.withOpacity(0.5),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  // Agar ikon tetap muncul setelah valuta dipilih
                  selectedItemBuilder: (BuildContext context) {
                    return <String>['USD', 'SGD', 'EUR', 'JPY', 'CNY'].map((String value) {
                      return Row(
                        children: [
                          const Icon(Icons.attach_money_rounded, color: AppColors.customColorRed),
                          const SizedBox(width: 15),
                          Text(
                            value,
                            style: GoogleFonts.roboto(
                              color: AppColors.customColorGray,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      );
                    }).toList();
                  },
                  icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.customColorRed),
                  isExpanded: true,
                  items: <String>['USD', 'SGD', 'EUR', 'JPY', 'CNY'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: GoogleFonts.roboto(color: AppColors.customColorGray)),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedValuta = val;
                    });
                  },
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
                  onPressed: () {},
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
}
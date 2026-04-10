import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_box_decoration.dart';
import '../../../../../../widgets/edec_loader.dart';
import '../../../../../../widgets/network_edec_state_widget.dart';
import 'package:trade2gov/data/controllers/pibk/pibk_harga_controller.dart';
import 'package:trade2gov/data/models/pibk/pibk_harga_response_model.dart';

class PibkHargaDetailsPage extends StatefulWidget {
  final String car;

  const PibkHargaDetailsPage({
    super.key,
    required this.car,
  });

  @override
  State<PibkHargaDetailsPage> createState() => _PibkHargaDetailsPageState();
}

class _PibkHargaDetailsPageState
    extends State<PibkHargaDetailsPage> {

  late Future<PibkHargaResponseModel?> _futureHarga;
  late final NumberFormat _rupiahFormat;

  @override
  void initState() {
    super.initState();

    _rupiahFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 2,
    );

    _futureHarga = PibkHargaController.getPibkHarga(widget.car);
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> hargaData = {
      'Valuta': 'USD - US Dollar',
      'NDPBM': 'Rp. 16.786',
      'Nilai CIF': '124.451,68',
      'Asuransi LN': '-',
      'Freight': '-',
      'Nilai Pabean': '124.451,68',
      'CIF (Rp)': 'Rp. 2.089.045.900,48',
      'Berat Kotor (KG)': '20.966',
      'Berat Bersih (KG)': '-',
    };

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: AppColors.customColorRed),
          onPressed: () => Navigator.pop(context),
        ),
        toolbarHeight: 80,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'PIBK Harga Details',
              style: GoogleFonts.lato(
                color: AppColors.customColorRed,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.car,
              style: GoogleFonts.lato(
                fontSize: 13,
                color: AppColors.customColorGray,
              ),
            ),
          ],
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
      body: FutureBuilder<PibkHargaResponseModel?>(
        future: _futureHarga,
        builder: (context, snapshot) {

          /// LOADING
          if (snapshot.connectionState == ConnectionState.waiting) {
            return NetworkEdecStateWidget(
              isLoading: true,
              isNoInternet: false,
              loadingText: "Loading PIBK Data Harga Details...",
              onRetry: () {},
              child: const SizedBox(),
            );
          }

          /// ERROR / NO INTERNET
          if (snapshot.hasError) {
            return NetworkEdecStateWidget(
              isLoading: false,
              isNoInternet: true,
              onRetry: () {
                // Perbaikan: Refresh future tanpa navigasi ulang
                setState(() {
                  _futureHarga = PibkHargaController.getPibkHarga(widget.car);
                });
              },
              child: const SizedBox(),
            );
          }

          final data = snapshot.data;

          if (data == null || data.isEmpty) {
            return _buildEmptyState();
          }

          final Map<String, String> hargaData = {
            'Valuta': '${data.kdVal ?? '-'} - ${data.urKdVal ?? '-'}',
            'NDPBM': 'Rp. ${data.ndpbm ?? 0}',
            'Nilai CIF': '${data.cif ?? 0}',
            'Asuransi LN': '${data.asuransi ?? 0}',
            'Freight': '${data.freight ?? 0}',
            'Nilai Pabean': '${data.cif ?? 0}',
            'CIF (Rp)': _formatRupiah(data.cifRp),
            'Berat Kotor (KG)': '${data.bruto ?? 0}',
            'Berat Bersih (KG)': '${data.netto ?? 0}',
          };

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Container(
              decoration: AppBox.primary(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            color: AppColors.customColorRed.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.price_change_rounded,
                            color: AppColors.customColorRed,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Rincian Harga',
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.customColorRed,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      height: 1.2,
                      color: AppColors.customColorRed.withOpacity(0.25),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildHargaRow('Valuta', hargaData['Valuta']!),
                        _buildHargaRow('NDPBM', hargaData['NDPBM']!),
                        _buildHargaRow('Nilai CIF', hargaData['Nilai CIF']!),
                        _buildHargaRow('Asuransi LN', hargaData['Asuransi LN']!),
                        _buildHargaRow('Freight', hargaData['Freight']!),
                        _buildHargaRow('Nilai Pabean', hargaData['Nilai Pabean']!),
                        _buildHargaRow('CIF (Rp)', hargaData['CIF (Rp)']!, isHighlight: true),
                        _buildHargaRow('Berat Kotor (KG)', hargaData['Berat Kotor (KG)']!),
                        _buildHargaRow('Berat Bersih (KG)', hargaData['Berat Bersih (KG)']!),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHargaRow(String label, String value, {bool isHighlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: GoogleFonts.lato(
                fontSize: 13,
                color: AppColors.customColorGray,
              ),
            ),
          ),
          Text(
            ': ',
            style: GoogleFonts.roboto(
              fontSize: 13,
              color: AppColors.customColorGray,
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.left,
              style: GoogleFonts.roboto(
                fontSize: 13,
                fontWeight: isHighlight ? FontWeight.bold : FontWeight.w500,
                color: isHighlight ? AppColors.customColorRed : AppColors.customColorGray,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.customColorRed.withOpacity(0.08),
              ),
              child: const Icon(
                Icons.price_change_outlined,
                size: 70,
                color: AppColors.customColorRed,
              ),
            ),
            const SizedBox(height: 25),
            Text(
              "Data Harga Tidak Ditemukan",
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.customColorRed,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Belum terdapat data harga untuk CAR ini.\nSilakan periksa kembali data Anda.",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: 13,
                color: AppColors.customColorGray,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatRupiah(double? value) {
    if (value == null) return '-';
    return _rupiahFormat.format(value);
  }
}
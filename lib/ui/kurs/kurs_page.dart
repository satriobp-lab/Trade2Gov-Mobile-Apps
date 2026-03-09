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

  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> filteredValuta = [];

  @override
  void initState() {
    super.initState();
    filteredValuta = valutaList;
  }


  final List<Map<String, String>> valutaList = [
    {"code":"ADP","desc":"Andorran Peseta"},
    {"code":"AED","desc":"UAE Dirham"},
    {"code":"AFA","desc":"Afghani"},
    {"code":"AFN","desc":"Afghani"},
    {"code":"ALL","desc":"Lek"},
    {"code":"AMD","desc":"Armenian Dram"},
    {"code":"ANG","desc":"Netherlands Antillian Guilder"},
    {"code":"AOA","desc":"Kwanza"},
    {"code":"AON","desc":"New Kwanza"},
    {"code":"ARS","desc":"Argentina Peso"},
    {"code":"ATS","desc":"Schilling"},
    {"code":"AUD","desc":"Australian Dollar"},
    {"code":"AWG","desc":"Aruban Guilder"},
    {"code":"AZM","desc":"Azerbaijanian Manat"},
    {"code":"AZN","desc":"Azerbaijanian Manat"},
    {"code":"BAM","desc":"Convertible Marks"},
    {"code":"BBD","desc":"Barbados Dollar"},
    {"code":"BDT","desc":"Taka"},
    {"code":"BEF","desc":"Belgian Franc"},
    {"code":"BGL","desc":"Lev"},
    {"code":"BGN","desc":"Bulgarian Lev"},
    {"code":"BHD","desc":"Bahraini Dinar"},
    {"code":"BIF","desc":"Burundi Franc"},
    {"code":"BMD","desc":"Bermudian Dollar"},
    {"code":"BND","desc":"Brunei Dollar"},
    {"code":"BOB","desc":"Boliaiano"},
    {"code":"BOV","desc":"Mvdol"},
    {"code":"BRL","desc":"Brazilian Real"},
    {"code":"BSD","desc":"Bahamian Dollar"},
    {"code":"BTN","desc":"Ngultrum"},
    {"code":"BUK","desc":"Burman Kyat"},
    {"code":"BWP","desc":"Pula"},
    {"code":"BYB","desc":"Belarussian Ruble"},
    {"code":"BYR","desc":"Belarussian Ruble"},
    {"code":"BZD","desc":"Belize Dollar"},
    {"code":"CAD","desc":"Canadian Dollar"},
    {"code":"CDF","desc":"Congolese Franc"},
    {"code":"CHE","desc":"WIR Euro"},
    {"code":"CHF","desc":"Swiss Franc"},
    {"code":"CHW","desc":"WIR Franc"},
    {"code":"CLF","desc":"Unidades de fomento"},
    {"code":"CLP","desc":"Chilean Peso"},
    {"code":"CNY","desc":"Yuan Renminbi"},
    {"code":"COP","desc":"Colombian Peso"},
    {"code":"COU","desc":"Unidad de Valor Real"},
    {"code":"CRC","desc":"Costa Rican Colon"},
    {"code":"CUC","desc":"Peso Convertible"},
    {"code":"CUP","desc":"Cuban Peso"},
    {"code":"CVE","desc":"Cape Verde Escudo"},
    {"code":"CYP","desc":"Cyprus Pound"},
    {"code":"CZK","desc":"Czech Koruna"},
    {"code":"DEM","desc":"Deustche Mark"},
    {"code":"DJF","desc":"Djibouti Franc"},
    {"code":"DKK","desc":"Danish Krone"},
    {"code":"DOP","desc":"Domincan Peso"},
    {"code":"DZD","desc":"Algerian Dinar"},
    {"code":"ECS","desc":"Sucre"},
    {"code":"EEK","desc":"Kroon"},
    {"code":"EGP","desc":"Egyptian Pound"},
    {"code":"ERN","desc":"Nakfa"},
    {"code":"ESP","desc":"Spainish peseta"},
    {"code":"ETB","desc":"Ethiopian Birr"},
    {"code":"EUR","desc":"EURO"},
    {"code":"FIM","desc":"Markka"},
    {"code":"FJD","desc":"Fiji Dollar"},
    {"code":"FKP","desc":"Falkland Islands Pound"},
    {"code":"FRF","desc":"Franch Franc"},
    {"code":"GBP","desc":"Pound Sterling"},
    {"code":"GEK","desc":"Georgian Coupon"},
    {"code":"GEL","desc":"Lari"},
    {"code":"GHC","desc":"Cedi"},
    {"code":"GHS","desc":"Cedi"},
    {"code":"GIP","desc":"Gibraltar Pound"},
    {"code":"GMD","desc":"Dalasi"},
    {"code":"GNF","desc":"Guinea Franc"},
    {"code":"GRD","desc":"Drachma"},
    {"code":"GTQ","desc":"Quetzal"},
    {"code":"GWP","desc":"Guinea-Bissau Peso"},
    {"code":"GYD","desc":"Guyana Dollar"},
    {"code":"HKD","desc":"Hong Kong Dollar"},
    {"code":"HNL","desc":"Lempira"},
    {"code":"HRD","desc":"Croatian Dinar"},
    {"code":"HRK","desc":"Kuna"},
    {"code":"HTG","desc":"Gourde"},
    {"code":"HUF","desc":"Forint"},
    {"code":"IDR","desc":"Rupiah"},
    {"code":"IEP","desc":"Irish Pound"},
    {"code":"ILS","desc":"Shekel"},
    {"code":"INR","desc":"Indian Rupee"},
    {"code":"IQD","desc":"Iraqi Dinar"},
    {"code":"IRR","desc":"Iranian Rial"},
    {"code":"ISK","desc":"Iceland Krona"},
    {"code":"ITL","desc":"Italian Lira"},
    {"code":"JMD","desc":"Jamaican Dollar"},
    {"code":"JOD","desc":"Jordanian Dinar"},
    {"code":"JPY","desc":"Yen"},
    {"code":"KES","desc":"Kenyan Shilling"},
    {"code":"KGS","desc":"Som"},
    {"code":"KHR","desc":"Riel"},
    {"code":"KMF","desc":"Comoro Franc"},
    {"code":"KPW","desc":"North Korean Won"},
    {"code":"KRW","desc":"Won"},
    {"code":"KWD","desc":"Kuwauti Dinar"},
    {"code":"KYD","desc":"Cayman Islands Dollar"},
    {"code":"KZT","desc":"Tenge"},
    {"code":"LAK","desc":"Kip"},
    {"code":"LBP","desc":"Lebanese Pound"},
    {"code":"LKR","desc":"Sri Langka Rupee"},
    {"code":"LRD","desc":"Liberian Dollar"},
    {"code":"LSL","desc":"Loli"},
    {"code":"LTL","desc":"Lithuanian Litas"},
    {"code":"LUF","desc":"Luxembourg Franc"},
    {"code":"LVL","desc":"Latvian Lats"},
    {"code":"LVR","desc":"Latvian Ruble"},
    {"code":"LYD","desc":"Libyan Dinar"},
    {"code":"MAD","desc":"Moroccoan Dirham"},
    {"code":"MDL","desc":"Moldovan Leu"},
    {"code":"MGA","desc":"Malagasy Ariary"},
    {"code":"MGF","desc":"Malagasy Franc"},
    {"code":"MKD","desc":"Denar"},
    {"code":"MMK","desc":"Kyat"},
    {"code":"MNT","desc":"Tugrik"},
    {"code":"MOP","desc":"Pataca"},
    {"code":"MRO","desc":"Ouguiya"},
    {"code":"MTL","desc":"Mallese Lira"},
    {"code":"MUR","desc":"Mauritius Pupee"},
    {"code":"MVR","desc":"Rufiyaa"},
    {"code":"MWK","desc":"Kwacha"},
    {"code":"MXN","desc":"Mexican Nuevo Peso"},
    {"code":"MXV","desc":"Mexican Unidad de Inversion"},
    {"code":"MYR","desc":"Malaysian Ringgit"},
    {"code":"MZM","desc":"Metical"},
    {"code":"MZN","desc":"Metical"},
    {"code":"NAD","desc":"Namibia Dollar"},
    {"code":"NGN","desc":"Naira"},
    {"code":"NIO","desc":"Cordoba Oro"},
    {"code":"NLG","desc":"Netherlands Guilder"},
    {"code":"NOK","desc":"Norwegian Krone"},
    {"code":"NPR","desc":"Nepalese Rupee"},
    {"code":"NZD","desc":"New Zealand Dollar"},
    {"code":"OMR","desc":"Rial Omani"},
    {"code":"PAB","desc":"Balboa/US Dollar"},
    {"code":"PEN","desc":"Nuevo Sol"},
    {"code":"PGK","desc":"Kina"},
    {"code":"PHP","desc":"Philippines Peso"},
    {"code":"PKR","desc":"Pakistan Rupee"},
    {"code":"PLN","desc":"Zloty"},
    {"code":"PLZ","desc":"Zloty"},
    {"code":"PTE","desc":"Portuguese Escudo"},
    {"code":"PYG","desc":"Guarani"},
    {"code":"QAR","desc":"Qatari Rial"},
    {"code":"ROL","desc":"Leu"},
    {"code":"RON","desc":"New Leu"},
    {"code":"RSD","desc":"Serbian Dinar"},
    {"code":"RUB","desc":"Russian Ruble"},
    {"code":"RUR","desc":"Russian Ruble"},
    {"code":"RWF","desc":"Rwanda Franc"},
    {"code":"SAR","desc":"Saudi Riyal"},
    {"code":"SBD","desc":"Solomon Islands Dollar"},
    {"code":"SCR","desc":"Seychelles Rupee"},
    {"code":"SDD","desc":"Sudanase Dinar"},
    {"code":"SDG","desc":"Sudanese Pound"},
    {"code":"SDP","desc":"Sudanese Pound"},
    {"code":"SEK","desc":"Swedish Krone"},
    {"code":"SGD","desc":"Singapore Dollar"},
    {"code":"SHP","desc":"St. Helena Pound"},
    {"code":"SIT","desc":"Tolar"},
    {"code":"SKK","desc":"Slovak Koruna"},
    {"code":"SLL","desc":"Leone"},
    {"code":"SOS","desc":"Somalia shilling"},
    {"code":"SRD","desc":"Surinam Dollar"},
    {"code":"SRG","desc":"Surinam Guilder"},
    {"code":"STD","desc":"Dobra"},
    {"code":"SVC","desc":"El Salvador Colon"},
    {"code":"SYP","desc":"Syrian Pound"},
    {"code":"SZL","desc":"Lilangeni"},
    {"code":"THB","desc":"Baht"},
    {"code":"TJS","desc":"Somoni"},
    {"code":"TMM","desc":"Manat"},
    {"code":"TMT","desc":"Manat"},
    {"code":"TND","desc":"Tunisian Dinar"},
    {"code":"TOP","desc":"Pa'anga"},
    {"code":"TRL","desc":"Turkish Lira"},
    {"code":"TRY","desc":"Turkish Lira"},
    {"code":"TTD","desc":"Trinidad and Tobago Dollar"},
    {"code":"TWD","desc":"New Taiwan Dollar"},
    {"code":"TZS","desc":"Tanzania Shilling"},
    {"code":"UAH","desc":"Hryvnia"},
    {"code":"UAK","desc":"Karbovanet"},
    {"code":"UGX","desc":"Uganda Shilling"},
    {"code":"USD","desc":"US Dollar"},
    {"code":"UYI","desc":"Uruguay Peso en Unidades Index"},
    {"code":"UYU","desc":"Peso Uruguayo"},
    {"code":"UZS","desc":"Ubekistan Sum"},
    {"code":"VEB","desc":"Bolivar"},
    {"code":"VEF","desc":"Bolivar Fuerte"},
    {"code":"VND","desc":"Dong"},
    {"code":"VUV","desc":"Vatu"},
    {"code":"WST","desc":"Tala"},
    {"code":"XAF","desc":"CFA Franc BAEC"},
    {"code":"XAG","desc":"Silver"},
    {"code":"XAU","desc":"Gold"},
    {"code":"XBA","desc":"Bond Markets Units European Composite"},
    {"code":"XBB","desc":"European Monetary Unit"},
    {"code":"XBC","desc":"European Unit of Account 9"},
    {"code":"XBD","desc":"European Unit of Account 17"},
    {"code":"XCD","desc":"East Caribbean Dollar"},
    {"code":"XDR","desc":"SDR"},
    {"code":"XFU","desc":"UIC-Franc"},
    {"code":"XOF","desc":"CFA Franc BCEAO"},
    {"code":"XPD","desc":"Palladium"},
    {"code":"XPF","desc":"CFA Franc BEAC"},
    {"code":"XPT","desc":"Platinum"},
    {"code":"YER","desc":"Yemeni Rial"},
    {"code":"YUN","desc":"New Yugosslavian"},
    {"code":"ZAL","desc":"Financial Rand"},
    {"code":"ZAR","desc":"Rand"},
    {"code":"ZMK","desc":"Kwacha"},
    {"code":"ZRN","desc":"Zaife"},
    {"code":"ZWD","desc":"Zimbabwe Dollar"},
    {"code":"ZWL","desc":"Zimbabwe Dollar"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// TANGGAL
            _buildDateField(),

            const SizedBox(height: 25),

            /// VALUTA
            _buildValutaField(),

            const SizedBox(height: 40),

            /// BUTTON
            _buildSearchButton(),

          ],
        ),
      ),
    );
  }

  /// ===============================
  /// APP BAR
  /// ===============================

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.whiteColor,
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColors.customColorRed,
        ),
        onPressed: widget.onBackToHome,
      ),
      title: Text(
        'Kurs',
        style: GoogleFonts.lato(
          color: AppColors.customColorRed,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          margin: const EdgeInsets.symmetric(horizontal: 25),
          color: AppColors.customColorRed.withOpacity(0.3),
        ),
      ),
    );
  }

  /// ===============================
  /// DATE FIELD
  /// ===============================

  Widget _buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

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
                _dateController.text =
                "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
              });
            }
          },
          child: Container(
            height: 55,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: AppBox.primary(),
            child: Row(
              children: [

                const Icon(
                  Icons.calendar_month_outlined,
                  color: AppColors.customColorRed,
                ),

                const SizedBox(width: 15),

                Text(
                  _dateController.text.isEmpty
                      ? 'Input Tanggal'
                      : _dateController.text,
                  style: GoogleFonts.roboto(
                    color: _dateController.text.isEmpty
                        ? AppColors.customColorGray.withOpacity(0.5)
                        : AppColors.customColorGray,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// ===============================
  /// VALUTA FIELD
  /// ===============================

  Widget _buildValutaField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          'Valuta',
          style: GoogleFonts.lato(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppColors.customColorRed,
          ),
        ),

        const SizedBox(height: 10),

        GestureDetector(
          onTap: _openValutaPicker,
          child: Container(
            height: 55,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: AppBox.primary(),
            child: Row(
              children: [

                const Icon(
                  Icons.attach_money_rounded,
                  color: AppColors.customColorRed,
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: Text(
                    _selectedValuta ?? "Choose Valuta",
                    style: GoogleFonts.roboto(
                      color: _selectedValuta == null
                          ? AppColors.customColorGray.withOpacity(0.5)
                          : AppColors.customColorGray,
                    ),
                  ),
                ),

                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColors.customColorRed,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// ===============================
  /// SEARCH BUTTON
  /// ===============================

  Widget _buildSearchButton() {
    return Center(
      child: SizedBox(
        width: 180,
        height: 45,
        child: ElevatedButton(
          onPressed: _onSearchPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.customColorRed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
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
    );
  }

  /// ===============================
  /// SEARCH VALIDATION
  /// ===============================

  void _onSearchPressed() {

    if (_dateController.text.isEmpty) {
      _showSnackBar('Silakan pilih tanggal terlebih dahulu');
      return;
    }

    if (_selectedValuta == null) {
      _showSnackBar('Silakan pilih valuta terlebih dahulu');
      return;
    }

    _showMaintenanceDialog();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.roboto(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showMaintenanceDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
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
          'Fitur Kurs saat ini sedang dalam maintenance.\n\nSilakan coba kembali nanti.',
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
  }

  /// ===============================
  /// VALUTA PICKER
  /// ===============================

  void _openValutaPicker() {

    _searchController.clear();
    filteredValuta = valutaList;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {

        return StatefulBuilder(
          builder: (context, setModalState) {

            return Container(
              height: MediaQuery.of(context).size.height * 0.75,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [

                  Text(
                    "Pilih Valuta",
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColors.customColorRed,
                    ),
                  ),

                  const SizedBox(height: 15),

                  /// SEARCH

                  TextField(
                    controller: _searchController,
                    cursorColor: AppColors.customColorRed,
                    decoration: InputDecoration(
                      hintText: "Search currency...",
                      hintStyle: GoogleFonts.roboto(
                        color: AppColors.customColorGray.withOpacity(0.5),
                      ),

                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.customColorRed,
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: AppColors.customColorGray.withOpacity(0.3),
                        ),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: AppColors.customColorRed,
                          width: 2,
                        ),
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {

                      setModalState(() {

                        filteredValuta = valutaList.where((valuta) {

                          return valuta["code"]!
                              .toLowerCase()
                              .contains(value.toLowerCase()) ||
                              valuta["desc"]!
                                  .toLowerCase()
                                  .contains(value.toLowerCase());

                        }).toList();
                      });
                    },
                  ),

                  const SizedBox(height: 15),

                  /// LIST

                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredValuta.length,
                      itemBuilder: (context, index) {

                        final valuta = filteredValuta[index];

                        return ListTile(
                          leading: const Icon(
                            Icons.attach_money,
                            color: AppColors.customColorRed,
                          ),
                          title: Text(
                            valuta["code"]!,
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(valuta["desc"]!),
                          onTap: () {

                            setState(() {
                              _selectedValuta = valuta["code"];
                            });

                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
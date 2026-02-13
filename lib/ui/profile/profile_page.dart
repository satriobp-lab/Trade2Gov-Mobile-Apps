import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_box_decoration.dart';
import '../../core/app_cache.dart';
import '../../data/models/profile_response_model.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileResponseModel? profile;

  String appVersion = '-';

  @override
  void initState() {
    super.initState();
    profile = AppCache.profile;
    _loadAppVersion();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (profile == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Profile',
          style: GoogleFonts.lato(
            color: AppColors.customColorRed,
            fontWeight: FontWeight.bold,
            fontSize: width * 0.055,
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
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Column(
          children: [
            const SizedBox(height: 5),
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 55),
                  decoration: AppBox.primary(),
                  padding: const EdgeInsets.only(
                    top: 65,
                    left: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  child: Column(
                    children: [
                      /// 🔥 BASIC INFO
                      Text(
                        profile?.nama ?? '-',
                        style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.customColorRed,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        profile?.email ?? '-',
                        style: GoogleFonts.lato(
                          fontSize: 14,
                          color: AppColors.customColorRed,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        profile?.phone ?? '-',
                        style: GoogleFonts.lato(
                          fontSize: 14,
                          color: AppColors.customColorRed,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Divider(
                          thickness: 1,
                          color:
                          AppColors.customColorRed.withOpacity(0.3),
                        ),
                      ),

                      /// 🔥 COMPANY DETAIL
                      _buildProfileInfoRow(
                          'Nama Perusahaan',
                        _toTitleCase(profile?.namaPerusahaan),
                      ),
                      _buildProfileInfoRow(
                          'Npwp',
                          profile?.npwp ?? '-'),
                      _buildProfileInfoRow(
                          'Alamat',
                        _toTitleCase(profile?.alamat),
                      ),
                      _buildProfileInfoRow(
                          'Kode Pos',
                          profile?.kodePos ?? '-'),
                      _buildProfileInfoRow(
                        'Bidang Usaha',
                        profile?.bidangUsaha ??
                            _toTitleCase(profile?.bidangUsaha),
                      ),
                      _buildProfileInfoRow(
                          'Komoditi',
                        _toTitleCase(profile?.bidangUsahaKomoditi),
                      ),
                      _buildProfileInfoRow(
                          'Subkomoditi',
                        _toTitleCase(profile?.bidangUsahaSubkomoditi),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Divider(
                          thickness: 1,
                          color:
                          AppColors.customColorRed.withOpacity(0.3),
                        ),
                      ),

                      /// 🔥 VERSION
                      Text(
                        'Version Mobile Apps',
                        style: GoogleFonts.lato(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.customColorRed,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 140,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.customColorRed
                                .withOpacity(0.3),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          appVersion,
                          style: GoogleFonts.roboto(
                            color: AppColors.customColorRed
                                .withOpacity(0.6),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// 🔥 PROFILE IMAGE
                Positioned(
                  top: 0,
                  child: Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                      border: Border.all(
                        color: Colors.white,
                        width: 4,
                      ),
                      image: const DecorationImage(
                        image:
                        AssetImage('assets/images/person-image.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 🔥 Helper Row
  Widget _buildProfileInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: AppColors.customColorGray,
              ),
            ),
          ),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: ': ',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: AppColors.customColorGray,
                    ),
                  ),
                  TextSpan(
                    text: value,
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.normal,
                      fontSize: 13,
                      color:
                      AppColors.customColorGray.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔥 Fallback Mapping
  String _mapBidangUsaha(int? id) {
    switch (id) {
      case 1:
        return "IMPORTIR";
      case 2:
        return "EKSPORTIR";
      case 3:
        return "EKSPOR IMPOR";
      default:
        return "-";
    }
  }

  String _toTitleCase(String? text) {
    if (text == null || text.isEmpty) return '-';

    return text
        .toLowerCase()
        .split(' ')
        .map((word) =>
    word.isNotEmpty
        ? word[0].toUpperCase() + word.substring(1)
        : '')
        .join(' ');
  }

  Future<void> _loadAppVersion() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = info.version;
    });
  }
}
class ProfileResponseModel {
  final int idUser;
  final String name;
  final String email;
  final String phone;
  final String namaPerusahaan;
  final String? npwp;
  final String? alamat;
  final String? kodePos;
  final int? bidangUsahaId;
  final String? bidangUsaha;
  final String? bidangUsahaKomoditi;
  final String? bidangUsahaSubkomoditi;
  final String mobileAppVersion;

  ProfileResponseModel({
    required this.idUser,
    required this.name,
    required this.email,
    required this.phone,
    required this.namaPerusahaan,
    required this.mobileAppVersion,
    this.npwp,
    this.alamat,
    this.kodePos,
    this.bidangUsahaId,
    this.bidangUsaha,
    this.bidangUsahaKomoditi,
    this.bidangUsahaSubkomoditi,
  });

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return ProfileResponseModel(
      idUser: json['id_user'],
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      namaPerusahaan: json['nama_perusahaan'] ?? '',
      npwp: json['npwp'],
      alamat: json['alamat'],
      kodePos: json['kode_pos'],
      bidangUsahaId: json['bidang_usaha_id'],
      bidangUsaha: json['bidang_usaha'],
      bidangUsahaKomoditi: json['bidang_usaha_komoditi'],
      bidangUsahaSubkomoditi: json['bidang_usaha_subkomoditi'],
      mobileAppVersion: json['MOBILE_APP_VERSION'] ?? '-',
    );
  }
}
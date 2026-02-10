class LoginResponseModel {
  final int idUser;
  final String idUserHash;
  final String npwp;
  final String email;
  final String nama;
  final int roleId;

  LoginResponseModel({
    required this.idUser,
    required this.idUserHash,
    required this.npwp,
    required this.email,
    required this.nama,
    required this.roleId,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return LoginResponseModel(
      idUser: data['id_user'],
      idUserHash: data['id_user_hash'],
      npwp: data['npwp'],
      email: data['email'],
      nama: data['nama'],
      roleId: data['role_id'],
    );
  }
}

class MailboxResponseModel {
  final int idUser;
  final String message;

  MailboxResponseModel({
    required this.idUser,
    required this.message,
  });

  factory MailboxResponseModel.fromJson(Map<String, dynamic> json) {
    return MailboxResponseModel(
      idUser: json['id_user'],
      message: json['msg'],
    );
  }
}
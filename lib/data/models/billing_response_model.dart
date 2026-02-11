class BillingResponseModel {
  final int billingId;
  final String periodeTagihan;
  final int billingTotal;

  BillingResponseModel({
    required this.billingId,
    required this.periodeTagihan,
    required this.billingTotal,
  });

  factory BillingResponseModel.fromJson(Map<String, dynamic> json) {
    return BillingResponseModel(
      billingId: json['billing_id'],
      periodeTagihan: json['periode_tagihan'],
      billingTotal: json['billing_total'],
    );
  }
}

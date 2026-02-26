class PebContainerResponseModel {
  final String? noCont;
  final String? size;
  final String? stuff;
  final String? type;
  final String? jnPartOf;
  final String? car;

  PebContainerResponseModel({
    this.noCont,
    this.size,
    this.stuff,
    this.type,
    this.jnPartOf,
    this.car,
  });

  factory PebContainerResponseModel.fromJson(
      Map<String, dynamic> json) {
    return PebContainerResponseModel(
      noCont: json['NOCONT'],
      size: json['SIZE'],
      stuff: json['STUFF'],
      type: json['TYPE'],
      jnPartOf: json['JNPARTOF'],
      car: json['CAR'],
    );
  }
}
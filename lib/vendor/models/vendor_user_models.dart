class VendorUserModel {
  final bool? approved;
  final String? vendorId;
  final String? businessName;
  final String? cpfCnpj;
  final String? email;
  final String? phone;
  final String? cep;
  final String? address;
  final String? ville;
  final String? countryValue;
  final String? stateValue;
  final String? cityValue;
  final String? storeImage;

  VendorUserModel(
      {required this.approved,
      required this.vendorId,
      required this.businessName,
      required this.cpfCnpj,
      required this.email,
      required this.phone,
      required this.countryValue,
      required this.stateValue,
      required this.cityValue,
      required this.cep,
      required this.address,
      required this.ville,
      required this.storeImage});

  VendorUserModel.fromJson(Map<String, Object?> json)
      : this(
          approved: json['approved']! as bool,
          vendorId: json['vendorId']! as String,
          businessName: json['businessName']! as String,
          cpfCnpj: json['cpfCnpj']! as String,
          email: json['email']! as String,
          phone: json['phone']! as String,
          countryValue: json['countryValue']! as String,
          stateValue: json['stateValue']! as String,
          cityValue: json['cityValue']! as String,
          cep: json['cep']! as String,
          address: json['address']! as String,
          ville: json['ville']! as String,
          storeImage: json['storeImage']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      'approved': approved,
      'vendorId': vendorId,
      'businessName': businessName,
      'cpfCnpj': cpfCnpj,
      'email': email,
      'phone': phone,
      'countryValue': countryValue,
      'stateValue': stateValue,
      'cityValue': cityValue,
      'cep': cep,
      'address': address,
      'ville': ville,
      'storeImage': storeImage,
    };
  }
}

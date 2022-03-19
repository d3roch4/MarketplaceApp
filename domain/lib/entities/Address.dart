class Address {
  String zipCode;
  String street;
  String district;
  String city;
  String state;
  String coutry;
  double latitude;
  double longitude;

  Address({
    required this.zipCode,
    required this.street,
    required this.city,
    required this.coutry,
    required this.district,
    required this.state,
    required this.latitude,
    required this.longitude,
  });

  static Address empty = Address(
      zipCode: '',
      street: '',
      city: '',
      coutry: '',
      district: '',
      state: '',
      latitude: 0,
      longitude: 0);
}

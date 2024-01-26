class AddressModel {
  const AddressModel({
    required this.id,
    required this.country,
    required this.address,
    required this.city,
    required this.state,
    required this.zip,
    required this.dateCreated,
    required this.dateUpdated,
  });

  final int id;
  final String country;
  final String address;
  final String city;
  final String state;
  final String zip;
  final String dateCreated;
  final String dateUpdated;
}

List<AddressModel> transformResponse(List<Map<String, dynamic>> response) {
  return response.map((map) {
    return AddressModel(
      id: map['id'] ?? 0,
      country: map['country'] ?? '',
      address: map['address'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      zip: map['zip'] ?? '',
      dateCreated: map['dateCreated'] ?? '',
      dateUpdated: map['dateUpdated'] ?? '',
    );
  }).toList();
}
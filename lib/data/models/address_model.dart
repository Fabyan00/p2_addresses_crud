class AddressModel {
  const AddressModel({
    required this.id,
    required this.alias,
    required this.country,
    required this.state,
    required this.city,
    required this.address,
    required this.zip,
    required this.dateCreated,
    required this.dateUpdated,
  });

  final int id;
  final String alias;
  final String country;
  final String address;
  final String state;
  final String city;
  final String zip;
  final String dateCreated;
  final String dateUpdated;
}

List<AddressModel> transformResponse(List<Map<String, dynamic>> response) {
  return response.map((map) {
    return AddressModel(
      id: map['id'] ?? 0,
      alias: map['alias'] ?? '',
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
class UserDetailsModel {
  final String name;
  final String address;
  UserDetailsModel({required this.address, required this.name});
  Map<String, dynamic> getJson() => {
        "name": name,
        "address": address,
      };
}

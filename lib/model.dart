class ProfileDetails {
  String? firstName;
  String? middleName;
  String? lastName;
  int? phoneNumber;
  int? houseNumber;
  String? streetName;
  String? city;
  String? county;
  String? entryDate;
  String? updateDate;
  ProfileDetails(
      {this.firstName,
      this.middleName,
      this.lastName,
      this.phoneNumber,
      this.houseNumber,
      this.streetName,
      this.city,
      this.county,
      this.entryDate,
      this.updateDate});

  ProfileDetails.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    middleName = json['middleName'];
    lastName = json['lastName'];
    phoneNumber = json['phoneNumber'];
    houseNumber = json['houseNumber'];
    streetName = json['streetName'];
    city = json['city'];
    county = json['county'];
    entryDate = json['entryDate'];
    updateDate = json['updateDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['middleName'] = middleName;
    data['lastName'] = lastName;
    data['phoneNumber'] = phoneNumber;
    data['houseNumber'] = houseNumber;
    data['streetName'] = streetName;
    data['city'] = city;
    data['county'] = county;
    data['entryDate'] = entryDate;
    data['updateDate'] = updateDate;
    return data;
  }
}

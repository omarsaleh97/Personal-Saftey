class EmergencyContacts {
  String name;
  String phoneNumber;

  EmergencyContacts({this.name, this.phoneNumber});

  // convert Json to an exercise object
  factory EmergencyContacts.fromJson(Map<String, dynamic> json) {
    return EmergencyContacts(
      name: json['name'],
      phoneNumber: json['phoneNumber'],
    );
  }
  Map<String, dynamic> toJson()
  {
    return
        {
          "name": name,
          "phoneNumber": phoneNumber
        };
  }
}

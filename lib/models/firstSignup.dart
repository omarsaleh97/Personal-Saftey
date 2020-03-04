class FirstSignupCredentials {
  String currentAddress;
  int bloodType;
  String medicalHistoryNotes;
  List<Contacts> emergencyContacts = [];

  FirstSignupCredentials(
    this.currentAddress,
    this.bloodType,
    this.medicalHistoryNotes,
    this.emergencyContacts,
  );

  factory FirstSignupCredentials.fromJson(Map<String, dynamic> json) {
    return FirstSignupCredentials(
      json["currentAddress"],
      json["bloodType"],
      json["password"],
      (json['emergencyContacts'] as List).map((i) {
        return Contacts.fromJson(i);
      }).toList(),
    );
  }
}

class Contacts {
  String name;
  String phoneNumber;

  Contacts(this.name, this.phoneNumber);

  // convert Json to an exercise object
  factory Contacts.fromJson(Map<String, dynamic> json) {
    return Contacts(
      json['name'] as String,
      json['phoneNumber'] as String,
    );
  }
}

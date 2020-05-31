import 'emergency_contact.dart';
import 'dart:convert';

class FirstLoginCredentials {
  String fullName;
  String phoneNumber;
  String currentAddress;
  int bloodType;
  String medicalHistoryNotes;
  String birthday;
  List<EmergencyContacts> emergencyContacts = [];

  FirstLoginCredentials({
    this.fullName,
    this.phoneNumber,
    this.currentAddress,
    this.bloodType,
    this.medicalHistoryNotes,
    this.birthday,
    this.emergencyContacts,
  });

  factory FirstLoginCredentials.fromJson(Map<String, dynamic> json) {
    var list = json['emergencyContacts'] as List;
    print(list.runtimeType);
    List<EmergencyContacts> contactList =
        list.map((i) => EmergencyContacts.fromJson(i)).toList();
    return FirstLoginCredentials(
        currentAddress: json["currentAddress"],
        bloodType: json["bloodType"],
        medicalHistoryNotes: json["medicalHistoryNotes"],
        emergencyContacts: contactList);
  }

  Map<String, dynamic> toJson() {
    return {
      "fullName": fullName,
      "phoneNumber": phoneNumber,
      "currentAddress": currentAddress,
      "bloodType": bloodType,
      "birthday": birthday,
      "medicalHistoryNotes": medicalHistoryNotes,
      "emergencyContacts": emergencyContacts
    };
  }
}

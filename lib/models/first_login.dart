import 'emergency_contact.dart';
import 'dart:convert';

class FirstLoginCredentials {
  String currentAddress;
  int bloodType;
  String medicalHistoryNotes;
  List<EmergencyContacts> emergencyContacts = [];

  FirstLoginCredentials({
    this.currentAddress,
    this.bloodType,
    this.medicalHistoryNotes,
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
      "currentAddress": currentAddress,
      "bloodType": bloodType,
      "medicalHistoryNotes": medicalHistoryNotes,
      "emergencyContacts": emergencyContacts
    };
  }
}

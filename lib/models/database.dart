class User {
  int ID;
  String NationalID;
  String FullName;
  String PhoneNumber;
  int Age;
  String Email;
  String EmergencyContact;
  String BloodType;
  String MedicalHistory;
  String CurrentAddress;

  User(
      {this.ID,
      this.NationalID,
      this.FullName,
      this.PhoneNumber,
      this.Age,
      this.EmergencyContact,
      this.BloodType,
      this.Email,
      this.CurrentAddress,
      this.MedicalHistory});
}

class Event {
  int ID;
  int UserID;
  String lon;
  String lat;
  String EventTitle;
  String EventDescription;
  int Status;
  bool Confirmation;
  bool IsPublicHelp;

  Event(
      {this.ID,
      this.Confirmation,
      this.EventDescription,
      this.EventTitle,
      this.IsPublicHelp,
      this.lat,
      this.lon,
      this.Status,
      this.UserID});
}

class EmergencyContacts {
  int UserID;
  String ContactName;
  String ContactPhone;

  EmergencyContacts({this.ContactName, this.ContactPhone, this.UserID});
}

class EventStates {
  int ID;
  String StateName;

  EventStates({this.ID, this.StateName});
}

class SOS_Request {
  int ID;
  int UserID;
  int Status;
  int AuthorityID;
  String lon;
  String lat;
  SOS_Request(
      {this.ID,
      this.Status,
      this.lon,
      this.lat,
      this.AuthorityID,
      this.UserID});
}

class AuthorityType {
  int ID;
  String Name;
  String Location;

  AuthorityType({this.ID, this.Location, this.Name});
}

class SOS_StatusType {
  int ID;
  String StatusName;
  SOS_StatusType({this.ID, this.StatusName});
}

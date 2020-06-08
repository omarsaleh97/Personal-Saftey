class SOSRequestModel {
  int requestId;
  int requestStateId;
  String requestStateName;
  String authorityTypeName;
  double requestLocationLongitude;
  double requestLocationLatitude;
  String requestCreationDate;

  SOSRequestModel({
    this.requestId,
    this.requestStateId,
    this.requestStateName,
    this.authorityTypeName,
    this.requestLocationLongitude,
    this.requestLocationLatitude,
    this.requestCreationDate,
  });
  factory SOSRequestModel.fromJson(Map<String, dynamic> item) {
    return SOSRequestModel(
      requestId: item['requestId'],
      requestStateId: item['requestStateId'],
      requestStateName: item['requestStateName'],
      authorityTypeName: item['authorityTypeName'],
      requestLocationLongitude: item['requestLocationLongitude'].toDouble(),
      requestLocationLatitude: item['requestLocationLatitude'].toDouble(),
      requestCreationDate: item['requestCreationDate'],
    );
  }
}

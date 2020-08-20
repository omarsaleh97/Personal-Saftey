import 'dart:convert';

class EventGetterModel {
  int id;
  String title;
  String userName;
  String description;
  int eventCategoryId;
  String eventCategoryName;
  double longitude;
  double latitude;
  bool isValidated;
  bool isPublicHelp;
  int votes;
  String thumbnailUrl;
  String creationDate;
  String lastModified;

  EventGetterModel(
      {this.id,
      this.title,
      this.userName,
      this.description,
      this.eventCategoryId,
      this.eventCategoryName,
      this.longitude,
      this.latitude,
      this.isValidated,
      this.isPublicHelp,
      this.votes,
      this.thumbnailUrl,
      this.creationDate,
      this.lastModified});

  factory EventGetterModel.fromJson(Map<String, dynamic> item) {
    return EventGetterModel(
      id: item['id'],
      title: item['title'],
      userName: item['userName'],
      description: item['description'],
      eventCategoryId: item['eventCategoryId'],
      eventCategoryName: item['eventCategoryName'],
      longitude: item['longitude'].toDouble(),
      latitude: item['latitude'].toDouble(),
      isValidated: item['isValidated'],
      isPublicHelp: item['isPublicHelp'],
      votes: item['votes'],
      thumbnailUrl: item['thumbnailUrl'],
      creationDate: item['creationDate'],
      lastModified: item['lastModified'],
    );
  }
}

class EventPostModel {
  String title;
  String description;
  int eventCategoryId;
  double longitude;
  double latitude;
  bool isPublicHelp;
  String thumbnail;

  EventPostModel(
      {this.title,
      this.description,
      this.eventCategoryId,
      this.longitude,
      this.latitude,
      this.isPublicHelp,
      this.thumbnail});
  factory EventPostModel.fromJson(Map<String, dynamic> item) {
    return EventPostModel(
      title: item['title'],
      description: item['description'],
      eventCategoryId: item['eventCategoryId'],
      longitude: item['longitude'].toDouble(),
      latitude: item['latitude'].toDouble(),
      isPublicHelp: item['isPublicHelp'],
      thumbnail: item['thumbnailUrl'],
    );
  }
}

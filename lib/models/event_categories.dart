class EventCategories {
  int id;
  String title;
  String thumbnailUrl;

  EventCategories({this.id, this.title, this.thumbnailUrl});

  factory EventCategories.fromJson(Map<String, dynamic> item) {
    return EventCategories(
      id: item['id'],
      title: item['title'],
      thumbnailUrl: item['thumbnailUrl'],
    );
  }
}

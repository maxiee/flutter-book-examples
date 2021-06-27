class Note {
  String uuid;
  String title;
  String category;
  String content;

  Note(this.uuid, this.title, this.category, this.content);

  Note.fromJson(Map<String, dynamic> json)
    : uuid = json['uuid'],
      title = json['title'],
      category = json['category'],
      content = json['content'];

  Map<String, dynamic> toJson() => <String, dynamic> {
    'uuid': uuid,
    'title': title,
    'category': category,
    'content': content
  };
}
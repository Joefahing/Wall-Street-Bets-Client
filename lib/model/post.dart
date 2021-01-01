class Post {
  String title;
  String flair;
  String id;
  DateTime dateCreated;
  DateTime dateWithoutTime;

  Post({String title, String flair, String id, String date}) {
    this.title = title;
    this.flair = flair;
    this.id = id;
    this.dateCreated = DateTime.parse(date);
    this.dateWithoutTime =
        DateTime(this.dateCreated.year, this.dateCreated.month, this.dateCreated.day);
  }

  factory Post.fromJson({Map<String, dynamic> json}) {
    return Post(
        title: json['title'] as String,
        flair: json['flair'] as String,
        id: json['id'] as String,
        date: json['date_created'] as String);
  }

  bool sameFlair(String flair) {
    return this.flair == flair;
  }
}

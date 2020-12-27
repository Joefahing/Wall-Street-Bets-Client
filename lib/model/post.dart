class Post {
  String title;
  String flair;
  String id;
  DateTime date_created;
  DateTime date_without_time;

  Post({String title, String flair, String id, String date}) {
    this.title = title;
    this.flair = flair;
    this.id = id;
    this.date_created = DateTime.parse(date);
    this.date_without_time = DateTime(
        this.date_created.year, this.date_created.month, this.date_created.day);
  }

  factory Post.fromJson({Map<String, dynamic> json}) {
    return Post(
        title: json['title'] as String,
        flair: json['flair'] as String,
        id: json['id'] as String,
        date: json['date_created'] as String);
  }

  bool isGain() {
    return this.flair == 'Gain';
  }

  bool isLoss() {
    return this.flair == 'Loss';
  }

}

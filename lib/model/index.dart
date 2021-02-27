class Index {
  int points;
  DateTime dateCreated;

  Index({int points, String date}) {
    this.points = points;
    this.dateCreated = DateTime.parse(date);
  }

  factory Index.fromJson({Map<String, dynamic> json}) {
    return Index(date: json['date_created'] as String, points: json['points'] as int);
  }

  static Future<List<Index>> convertJsonToList({Future<Map<String, dynamic>> response}) async {
    final List<Index> indexes = [];
    final rawData = await response.then((json) => json['data_used']);

    for (final index in rawData) {
      final newIndex = Index.fromJson(json: index);
      indexes.add(newIndex);
    }

    return indexes;
  }

  @override
  String toString() {
    print("${this.dateCreated} and ${this.points}");
    return super.toString();
  }
}

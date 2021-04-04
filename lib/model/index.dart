import 'dart:convert';

class Index {
  int points;
  DateTime dateCreated;

  Index({int points, String date}) {
    this.points = points;
    this.dateCreated = DateTime.parse(date);
  }

  factory Index.fromJson({Map<String, dynamic> json}) {
    return Index(
      date: json['date_created'] as String,
      points: json['points'] as int,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Index && other.points == this.points && other.dateCreated == this.dateCreated);
  }

  @override
  int get hashCode => points.hashCode ^ dateCreated.hashCode;

  @override
  String toString() {
    print("${this.dateCreated} and ${this.points}");
    return super.toString();
  }
}

/// Since the structure of index json return from api is. Pre processing is need to retrieve data array
/// {
/// "data_used": [],
/// "dates":{
///   start_date: d,
///   end_date: e
/// }
/// }
List<Index> indexesFromJson({String rawJson}) {
  final Map<String, dynamic> decoded = jsonDecode(rawJson);
  final data = decoded['data_used'];
  return List<Index>.from(data.map((rawIndex) => Index.fromJson(json: rawIndex)));
}

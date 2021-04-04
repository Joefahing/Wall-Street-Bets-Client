import 'dart:async';
import 'package:http/http.dart' as http;

import '../model/index.dart';

///This class is strictly used fetching all API data from the server
class RemoteService {
  static final String indexUrl = "http://wall-street-bet-server.herokuapp.com/post/index/";

  static Future<List<Index>> getIndex(String interval) async {
    final url = Uri.parse("$indexUrl$interval");
    final apiResponse = await http.get(url);
    if (apiResponse.statusCode != 200) throw Exception('Failed to fetch posts from API end point');
    return indexesFromJson(rawJson: apiResponse.body);
  }
}

import 'dart:convert';
import 'dart:async';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;

import 'package:wsb_dashboard/model/post.dart';
import 'package:wsb_dashboard/model/summary.dart';

/// This class is responsible for handling all the methods use in process data received from API
/// anything from http fetching to processing json into structure suitable for widget consumption

class APIController {
  static Future<Map<String, dynamic>> fetchPosts(String timeLength) async {
    final apiResponse = await http.get(
        "https://wall-street-bet-server.herokuapp.com/stats/gain_loss/post?interval=$timeLength");

    if (apiResponse.statusCode != 200) throw Exception('Failed to fetch posts from API end point');

    final Map<String, dynamic> unprocessJson = jsonDecode(apiResponse.body);
    return unprocessJson;
  }

  ///fromJson factory method from Post class is used there to deserilize json post
  static List<Post> postsFromJson(List<dynamic> rawPosts) {
    final List<Post> posts = [];

    for (var post in rawPosts) {
      final newPost = Post.fromJson(json: post);
      posts.add(newPost);
    }
    return posts;
  }

  ///Gain and Loss posts are needed to be aggregate by date and be used in graph
  ///the data structure will be point system <Date, Sum>
  List<TimeSeriesPosts> getTimeTotalByFlair({List<Post> posts, String searchFlair}) {
    final Map<String, int> timeTotalMap = _populateTimeSeriesMap(posts, searchFlair);
    final List<TimeSeriesPosts> timeTotalList = _convertTimeSeriesMapToList(timeTotalMap);

    timeTotalList.sort((TimeSeriesPosts a, TimeSeriesPosts b) => a.time.compareTo(b.time));
    return timeTotalList;
  }

  List<TimeSeriesPosts> _convertTimeSeriesMapToList(Map<String, int> map) {
    final List<TimeSeriesPosts> convertedSeries = [];

    map.forEach((date, count) => convertedSeries.add(TimeSeriesPosts(DateTime.parse(date), count)));

    return convertedSeries;
  }

  Map<String, int> _populateTimeSeriesMap(List<Post> posts, flair) {
    final Map<String, int> map = {};

    for (var post in posts) {
      if (post.sameFlair(flair)) {
        final dateString = post.dateWithoutTime.toString();
        final numberOfPost = map[dateString] ?? 0;
        map[dateString] = numberOfPost + 1;
      }
    }

    return map;
  }
}

class TimeSeriesPosts {
  final DateTime time;
  final int totalPosts;

  TimeSeriesPosts(this.time, this.totalPosts);

  static List<charts.Series<dynamic, DateTime>> convertListToSeries({List<TimeSeriesPosts> data}) {
    return [
      new charts.Series<TimeSeriesPosts, DateTime>(
        id: 'Post',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesPosts posts, _) => posts.time,
        measureFn: (TimeSeriesPosts posts, _) => posts.totalPosts,
        data: data,
      )
    ];
  }
}

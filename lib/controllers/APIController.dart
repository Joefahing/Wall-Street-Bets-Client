import 'dart:convert';
import 'dart:async';

import 'package:charts_flutter/flutter.dart' as Charts;
import 'package:http/http.dart' as HTTP;

import 'package:wsb_dashboard/model/post.dart';
import 'package:wsb_dashboard/model/summary.dart';

/// This class is responsible for handling all the methods use in process data received from API
/// anything from HTTP fetching to processing json into structure suitable for widget consumption

class APIController {
  Future<Map<String, dynamic>> fetchPosts(String timeLength) async {
    final apiResponse = await HTTP.get(
        "https://wall-street-bet-server.herokuapp.com/stats/gain_loss/post?interval=$timeLength");

    if (apiResponse.statusCode != 200) throw Exception('Failed to fetch posts from API end point');

    final Map<String, dynamic> unprocessJson = jsonDecode(apiResponse.body);
    return unprocessJson;
  }

  Future<PostSummary> getSummary({Future<Map<String, dynamic>> response}) async {
    PostSummary summary =
        await response.then((json) => PostSummary.fromJson(json: json['summary']));
    return summary;
  }

  ///fromJson factory method from Post class is used there to deserilize json post
  Future<List<Post>> getPosts({Future<Map<String, dynamic>> response}) async {
    final List<Post> posts = [];
    final rawPosts = await response.then((json) => json['data_used']);

    for (var post in rawPosts) {
      final newPost = Post.fromJson(json: post);
      posts.add(newPost);
    }
    return posts;
  }

  Future<List<Charts.Series>> getGainLossDataPoint({Future<Map<String, dynamic>> response}) async {
    final posts = await getPosts(response: response);
    final gainData = _getTimeTotalByFlair(posts: posts, searchFlair: 'Gain');
    final lossData = _getTimeTotalByFlair(posts: posts, searchFlair: 'Loss');
    final gainChartData = convertDataToChartSeries(posts: gainData, color: ChartColor.green);
    final lossChartData = convertDataToChartSeries(posts: lossData, color: ChartColor.red);
    final chartDataSet = [gainChartData, lossChartData];

    return chartDataSet;
  }

  Charts.Series<dynamic, DateTime> convertDataToChartSeries(
      {List<TimeSeriesPosts> posts, dynamic color}) {
    return new Charts.Series<TimeSeriesPosts, DateTime>(
      id: 'Post',
      colorFn: (_, __) => color,
      domainFn: (TimeSeriesPosts posts, _) => posts.time,
      measureFn: (TimeSeriesPosts posts, _) => posts.totalPosts,
      data: posts,
    );
  }

  ///Gain and Loss posts are needed to be aggregate by date and be used in graph
  ///the data structure will be point system <Date, Sum>
  List<TimeSeriesPosts> _getTimeTotalByFlair({List<Post> posts, String searchFlair}) {
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

class ChartColor {
  static final blue = Charts.MaterialPalette.blue.shadeDefault;
  static final red = Charts.MaterialPalette.red.shadeDefault;
  static final green = Charts.MaterialPalette.green.shadeDefault;
  static final yellow = Charts.MaterialPalette.yellow.shadeDefault;
}

class TimeSeriesPosts {
  final DateTime time;
  final int totalPosts;

  TimeSeriesPosts(this.time, this.totalPosts);

  static List<Charts.Series<dynamic, DateTime>> convertListToSeries({List<TimeSeriesPosts> data}) {
    return [
      new Charts.Series<TimeSeriesPosts, DateTime>(
        id: 'Post',
        colorFn: (_, __) => Charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesPosts posts, _) => posts.time,
        measureFn: (TimeSeriesPosts posts, _) => posts.totalPosts,
        data: data,
      )
    ];
  }
}

import 'dart:convert';
import 'dart:async';

import 'package:charts_flutter/flutter.dart' as Charts;
import 'package:http/http.dart' as HTTP;

import '../model/post.dart';
import '../model/summary.dart';
import '../model/index.dart';

/// This class is responsible for handling all the methods use in process data received from API
/// anything from HTTP fetching to processing json into structure suitable for widget consumption

class APIController {
  Charts.Series<dynamic, DateTime> convertDataToChartSeries(
      {List<TimeSeriesPosts> data, dynamic color}) {
    return new Charts.Series<TimeSeriesPosts, DateTime>(
      id: 'Index ',
      colorFn: (_, __) => color,
      domainFn: (TimeSeriesPosts data, _) => data.time,
      measureFn: (TimeSeriesPosts data, _) => data.totalPosts,
      data: data,
    );
  }

  Future<Map<String, dynamic>> fetchFromEndPoint({String route, String time}) async {
    final apiResponse = await HTTP.get("$route$time");

    if (apiResponse.statusCode != 200) throw Exception('Failed to fetch posts from API end point');

    final Map<String, dynamic> unprocessJson = jsonDecode(apiResponse.body);
    return unprocessJson;
  }

  ///this function is responsible for converting points json post into useable format for chat
  Future<List<Charts.Series>> getGainLossDataPoint({Future<Map<String, dynamic>> response}) async {
    final posts = await getPosts(response: response);
    final gainData = _getTimeTotalByFlair(posts: posts, searchFlair: 'Gain');
    final lossData = _getTimeTotalByFlair(posts: posts, searchFlair: 'Loss');
    final gainChartData = convertDataToChartSeries(data: gainData, color: ChartColor.green);
    final lossChartData = convertDataToChartSeries(data: lossData, color: ChartColor.red);
    final chartDataSet = [gainChartData, lossChartData];

    return chartDataSet;
  }

  Future<List<Index>> getIndex({Future<Map<String, dynamic>> response}) async {
    final List<Index> indexes = await Index.convertJsonToList(response: response);
    return indexes;
  }

  Future<List<Charts.Series<dynamic, DateTime>>> getIndexGraphData(
      {Future<Map<String, dynamic>> response}) async {
    final color = ChartColor.red;
    final indexes = await Index.convertJsonToList(response: response);
    final timeSeriesIndexes = _convertIndexToTimeSeries(indexes: indexes);
    final indexChartData = convertDataToChartSeries(data: timeSeriesIndexes, color: color);
    return [indexChartData];
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

  Future<PostSummary> getSummary({Future<Map<String, dynamic>> response}) async {
    PostSummary summary =
        await response.then((json) => PostSummary.fromJson(json: json['summary']));
    return summary;
  }

  List<TimeSeriesPosts> _convertTimeSeriesMapToList(Map<String, int> map) {
    final List<TimeSeriesPosts> convertedSeries = [];

    map.forEach((date, count) =>
        convertedSeries.add(TimeSeriesPosts(time: DateTime.parse(date), totalPosts: count)));

    return convertedSeries;
  }

  ///Flutter chart requires a format that provides the library with points and time. Models that are plotted in charts are converted to TimeSeries for
  ///the library to be more universally accessible
  List<TimeSeriesPosts> _convertIndexToTimeSeries({List<Index> indexes}) {
    final List<TimeSeriesPosts> convertedSeries = [];

    indexes.forEach((index) {
      final newSeries = TimeSeriesPosts(time: index.dateCreated, totalPosts: index.points);
      convertedSeries.add(newSeries);
    });

    return convertedSeries;
  }

  ///Gain and Loss posts are needed to be aggregate by date and be used in graph
  ///the data structure will be point system <Date, Sum>
  List<TimeSeriesPosts> _getTimeTotalByFlair({List<Post> posts, String searchFlair}) {
    final Map<String, int> timeTotalMap = _populateTimeSeriesMap(posts, searchFlair);
    final List<TimeSeriesPosts> timeTotalList = _convertTimeSeriesMapToList(timeTotalMap);

    timeTotalList.sort((TimeSeriesPosts a, TimeSeriesPosts b) => a.time.compareTo(b.time));
    return timeTotalList;
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

  TimeSeriesPosts({this.time, this.totalPosts});
}

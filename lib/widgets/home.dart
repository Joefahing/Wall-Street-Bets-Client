import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;

import 'package:wsb_dashboard/model/post.dart';
import 'package:wsb_dashboard/model/summary.dart';

Future<Map<String, dynamic>> fetchPosts() async {
  final response = await http.get(
      'https://wall-street-bet-server.herokuapp.com/stats/gain_loss/post?interval=week');

  if (response.statusCode == 200) {
    final Map<String, dynamic> json = jsonDecode(response.body);
    return json;
  } else {
    throw Exception('Failed to fetch from Gain and Loss end point');
  }
}

//Post objective are created there from raw json object
List<Post> postsFromJson({List<dynamic> rawPosts}) {
  final List<Post> posts = [];

  for (var post in rawPosts) {
    final newPost = Post.fromJson(json: post);
    posts.add(newPost);
  }
  return posts;
}

//Gain and Loss posts are needed to be aggregate by date and be used in graph
//the data structure will be point system <Date, Sum>
List<TimeSeriesPosts> getTimeTotalByFlair(
    {List<Post> posts, String searchFlair}) {
  final List<TimeSeriesPosts> data = [];
  final Map<String, int> timeSeriesMap = {};

  for (var post in posts) {
    if (post.flair == searchFlair) {
      final dateString = post.date_without_time.toString();
      final numberOfPost = timeSeriesMap[dateString] ?? 0;
      timeSeriesMap[dateString] = numberOfPost + 1;
    }
  }

  timeSeriesMap.forEach((date, count) {
    final point = TimeSeriesPosts(DateTime.parse(date), count);
    data.add(point);
  });

  data.sort((TimeSeriesPosts a, TimeSeriesPosts b) => a.time.compareTo(b.time));
  return data;
}

///Data Structured used to hold time and post
class TimeSeriesPosts {
  final DateTime time;
  final int totalPosts;

  TimeSeriesPosts(this.time, this.totalPosts);

  static List<charts.Series<dynamic, DateTime>> convertListToSeries(
      {List<TimeSeriesPosts> data}) {
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

class WallStreetBetHomePage extends StatefulWidget {
  WallStreetBetHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WallStreetBetHomePageState createState() => _WallStreetBetHomePageState();
}

class _WallStreetBetHomePageState extends State<WallStreetBetHomePage> {
  Future<List<Post>> posts;
  Future<PostSummary> summary;
  Future<List<charts.Series>> gainPostDataPoint;

  @override
  void initState() {
    super.initState();

    final response = fetchPosts();
    posts = response.then((json) => postsFromJson(rawPosts: json['data_used']));

    summary =
        response.then((json) => PostSummary.fromJson(json: json['summary']));

    gainPostDataPoint = posts.then((postsFromFuture) {
      final data =
          getTimeTotalByFlair(posts: postsFromFuture, searchFlair: 'Gain');

      data.forEach((point) {
        print('date ${point.time},  total: ${point.totalPosts}');
      });
      return TimeSeriesPosts.convertListToSeries(data: data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wall Street Bets')),
      body: Container(
        child: Column(
          children: [
            FutureBuilder<PostSummary>(
                future: summary,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Row(
                      children: [
                        Expanded(
                          child: Card(
                            child: Center(
                              child: Text(snapshot.data.gain.toString()),
                            ),
                          ),
                        ),
                        Expanded(
                            child: Card(
                          child: Text(snapshot.data.loss.toString()),
                        ))
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return SizedBox(
                    height: 30,
                  );
                }),
            Expanded(
                child: FutureBuilder(
              future: gainPostDataPoint,
              builder: (BuildContext context, future) {
                if (future.hasData) {
                  return WallStreetBetTimeSeriesChart(series: future.data);
                } else if (future.hasError) {
                  return Text("${future.error}");
                }
                return SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}

class WallStreetBetTimeSeriesChart extends StatelessWidget {
  final List<charts.Series> series;

  WallStreetBetTimeSeriesChart({this.series});

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      series,
      animate: false,
      dateTimeFactory: const charts.UTCDateTimeFactory(),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:wsb_dashboard/model/post.dart';
import 'package:wsb_dashboard/model/summary.dart';

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

    summary = response.then((json) => PostSummary.fromJson(json: json['summary']));

    gainPostDataPoint = posts.then((postsFromFuture) {
      final data = getTimeTotalByFlair(posts: postsFromFuture, searchFlair: 'Gain');

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

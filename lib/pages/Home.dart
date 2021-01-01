import 'dart:async';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as Charts;

import 'package:wsb_dashboard/model/post.dart';
import 'package:wsb_dashboard/model/summary.dart';
import 'package:wsb_dashboard/controllers/APIController.dart';
import 'package:wsb_dashboard/widgets/LineChart.dart';

class WallStreetBetHomePage extends StatefulWidget {
  WallStreetBetHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WallStreetBetHomePageState createState() => _WallStreetBetHomePageState();
}

class _WallStreetBetHomePageState extends State<WallStreetBetHomePage> {
  Future<Map<String, dynamic>> apiResponse;
  Future<List<Post>> posts;
  Future<PostSummary> summary;
  Future<List<Charts.Series>> lineGraphDataSet;

  final apiController = APIController();

  @override
  void initState() {
    super.initState();

    final apiResponse = apiController.fetchPosts('week');
    summary = apiController.getSummary(response: apiResponse);
    posts = apiController.getPosts(response: apiResponse);
    lineGraphDataSet = apiController.getGainLossDataPoint(response: apiResponse);
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
              child: Container(
               // width: 500,
                //height: 500,
                child: FutureBuilder(
                  future: lineGraphDataSet,
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
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

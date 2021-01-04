import 'dart:async';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as Charts;

import '../components/adaptive.dart';
import '../controllers/APIController.dart';
import '../model/post.dart';
import '../model/summary.dart';

import '../widgets/line_chart.dart';
import '../widgets/metric_card.dart';

class WallStreetBetHomePage extends StatefulWidget {
  WallStreetBetHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WallStreetBetHomePageState createState() => _WallStreetBetHomePageState();
}

class _WallStreetBetHomePageState extends State<WallStreetBetHomePage> {
  Future<List<Post>> posts;
  Future<PostSummary> summary;
  Future<List<Charts.Series>> lineGraphDataSet;
  String interval = 'month';

  final apiController = APIController();

  ///This helper method refetches data from API base on current interval and set
  ///them to instance variables used to power the data and display
  void _prepareAPIData() {
    final apiResponse = apiController.fetchPosts(interval);
    summary = apiController.getSummary(response: apiResponse);
    posts = apiController.getPosts(response: apiResponse);
    lineGraphDataSet = apiController.getGainLossDataPoint(response: apiResponse);
  }

  void updateWeeklyInterval() {
    setState(() {
      interval = 'week';
      _prepareAPIData();
    });
  }

  void updateMonthlyInterval() {
    setState(() {
      interval = 'month';
      _prepareAPIData();
    });
  }

  void updateDailyInterval() {
    setState(() {
      interval = 'day';
      _prepareAPIData();
    });
  }

  @override
  void initState() {
    super.initState();

    _prepareAPIData();
  }

  @override
  Widget build(BuildContext context) {
    final adaptive = AdaptiveWindow.fromContext(context: context);
    final measurements = adaptive.getBreakpoint();

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(
            right: measurements.leftRightMargin,
            left: measurements.leftRightMargin,
            top: measurements.topDownMargin,
            bottom: measurements.topDownMargin),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Flex(
                direction: Axis.vertical,
                children: [
                  Text('Wall Street Bets for Fools'),
                  Text('Lose Money With Friends'),
                ],
              ),
              Flex(
                direction: Axis.horizontal,
                children: [
                  OutlinedButton(
                    child: Text('MONTH'),
                    onPressed: updateMonthlyInterval,
                  ),
                  OutlinedButton(
                    child: Text('WEEK'),
                    onPressed: updateWeeklyInterval,
                  ),
                  OutlinedButton(
                    child: Text('DAY'),
                    onPressed: updateDailyInterval,
                  ),
                ],
              )
            ]),
            SizedBox(height: measurements.gutter, width: measurements.gutter),
            APIDataSlicers(
              summary: summary,
              width: adaptive.width,
              gutter: measurements.gutter,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Weekly Index'),
                Row(
                  children: [
                    Text('Gain'),
                    SizedBox(width: 10),
                    Text('Loss'),
                    SizedBox(width: 10),
                    Text('Total'),
                  ],
                )
              ],
            ),
            Expanded(
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
            )
          ],
        ),
      ),
    );
  }
}

class APIDataSlicers extends StatelessWidget {
  final Future<PostSummary> summary;
  final double width;
  final double gutter;
  final double textFieldHeigh = 80;
  final double minWidth = 600;

  APIDataSlicers({this.summary, this.width, this.gutter});

  build(BuildContext context) {
    return FutureBuilder<PostSummary>(
        future: summary,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return LayoutBuilder(
              builder: (context, constraint) {
                int crossAxisCount = width < minWidth ? 1 : 3;
                double itemWidth = constraint.maxWidth / crossAxisCount;

                return GridView.count(
                  primary: false,
                  shrinkWrap: true,
                  childAspectRatio: itemWidth / textFieldHeigh,
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: gutter,
                  mainAxisSpacing: gutter,
                  children: [
                    MetricCard(
                        title: 'Gain',
                        rate: snapshot.data.gainGrowthRate,
                        total: snapshot.data.gain),
                    MetricCard(
                        title: 'Loss',
                        rate: snapshot.data.lossGrowthRate,
                        total: snapshot.data.loss),
                    MetricCard(
                        title: 'Difference',
                        rate: snapshot.data.lossGrowthRate,
                        total: snapshot.data.loss)
                  ],
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return SizedBox(
            height: 30,
          );
        });
  }
}

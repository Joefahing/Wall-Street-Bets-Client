import 'dart:async';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as Charts;

import '../model/post.dart';
import '../model/summary.dart';
import '../controllers/APIController.dart';
import '../widgets/LineChart.dart';
import '../components/adaptive.dart';

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

    final apiResponse = apiController.fetchPosts('month');
    summary = apiController.getSummary(response: apiResponse);
    posts = apiController.getPosts(response: apiResponse);
    lineGraphDataSet = apiController.getGainLossDataPoint(response: apiResponse);
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
                  OutlinedButton(child: Text('YEAR')),
                  OutlinedButton(child: Text('WEEK')),
                  OutlinedButton(child: Text('DAY')),
                ],
              )
            ]),
            SizedBox(height: measurements.gutter, width: measurements.gutter),
            FutureBuilder<PostSummary>(
                future: summary,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return LayoutBuilder(
                      builder: (context, constraint) {
                        ///These variable will be move to grid view unit
                        int crossAxisCount = adaptive.width < 600 ? 1 : 3;
                        double textFieldHeigh = 80;
                        double itemWidth = constraint.maxWidth / crossAxisCount;

                        return GridView.count(
                          primary: false,
                          shrinkWrap: true,
                          childAspectRatio: itemWidth / textFieldHeigh,
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
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
                }),
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

class MetricCard extends StatelessWidget {
  final String title;
  final int total;
  final double rate;

  MetricCard({@required this.title, @required this.total, @required this.rate});

  Widget build(context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text('$title'), Text('Number of Post $total'), Text('Growth Rate $rate%')],
      ),
    );
  }
}

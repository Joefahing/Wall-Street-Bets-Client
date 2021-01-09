import 'dart:async';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as Charts;

import '../components/adaptive.dart';
import '../controllers/APIController.dart';
import '../model/post.dart';
import '../model/summary.dart';
import '../components/theme_data.dart' as theme;

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
  String interval = 'week';

  final apiController = APIController();

  ///This helper method refetches data from API base on current interval and set
  ///them to instance variables used to power the data and display
  void _prepareAPIData() {
    final apiResponse = apiController.fetchPosts(interval);
    summary = apiController.getSummary(response: apiResponse);
    posts = apiController.getPosts(response: apiResponse);
    lineGraphDataSet = apiController.getGainLossDataPoint(response: apiResponse);
  }

  String _prepareChartTitle(String interval) {
    switch (interval) {
      case 'week':
        return 'Weekly';
      case 'day':
        return 'Daily';
      case 'month':
        return 'Monthly';
      default:
        throw Exception('Invalid Interval');
    }
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
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(measurements.gutter/2),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Flex(
                  direction: Axis.vertical,
                  children: [
                    Text('Wall Street Bets for Fools', style: theme.headline1),
                    Text('Lose Money With Friends', style: theme.headline3),
                  ],
                ),
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    OutlinedButton(
                      child: Text('MONTH', style: theme.bodyText,),
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
            ),
            SizedBox(height: measurements.gutter/2, width: measurements.gutter),
            APIDataSlicers(
              summary: summary,
              width: adaptive.width,
              gutter: measurements.gutter,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${_prepareChartTitle(interval)} Index'),
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
                  final marginMultiplier = 3;
                  if (future.hasData) {
                    return WallStreetBetTimeSeriesChart(series: future.data);
                  } else if (future.hasError) {
                    return Text("${future.error}");
                  }
                  return Center(
                    child: Padding(
                        padding: EdgeInsets.only(
                          right: measurements.leftRightMargin * marginMultiplier,
                          left: measurements.leftRightMargin * marginMultiplier,
                        ),
                        child: LinearProgressIndicator()),
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
  final double minWidth = 750;
  final double percentage = 100.0;
  final String bullIcon = '../assets/images/bull_icon.png';
  final String bearIcon = '../assets/images/bear_icon.png';
  final String kangarooIcon = '../assets/images/kangaroo_icon.png';

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
                      rate: snapshot.data.gainGrowthRate * percentage,
                      total: snapshot.data.gain,
                      imageUrl: bullIcon,
                      color: theme.lightGreen,
                    ),
                    MetricCard(
                      title: 'Loss',
                      rate: snapshot.data.lossGrowthRate * percentage,
                      total: snapshot.data.loss,
                      imageUrl: bearIcon,
                      color: theme.lightPink,
                    ),
                    MetricCard(
                        title: 'Difference',
                        rate: snapshot.data.differenceGrowthRate * percentage,
                        total: snapshot.data.difference,
                        imageUrl: kangarooIcon,
                        color: theme.lightOrange)
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

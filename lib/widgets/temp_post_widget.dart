import 'dart:async';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as Charts;

import '../model/post.dart';
import '../model/summary.dart';
import '../controllers/APIController.dart';
import '../components/adaptive.dart';
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
  ///These variable will be retired and move to their own view later
  //Future<List<Post>> posts;
  Future<PostSummary> summary;
  ////////////////////////////

  Future<List<Charts.Series>> lineGraphDataSet;
  String interval = 'week';

  final apiController = APIController();

  ///This helper method refetches data from API base on current interval and set
  ///them to instance variables used to power the data and display
  void _preparePostData() {
    final String postRoute = "http://wall-street-bet-server.herokuapp.com/post/profit/";
    final apiResponse = apiController.fetchFromEndPoint(route: postRoute, time: interval);

    summary = apiController.getSummary(response: apiResponse);
    //posts = apiController.getPosts(response: apiResponse);
    // lineGraphDataSet = apiController.getGainLossDataPoint(response: apiResponse);
  }

  void _prepareIndexData() {
    final String indexRoute = "http://wall-street-bet-server.herokuapp.com/post/index/";
    final indexAPIResponse = apiController.fetchFromEndPoint(route: indexRoute, time: interval);

    lineGraphDataSet = apiController.getIndexGraphDataSet(response: indexAPIResponse);
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
      _preparePostData();
    });
  }

  void updateMonthlyInterval() {
    setState(() {
      interval = 'month';
      _preparePostData();
    });
  }

  void updateDailyInterval() {
    setState(() {
      interval = 'day';
      _preparePostData();
    });
  }

  void updateInterval(index) {
    final Map<int, String> toggleMap = {0: 'month', 1: 'week', 2: 'day'};
    final defaultInterval = 'month';
    final selection = toggleMap.containsKey(index) ? toggleMap[index] : defaultInterval;

    switch (selection) {
      case 'month':
        updateMonthlyInterval();
        break;
      case 'week':
        updateWeeklyInterval();
        break;
      case 'day':
        updateDailyInterval();
        break;
    }
  }

  @override
  void initState() {
    super.initState();

    _preparePostData();
    _prepareIndexData();
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
        ),
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(
                top: measurements.topDownMargin,
                bottom: measurements.topDownMargin,
              ),
              child: Column(
                children: [
                  FlatBackgroundBox(
                    child: LayoutBuilder(
                      builder: (context, constraint) {
                        final double minWidth = 750;
                        int crossAxisCount = adaptive.width < minWidth ? 1 : 2;
                        double itemWidth = constraint.maxWidth / crossAxisCount;
                        int widgetHeigh = crossAxisCount == 1 ? 65 : 80;
                        return GridView.count(
                          childAspectRatio: itemWidth / widgetHeigh,
                          crossAxisCount: crossAxisCount,
                          primary: false,
                          shrinkWrap: true,
                          children: [
                            Column(
                              children: [
                                Text('Wall Street Bets for Fools', style: theme.headline1),
                                Text('Lose Money With Friends', style: theme.headline3),
                              ],
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: crossAxisCount == 1
                                    ? MainAxisAlignment.center
                                    : MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(width: 1),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: theme.lightGray,
                                      borderRadius: BorderRadius.circular(theme.borderRadius),
                                    ),
                                    child: Row(
                                      children: [
                                        IntervalFlatButton(
                                            title: 'Monthly',
                                            color: interval == 'month'
                                                ? Colors.white
                                                : theme.lightGray,
                                            onPressed: updateMonthlyInterval),
                                        SizedBox(width: measurements.gutter / 2),
                                        IntervalFlatButton(
                                            title: 'Weekly',
                                            color:
                                                interval == 'week' ? Colors.white : theme.lightGray,
                                            onPressed: updateWeeklyInterval),
                                        SizedBox(width: measurements.gutter / 2),
                                        IntervalFlatButton(
                                            title: 'Daily',
                                            color:
                                                interval == 'day' ? Colors.white : theme.lightGray,
                                            onPressed: updateDailyInterval),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: measurements.gutter / 2, width: measurements.gutter),
                  APIDataSlicers(
                    summary: summary,
                    width: adaptive.width,
                    gutter: measurements.gutter,
                  ),
                  SizedBox(height: measurements.gutter / 2, width: measurements.gutter),
                  Container(
                    height: 2000,
                    constraints: BoxConstraints(minHeight: 300, maxHeight: 800),
                    child: FlatBackgroundBox(
                      child: Flex(
                        direction: Axis.vertical,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${_prepareChartTitle(interval)} Index',
                                style: theme.headline1,
                              ),
                              Row(
                                children: [
                                  Circle(diameter: 10, color: theme.limeGreen),
                                  SizedBox(width: measurements.gutter / 4),
                                  Text('Gain', style: theme.getSubHeadWithColor(theme.limeGreen)),
                                  SizedBox(width: measurements.gutter),
                                  Circle(diameter: 10, color: theme.fireRed),
                                  SizedBox(width: measurements.gutter / 4),
                                  Text('Loss', style: theme.getSubHeadWithColor(theme.fireRed)),
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Circle extends StatelessWidget {
  final double diameter;
  final Color color;

  Circle({@required this.diameter, @required this.color});

  build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

class IntervalFlatButton extends StatelessWidget {
  final String title;
  final Color color;
  final void Function() onPressed;

  IntervalFlatButton({@required this.title, this.color, @required this.onPressed});

  @override
  build(BuildContext context) {
    return FlatButton(
        child: Text(title, style: theme.headline4),
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(theme.borderRadius / 2)),
        onPressed: onPressed,
        hoverColor: theme.lightSilver);
  }
}

class FlatBackgroundBox extends StatelessWidget {
  final Widget child;

  FlatBackgroundBox({@required this.child});

  @override
  build(BuildContext context) {
    final adaptive = AdaptiveWindow.fromContext(context: context);
    final measurements = adaptive.getBreakpoint();
    return Container(
      padding: EdgeInsets.all(measurements.gutter),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(theme.borderRadius),
        color: Colors.white,
      ),
      child: child,
    );
  }
}

class APIDataSlicers extends StatelessWidget {
  final Future<PostSummary> summary;
  final double width;
  final double gutter;
  final double textFieldHeigh = 100;
  final double minWidth = 750;
  final double percentage = 100.0;
  final String bullIcon = 'assets/images/bull_icon.png';
  final String bearIcon = 'assets/images/bear_icon.png';
  final String kangarooIcon = 'assets/images/kangaroo_icon.png';

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

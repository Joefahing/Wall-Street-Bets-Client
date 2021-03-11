import 'dart:async';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as Charts;

import '../../controllers/APIController.dart';
import '../../components/adaptive.dart';
import '../../components/theme_data.dart' as theme;

import '../../widgets/line_chart.dart';

class WallStreetBetIndexPage extends StatefulWidget {
  WallStreetBetIndexPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WallStreetBetIndexPageState createState() => _WallStreetBetIndexPageState();
}

class _WallStreetBetIndexPageState extends State<WallStreetBetIndexPage> {
  final apiController = APIController();
  String interval = 'week';
  Future<List<Charts.Series<dynamic, DateTime>>> indexDataSeries;

  void _prepareIndexData() {
    final String indexRoute = "http://wall-street-bet-server.herokuapp.com/post/index/";
    final indexAPIResponse = apiController.fetchFromEndPoint(route: indexRoute, time: interval);
    indexDataSeries = apiController.getIndexGraphData(response: indexAPIResponse);
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
      _prepareIndexData();
    });
  }

  void updateMonthlyInterval() {
    setState(() {
      interval = 'month';
      _prepareIndexData();
    });
  }

  void updateDailyInterval() {
    setState(() {
      interval = 'day';
      _prepareIndexData();
    });
  }

  void reload() {
    setState(() {
      print('Reloading');
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
    _prepareIndexData();
  }

  @override
  Widget build(BuildContext context) {
    final adaptive = AdaptiveWindow.fromContext(context: context);
    final screenHeigh = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final chartHeighFactor = 8 / 10;
    final double minChartHeigh = 500;
    final double maxChartHeigh = screenHeigh * chartHeighFactor < minChartHeigh
        ? minChartHeigh
        : screenHeigh * chartHeighFactor;
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
                  Container(
                    constraints: BoxConstraints(minHeight: minChartHeigh, maxHeight: maxChartHeigh),
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
                            ],
                          ),
                          Expanded(
                            child: FutureBuilder(
                              future: indexDataSeries,
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

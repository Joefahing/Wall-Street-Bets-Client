import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class WallStreetBetTimeSeriesChart extends StatelessWidget {
  final List<charts.Series> series;
  final bool animate;

  WallStreetBetTimeSeriesChart({this.series, this.animate});

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      series,
      animate: animate,
      dateTimeFactory: const charts.UTCDateTimeFactory(),
    );
  }
}

///Data Structured used to hold time and post
class TimeSeriesPosts {
  final DateTime time;
  final int totalPosts;

  TimeSeriesPosts(this.time, this.totalPosts);
}

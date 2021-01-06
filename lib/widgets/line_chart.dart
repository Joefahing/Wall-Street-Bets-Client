import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as Charts;

class WallStreetBetTimeSeriesChart extends StatelessWidget {
  final List<Charts.Series> series;

  WallStreetBetTimeSeriesChart({this.series});

  @override
  Widget build(BuildContext context) {
    return new Charts.TimeSeriesChart(
      series,
      animate: false,
      dateTimeFactory: const Charts.UTCDateTimeFactory(),
    );
  }
}
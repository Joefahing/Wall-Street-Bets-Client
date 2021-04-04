import 'package:charts_flutter/flutter.dart' as Charts;

class TimeSeriesPosts {
  final DateTime time;
  final int totalPosts;

  TimeSeriesPosts({this.time, this.totalPosts});
}

Charts.Series<dynamic, DateTime> convertDataToChartSeries(
    {List<TimeSeriesPosts> data, dynamic color}) {
  return new Charts.Series<TimeSeriesPosts, DateTime>(
    id: 'Index ',
    colorFn: (_, __) => color,
    domainFn: (TimeSeriesPosts data, _) => data.time,
    measureFn: (TimeSeriesPosts data, _) => data.totalPosts,
    data: data,
  );
}

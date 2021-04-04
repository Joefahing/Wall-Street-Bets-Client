import 'package:redux/redux.dart';
import 'package:charts_flutter/flutter.dart' as Charts;

import '../states/appState.dart';
import '../../model/index.dart';
import '../../components/timeSeries.dart';

class IndexPageViewModel {
  final String interval;
  final bool isFetching;
  final bool fetchingError;
  final bool fetchingComplete;
  final List<Index> indexes;

  IndexPageViewModel({
    this.interval,
    this.isFetching,
    this.fetchingError,
    this.fetchingComplete,
    this.indexes,
  });

  factory IndexPageViewModel.fromStore(Store<AppState> store) {
    return IndexPageViewModel(
        interval: store.state.viewState.interval,
        isFetching: store.state.indexState.isFetching,
        fetchingComplete: store.state.indexState.fetchingComplete,
        fetchingError: store.state.indexState.fetchingError,
        indexes: store.state.indexState.indexes);
  }

  String get intervalTitle {
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

  List<Charts.Series<dynamic, DateTime>> get indexChartData {
    final timeSeriesIndexes = _convertIndexToTimeSeries(indexes: this.indexes);
    final indexChartData = convertDataToChartSeries(
      data: timeSeriesIndexes,
      color: Charts.MaterialPalette.green.shadeDefault,
    );
    return [indexChartData];
  }

  ///Flutter chart requires a format that provides the library with points and time. Index object that are plotted in charts are converted to TimeSeries for
  ///the chart library to be more universally accessible
  List<TimeSeriesPosts> _convertIndexToTimeSeries({List<Index> indexes}) {
    final List<TimeSeriesPosts> convertedSeries = [];

    indexes.forEach((index) {
      final newSeries = TimeSeriesPosts(time: index.dateCreated, totalPosts: index.points);
      convertedSeries.add(newSeries);
    });

    return convertedSeries;
  }
}

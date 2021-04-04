import 'package:redux/redux.dart';
import '../states/appState.dart';

class IndexPageViewModel {
  final String interval;

  IndexPageViewModel({this.interval});

  factory IndexPageViewModel.fromStore(Store<AppState> store) {
    return IndexPageViewModel(interval: store.state.viewState.interval);
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
}

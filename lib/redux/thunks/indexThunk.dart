import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import '../actions/viewAction.dart';
import '../states/appState.dart';

ThunkAction<AppState> getIndexByIntervalThunk(Store<AppState> store, String interval) {
  return store.dispatch(ViewIntervalPickerPressAction(interval: interval));
}

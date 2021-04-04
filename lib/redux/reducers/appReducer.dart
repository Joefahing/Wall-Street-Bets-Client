import 'package:wsb_dashboard/redux/states/appState.dart';

import '../actions/navigationAction.dart';
import '../states/navigationState.dart';
import '../actions/viewAction.dart';
import '../states/viewState.dart';

//NavigationState will be seperated into it's own file once there are more reducers
NavigationState _tabPressed(NavigationState state, dynamic action) {
  if (action is NavigationTabPressedAction) {
    return state.copyWith(tab: action.tab);
  }
  return state;
}

ViewState _intervalSelectorPressed(ViewState state, dynamic action) {
  if (action is ViewIntervalPickerPressAction) {
    return state.copyWith(interval: action.interval);
  }
  return state;
}

final navigationReducer = _tabPressed;
final viewReducer = _intervalSelectorPressed;

AppState appReducer(AppState state, action) {
  return AppState(
    navState: navigationReducer(state.navState, action),
    viewState: viewReducer(state.viewState, action),
  );
}

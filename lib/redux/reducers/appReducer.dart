import 'package:wsb_dashboard/redux/states/appState.dart';

import '../actions/navigationAction.dart';
import '../states/navigationState.dart';


//NavigationState will be seperated into it's own file once there are more reducers
NavigationState _tabPressed(NavigationState state, NavigationTabPressedAction action) {
  return state.copyWith(tab: action.tab);
}

final navigationReducer = _tabPressed;

AppState appReducer(AppState state, action) {
  return AppState(navState: navigationReducer(state.navState, action));
}

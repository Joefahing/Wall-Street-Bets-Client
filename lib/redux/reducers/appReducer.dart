import '../actions/navigationAction.dart';
import '../states/navigationState.dart';

NavigationState _tabPressed(NavigationState state, NavigationTabPressedAction action) {
  return state.copyWith(tab: action.tab);
}

final navigationReducer = _tabPressed;

import '../actions/navigationAction.dart';
import '../states/navigationState.dart';

NavigationState _tabPressed(NavigationState state, dynamic action) {
  if (action is NavigationTabPressedAction) {
    return state.copyWith(tab: action.tab);
  }
  return state;
}

final navigationReducer = _tabPressed;


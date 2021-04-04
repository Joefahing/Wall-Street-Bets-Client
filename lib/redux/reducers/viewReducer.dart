import '../actions/viewAction.dart';
import '../states/viewState.dart';

ViewState _intervalSelectorPressed(ViewState state, dynamic action) {
  if (action is ViewIntervalPickerPressAction) {
    return state.copyWith(interval: action.interval);
  }
  return state;
}

final viewReducer = _intervalSelectorPressed;

import 'package:redux/redux.dart';
import '../actions/indexAction.dart';
import '../states/indexState.dart';

IndexState _getIndexSuccess(IndexState state, GetWSBIndeSuccessAction action) {
  return state.copyWith(
    indexes: action.indexes,
    fetchingComplete: true,
    isFeching: false,
    fetchingError: false,
  );
}

IndexState _getIndexFailed(IndexState state, GetWSBIndexFailedAction action) {
  return state
      .copyWith(fetchingComplete: false, isFeching: false, fetchingError: true, indexes: []);
}

IndexState _getIndexLoading(IndexState state, GetWSBIndexLoadingAction action) {
  return state
      .copyWith(isFeching: true, fetchingComplete: false, fetchingError: false, indexes: []);
}

final indexReducer = combineReducers<IndexState>([
  TypedReducer<IndexState, GetWSBIndeSuccessAction>(_getIndexSuccess),
  TypedReducer<IndexState, GetWSBIndexFailedAction>(_getIndexFailed),
  TypedReducer<IndexState, GetWSBIndexLoadingAction>(_getIndexLoading),
]);

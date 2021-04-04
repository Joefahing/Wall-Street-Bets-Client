import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'reducers/appReducer.dart';
import 'states/appState.dart';

class ReduxStore {
  static final Store<AppState> _store = Store<AppState>(
    appReducer,
    initialState: AppState.init(),
    middleware: [thunkMiddleware],
  );

  static Store<AppState> get store => _store;
}

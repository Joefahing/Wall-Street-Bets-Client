import 'package:wsb_dashboard/redux/states/appState.dart';

import 'indexReducer.dart';
import 'navigationReducer.dart';
import 'viewReducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    indexState: indexReducer(state.indexState, action),
    navState: navigationReducer(state.navState, action),
    viewState: viewReducer(state.viewState, action),
  );
}

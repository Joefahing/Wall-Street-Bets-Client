import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import '../actions/indexAction.dart';
import '../states/appState.dart';
import '../../services/remoteServices.dart';

/// This thunk is the middleware responsible for fetching indexes off the backend api
ThunkAction<AppState> getIndexByIntervalThunk() => (Store<AppState> store) async {
      try {
        store.dispatch(GetWSBIndexLoadingAction());
        final indexes = await RemoteService.getIndex(store.state.viewState.interval);
        store.dispatch(GetWSBIndeSuccessAction(indexes: indexes));
      } catch (error) {
        store.dispatch(GetWSBIndexFailedAction());
      }
    };

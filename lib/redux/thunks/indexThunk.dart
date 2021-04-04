import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import '../actions/indexAction.dart';
//import '../actions/viewAction.dart';
import '../states/appState.dart';
import '../../services/remoteServices.dart';

ThunkAction<AppState> getIndexByIntervalThunk() => (Store<AppState> store) async {
      try {
        store.dispatch(GetWSBIndexLoadingAction());
        //print('printing indexes ');

        final indexes = await RemoteService.getIndex(store.state.viewState.interval);
        //print('printing indexes $indexes');
        store.dispatch(GetWSBIndeSuccessAction(indexes: indexes));
      } catch (error) {
        store.dispatch(GetWSBIndexFailedAction());
      }
    };
  
   //store.dispatch(ViewIntervalPickerPressAction(interval: interval)
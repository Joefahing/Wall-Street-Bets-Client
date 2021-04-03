import 'package:redux/redux.dart';

import '../states/appState.dart';

class NavigationViewModel {
  final String tab;

  NavigationViewModel({this.tab});

  factory NavigationViewModel.fromStore(Store<AppState> store) {
    return NavigationViewModel(tab: store.state.navState.tab);
  }
}

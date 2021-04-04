import 'package:flutter/material.dart';

import 'navigationState.dart';
import 'viewState.dart';

@immutable
class AppState {
  final NavigationState navState;
  final ViewState viewState;

  AppState({this.navState, this.viewState});

  factory AppState.init() {
    return AppState(
      navState: NavigationState.init(),
      viewState: ViewState.init(),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppState && navState == other.navState && viewState == other.viewState);

  @override
  int get hashCode => navState.hashCode ^ viewState.hashCode;

  AppState copyWith({NavigationState newNavState, ViewState viewState}) {
    return AppState(
      navState: newNavState ?? this.navState,
      viewState: viewState ?? this.viewState,
    );
  }
}

import 'package:flutter/material.dart';

import 'indexState.dart';
import 'navigationState.dart';
import 'viewState.dart';

@immutable
class AppState {
  final IndexState indexState;
  final NavigationState navState;
  final ViewState viewState;

  AppState({this.indexState, this.navState, this.viewState});

  factory AppState.init() {
    return AppState(
      indexState: IndexState.init(),
      navState: NavigationState.init(),
      viewState: ViewState.init(),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppState &&
          this.indexState == other.indexState &&
          this.navState == other.navState &&
          this.viewState == other.viewState);

  @override
  int get hashCode => indexState.hashCode ^ navState.hashCode ^ viewState.hashCode;

  AppState copyWith(
      {IndexState newIndexState, NavigationState newNavState, ViewState newViewState}) {
    return AppState(
      indexState: newIndexState ?? this.indexState,
      navState: newNavState ?? this.navState,
      viewState: newViewState ?? this.viewState,
    );
  }
}

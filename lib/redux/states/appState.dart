import 'package:flutter/material.dart';

import 'navigationState.dart';

@immutable
class AppState {
  final NavigationState navState;

  AppState({this.navState});

  factory AppState.init() {
    return AppState(navState: NavigationState.init());
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is AppState && navState == other.navState);

  @override
  int get hashCode => navState.hashCode;

  AppState copyWith({NavigationState newNavState}) {
    return AppState(navState: newNavState ?? this.navState);
  }
}

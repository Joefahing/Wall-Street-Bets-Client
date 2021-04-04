import 'package:flutter/material.dart';

///The three available intervals are day, week, and month

@immutable
class ViewState {
  final String interval;

  ViewState({this.interval});

  factory ViewState.init() {
    return ViewState(interval: 'week');
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is ViewState && other.interval == interval);

  @override
  int get hashCode => interval.hashCode;

  ViewState copyWith({String interval}) {
    return ViewState(interval: interval ?? this.interval);
  }
}

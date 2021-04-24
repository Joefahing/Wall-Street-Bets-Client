import 'package:flutter/material.dart';
import '../../model/index.dart';

@immutable
class IndexState {
  final bool isFetching;
  final bool fetchingComplete;
  final bool fetchingError;
  final List<Index> indexes;
  final String errorMessage;

  IndexState(
      {this.isFetching,
      this.fetchingComplete,
      this.fetchingError,
      this.indexes,
      this.errorMessage});

  factory IndexState.init() {
    return IndexState(
        isFetching: false,
        fetchingComplete: true,
        fetchingError: false,
        indexes: [],
        errorMessage: '');
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is IndexState &&
            other.isFetching == this.isFetching &&
            other.fetchingComplete == this.fetchingComplete &&
            other.fetchingError == this.fetchingError &&
            other.indexes == this.indexes &&
            other.errorMessage == this.errorMessage);
  }

  @override
  int get hashCode =>
      isFetching.hashCode ^ fetchingComplete.hashCode ^ fetchingError.hashCode ^ indexes.hashCode;

  IndexState copyWith(
      {bool isFeching,
      bool fetchingComplete,
      bool fetchingError,
      List<Index> indexes,
      String errorMessage}) {
    return IndexState(
        isFetching: isFeching ?? this.isFetching,
        fetchingComplete: fetchingComplete ?? this.fetchingComplete,
        fetchingError: fetchingError ?? this.fetchingError,
        indexes: indexes ?? this.indexes,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}

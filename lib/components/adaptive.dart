import 'package:flutter/material.dart';

enum AdaptiveWindow { small, medium, large }

extension on AdaptiveWindow {
  static AdaptiveWindow getAdaptiveWindowBySize({BuildContext context}) {
    double windowWidth = MediaQuery.of(context).size.width;

    if (windowWidth >= 0 && windowWidth <= 600) {
      return AdaptiveWindow.small;
    } else if (windowWidth >= 601 && windowWidth <= 1024) {
      return AdaptiveWindow.medium;
    } else if (windowWidth >= 1025) {
      return AdaptiveWindow.large;
    } else {
      throw Exception('Incorrect window size');
    }
  }

  Breakpoint getBreakpoint(BuildContext context) {
    double windowWidth = MediaQuery.of(context).size.width;
    const double baseWidth = 1025;

    switch (this) {
      case AdaptiveWindow.small:
        return Breakpoint.small();
      case AdaptiveWindow.medium:
        return Breakpoint.medium();
      case AdaptiveWindow.large:
        return Breakpoint.large(base: baseWidth, extended: windowWidth);
      default:
        throw AssertionError('Unable to identify window');
    }
  }
}

class Breakpoint {
  final int column;
  final double gutter = 16;
  final double topDownMargin = 16;
  final double leftRightMargin;

  Breakpoint({this.column, this.leftRightMargin});

  factory Breakpoint.small() {
    return Breakpoint(column: 4, leftRightMargin: 16);
  }

  factory Breakpoint.medium() {
    return Breakpoint(column: 8, leftRightMargin: 32);
  }

  factory Breakpoint.large({double base, double extended}) {
    return Breakpoint(column: 16, leftRightMargin: (extended - base) + 32);
  }
}

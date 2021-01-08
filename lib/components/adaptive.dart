import 'package:flutter/material.dart';

// enum AdaptiveWindow { small, medium, large }

class AdaptiveWindow {
  double width;
  String type;

  AdaptiveWindow({this.width, this.type});

  factory AdaptiveWindow.fromContext({BuildContext context}) {
    double width = MediaQuery.of(context).size.width;

    if (width >= 0 && width <= 750) {
      return AdaptiveWindow(width: width, type: 'small');
    } else if (width >= 751 && width <= 1224) {
      return AdaptiveWindow(width: width, type: 'medium');
    } else if (width >= 1225) {
      return AdaptiveWindow(width: width, type: 'large');
    } else {
      throw Exception('Incorrect window size');
    }
  }

  Breakpoint getBreakpoint() {
    const double baseWidth = 1025;

    switch (type) {
      case 'small':
        return Breakpoint.small();
      case 'medium':
        return Breakpoint.medium();
      case 'large':
        return Breakpoint.large(base: baseWidth, extended: width);
      default:
        throw AssertionError('Unable to identify window');
    }
  }
}


class Breakpoint {
  final int column;
  final double gutter;
  final double topDownMargin = 16;
  final double leftRightMargin;

  Breakpoint({this.column, this.gutter, this.leftRightMargin});

  factory Breakpoint.small() {
    return Breakpoint(column: 4, gutter: 8, leftRightMargin: 16);
  }

  factory Breakpoint.medium() {
    return Breakpoint(column: 8, gutter: 16, leftRightMargin: 32);
  }

  factory Breakpoint.large({double base, double extended}) {
    const multiplier = 5;
    return Breakpoint(column: 16, gutter: 16, leftRightMargin: (extended - base) / multiplier + 32);
  }
}

import 'package:flutter/material.dart';

class ResponsiveContainer extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;
  final double mobileWidth = 450;
  final double tabletWidth = 1024;
  final double desktopWidth = double.infinity;

  ResponsiveContainer({@required this.mobile, @required this.tablet, @required this.desktop});

  @override
  build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        if (constraint.maxWidth < mobileWidth) {
          return mobile;
        }
        if (constraint.maxWidth < tabletWidth) {
          return tablet;
        } else {
          return desktop;
        }
      },
    );
  }
}

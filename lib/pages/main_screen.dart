import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraint) {},
      ),
    );
  }
}

class ResponsiveContainer extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  ResponsiveContainer({@required this.mobile, @required this.tablet, @required this.desktop});

  @override
  build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        if (constraint.maxWidth < 350) {
          return mobile;
        }
        if (constraint.maxWidth < 750) {
          return tablet;
        } else {
          return desktop;
        }
      },
    );
  }
}

import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  static const String RouteName = '/error';

  @override
  build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Error Page'),
      ),
    );
  }
}

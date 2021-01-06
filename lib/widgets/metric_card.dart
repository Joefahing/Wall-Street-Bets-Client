import 'package:flutter/material.dart';

class MetricCard extends StatelessWidget {
  final String title;
  final int total;
  final double rate;

  MetricCard({@required this.title, @required this.total, @required this.rate});

  Widget build(context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text('$title'), Text('Number of Post $total'), Text('Growth Rate $rate%')],
      ),
    );
  }
}

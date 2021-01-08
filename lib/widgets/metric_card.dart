import 'package:flutter/material.dart';

class MetricCard extends StatelessWidget {
  final String title;
  final int total;
  final double rate;
  final String imageUrl;

  MetricCard({
    @required this.title,
    @required this.total,
    @required this.rate,
    @required this.imageUrl,
  });

  Widget build(context) {
    return Card(
      child: Row(
        children: [
          Image.asset(imageUrl),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$title'),
                Text('Number of Post $total'),
                Text('Growth Rate ${rate.toStringAsFixed(1)}%'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

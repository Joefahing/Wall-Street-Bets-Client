import 'package:flutter/material.dart';
import '../components/theme_data.dart';

class MetricCard extends StatelessWidget {
  final String title;
  final int total;
  final double rate;
  final String imageUrl;
  final Color color;

  MetricCard(
      {@required this.title,
      @required this.total,
      @required this.rate,
      @required this.imageUrl,
      this.color});

  Widget build(context) {
    return Card(
      color: color,
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imageUrl, width: 50,),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$title', style: headline2,),
                Text('Post: $total', style: bodyText2,),
                Text('Growth: ${rate.toStringAsFixed(1)}%', style: bodyText2,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

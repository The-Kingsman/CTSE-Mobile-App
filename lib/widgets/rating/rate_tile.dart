import 'package:flutter/material.dart';
import 'package:teach_rate/models/Rating.dart';

class RateTile extends StatelessWidget {
  final Rating _rate;

  const RateTile(this._rate);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _rate.id,
            style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

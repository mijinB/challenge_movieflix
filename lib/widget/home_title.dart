import 'package:flutter/material.dart';

class HomeTitle extends StatelessWidget {
  final String title;
  final double lineWidth;

  const HomeTitle({
    super.key,
    required this.title,
    required this.lineWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 18,
            ),
            Text(
              title,
              style: TextStyle(
                  fontFamily: 'Rubik',
                  color: Theme.of(context).canvasColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.4),
            ),
          ],
        ),
        const SizedBox(
          height: 3,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 15,
            ),
            Container(
              height: 1.5,
              width: lineWidth,
              color: Theme.of(context).canvasColor,
            ),
          ],
        ),
        const SizedBox(
          height: 27,
        ),
      ],
    );
  }
}

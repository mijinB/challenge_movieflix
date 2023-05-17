import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.chevron_left_rounded,
                      color: Theme.of(context).canvasColor,
                      size: 45,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Back to list',
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      color: Theme.of(context).canvasColor,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 230,
              ),
              Text(
                'There are no linked pages.',
                style: TextStyle(
                  fontFamily: 'Rubik',
                  color: Theme.of(context).canvasColor,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              Icon(
                Icons.psychology_alt_rounded,
                size: 140,
                color: Theme.of(context).canvasColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}

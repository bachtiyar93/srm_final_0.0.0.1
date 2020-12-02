import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  final String text;

  const LoadingScreen({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            Text(text),
          ],
        ),
      ),
    );
  }
}

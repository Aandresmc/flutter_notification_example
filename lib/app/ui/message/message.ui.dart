import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  final Map? arguments;

  const MessageScreen({Key? key, this.arguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Message'),
      ),
      body: Center(
        child: Text(arguments != null ? '$arguments' : 'No data', style: TextStyle(fontSize: 30)),
      ),
    );
  }
}

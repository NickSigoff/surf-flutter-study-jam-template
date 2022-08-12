import 'package:flutter/material.dart';

/// Screen, that is used for creating new chat topics.
class CreateTopicScreen extends StatelessWidget {
  /// Constructor for [CreateTopicScreen].
  const CreateTopicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemBuilder: (context, index) => Container(),
      ),
    );
  }
}

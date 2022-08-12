import 'package:flutter/material.dart';

import '../repository/chart_topics_repository.dart';

/// Screen with different chat topics to go to.
class TopicsScreen extends StatelessWidget {
  final ChatTopicsRepository chatTopicsRepository;

  /// Constructor for [TopicsScreen].
  const TopicsScreen({Key? key, required this.chatTopicsRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text('Topics'),),
    );
  }
}

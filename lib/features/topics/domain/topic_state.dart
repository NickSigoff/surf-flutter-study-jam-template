part of 'topic_bloc.dart';

@immutable
abstract class TopicState {}

class TopicInitial extends TopicState {}

class TopicLoading extends TopicState {}

class TopicSuccess extends TopicState {
  final Iterable<ChatTopicDto> topicList;

  TopicSuccess({required this.topicList});
}

class TopicError extends TopicState {}

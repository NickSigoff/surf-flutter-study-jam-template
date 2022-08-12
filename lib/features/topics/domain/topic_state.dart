part of 'topic_bloc.dart';

@immutable
abstract class TopicState {}

class TopicInitial extends TopicState {}

class TopicLoading extends TopicState {}

class TopicSuccess extends TopicState {
  final String? userName;
  final Iterable<ChatTopicDto> topicList;

  TopicSuccess({required this.topicList, this.userName});
}

class TopicNavigateSuccess extends TopicState {
  final ChatRepository chatRepo;

  TopicNavigateSuccess({required this.chatRepo});
}

class TopicError extends TopicState {}

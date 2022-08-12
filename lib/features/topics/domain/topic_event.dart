part of 'topic_bloc.dart';

@immutable
abstract class TopicEvent {}

class OnPageCreated extends TopicEvent {
  final ChatTopicsRepository chatTopicsRepository;

  OnPageCreated({required this.chatTopicsRepository});
}

class OnTapTopic extends TopicEvent {}

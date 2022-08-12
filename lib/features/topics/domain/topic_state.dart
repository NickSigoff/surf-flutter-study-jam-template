part of 'topic_bloc.dart';

@immutable
abstract class TopicState {}

class TopicInitial extends TopicState {}

class TopicLoading extends TopicState {}

class TopicSuccess extends TopicState {}

class TopicError extends TopicState {}

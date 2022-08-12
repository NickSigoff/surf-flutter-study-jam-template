import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../models/chat_topic_dto.dart';
import '../repository/chart_topics_repository.dart';

part 'topic_event.dart';

part 'topic_state.dart';

class TopicBloc extends Bloc<TopicEvent, TopicState> {
  TopicBloc() : super(TopicInitial()) {
    on<OnPageCreated>((event, emit) async {
      try {
        emit(TopicLoading());
        Iterable<ChatTopicDto> topicList =
            await event.chatTopicsRepository.getTopics(topicsStartDate: DateTime(2022));
        emit(TopicSuccess(topicList: topicList));
      } catch (e) {
        print(e);
        emit(TopicError());
      }
    });
  }
}

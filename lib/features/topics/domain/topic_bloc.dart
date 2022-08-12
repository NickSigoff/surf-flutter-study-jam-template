import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:surf_study_jam/surf_study_jam.dart';

import '../repository/chart_topics_repository.dart';

part 'topic_event.dart';

part 'topic_state.dart';

class TopicBloc extends Bloc<TopicEvent, TopicState> {
  TopicBloc() : super(TopicInitial()) {
    on<OnPageCreated>((event, emit) {
      emit(TopicLoading());

      ChatTopicsRepository repository = ChatTopicsRepository(StudyJamClient());
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:surf_practice_chat_flutter/features/topics/domain/topic_bloc.dart';
import 'package:surf_practice_chat_flutter/services/shared_preferences_service.dart';
import 'package:surf_study_jam/surf_study_jam.dart';

import '../../models/chat_topic_send_dto.dart';
import '../../repository/chart_topics_repository.dart';

part 'create_chat_event.dart';

part 'create_chat_state.dart';

class CreateChatBloc extends Bloc<CreateChatEvent, CreateChatState> {
  CreateChatBloc() : super(CreateChatInitial()) {
    on<OnCreateChatTap>((event, emit) async {
        try {
      emit(CreateChatLoading());

      String token =
          await SharedPreferencesService().getUserTokenSharedPreferences() ??
              '';
      StudyJamClient client = StudyJamClient().getAuthorizedClient(token);

      ChatTopicsRepository chatTopicsRepository = ChatTopicsRepository(client);
      ChatTopicSendDto newTopic = ChatTopicSendDto(
        name: event.chatName,
        description: event.chatDescription,
      );
      await chatTopicsRepository.createTopic(newTopic);

      emit(CreateChatSuccess());
      } catch (e) {
        print(e);
        emit(CreateChatError());
      }
    });
  }
}
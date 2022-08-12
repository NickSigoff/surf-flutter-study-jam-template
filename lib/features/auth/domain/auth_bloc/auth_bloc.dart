import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:surf_practice_chat_flutter/features/auth/models/token_dto.dart';
import 'package:surf_practice_chat_flutter/features/topics/repository/chart_topics_repository.dart';
import 'package:surf_practice_chat_flutter/services/shared_preferences_service.dart';
import 'package:surf_study_jam/surf_study_jam.dart';

import '../../repository/auth_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<OnTapConfirmButtonAuthEvent>((event, emit) async {
      try {
        emit(AuthLoading());
        IAuthRepository repository = event.repository;
        TokenDto tokenDto = await repository.signIn(
            login: event.login, password: event.password);

        StudyJamClient client =
            StudyJamClient().getAuthorizedClient(tokenDto.token);

        ChatTopicsRepository chatTopicsRepository =
            ChatTopicsRepository(client);

        SjUserDto? user = await client.getUser();

        await SharedPreferencesService()
            .setUserNameSharedPreferences(user?.username ?? 'no user');

        await SharedPreferencesService()
            .setUserTokenSharedPreferences(tokenDto.token);

        emit(AuthSuccess(topicRepository: chatTopicsRepository));
      } catch (e) {
        print(e);
        emit(AuthError());
      }
    });

    on<OnPageCreated>((event, emit) async {
      try {
        emit(AuthLoading());

        String? token =
            await SharedPreferencesService().getUserTokenSharedPreferences();

        if (token == null) {
          emit(AuthInitial());
        } else {
          ChatTopicsRepository chatTopicsRepository =
              ChatTopicsRepository(StudyJamClient().getAuthorizedClient(token));

          emit(AuthSuccess(topicRepository: chatTopicsRepository));
        }
      } catch (e) {
        emit(AuthInitial());
      }
    });
  }
}

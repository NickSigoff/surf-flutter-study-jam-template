import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:surf_practice_chat_flutter/features/auth/models/token_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/repository/chat_repository.dart';
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

        ChatRepository chatRepository = ChatRepository(
            StudyJamClient().getAuthorizedClient(tokenDto.token));

        await SharedPreferencesService()
            .setUserTokenSharedPreferences(tokenDto.token);

        emit(AuthSuccess(chatRepository: chatRepository));
      } catch (e) {
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
          ChatRepository chatRepository =
              ChatRepository(StudyJamClient().getAuthorizedClient(token));
          emit(AuthSuccess(chatRepository: chatRepository));
        }
      } catch (e) {
        emit(AuthInitial());
      }
    });
  }
}

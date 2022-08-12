part of 'create_chat_bloc.dart';

@immutable
abstract class CreateChatEvent {}

class OnCreateChatTap extends CreateChatEvent {
  final String chatName;
  final String chatDescription;

  OnCreateChatTap({required this.chatName, required this.chatDescription});
}

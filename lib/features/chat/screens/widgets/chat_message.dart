import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_message_dto.dart';

import '../../../utils/main_colors.dart';

import 'avatar_widget.dart';

class ChatMessage extends StatelessWidget {
  final ChatMessageDto chatData;

  const ChatMessage({
    required this.chatData,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
              bottomRight: Radius.circular(16.0),
            ),
            color: MainColors.mainGreen.withAlpha(50),
          ),
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 4.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ChatAvatar(userData: chatData.chatUserDto),
              const SizedBox(width: 16),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chatData.chatUserDto.name ?? '',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      chatData.message ?? '',
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      chatData.createdDateTime.toString().substring(0, 19),
                      style: const TextStyle(fontSize: 10),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

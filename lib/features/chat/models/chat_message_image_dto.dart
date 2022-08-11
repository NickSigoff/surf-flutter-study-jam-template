import 'package:surf_practice_chat_flutter/features/chat/models/chat_user_dto.dart';
import 'package:surf_study_jam/surf_study_jam.dart';

import 'chat_image_dto.dart';
import 'chat_message_dto.dart';

class ChatMessageImageDto extends ChatMessageDto {
  final ChatImageDto imageUrl;

  ChatMessageImageDto({
    required ChatUserDto chatUserDto,
    required this.imageUrl,
    required String message,
    required DateTime createdDate,
  }) : super(
          chatUserDto: chatUserDto,
          message: message,
          createdDateTime: createdDate,
        );

  ChatMessageImageDto.fromSJClient({
    required SjMessageDto sjMessageDto,
    required SjUserDto sjUserDto,
  })  : imageUrl = ChatImageDto.fromImagesList(sjMessageDto.images!),
        super(
          createdDateTime: sjMessageDto.created,
          message: sjMessageDto.text,
          chatUserDto: ChatUserDto.fromSJClient(sjUserDto),
        );

  @override
  String toString() =>
      'ChatMessageImageDto(chatUserDto: $chatUserDto, message: $message, createdDate: $createdDateTime, image : $imageUrl)';
}

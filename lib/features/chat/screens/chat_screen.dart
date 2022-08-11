
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_message_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_message_location_dto.dart';

import 'package:surf_practice_chat_flutter/features/chat/repository/chat_repository.dart';

import 'package:surf_practice_chat_flutter/features/chat/screens/widgets/chat_message.dart';
import 'package:surf_practice_chat_flutter/features/chat/screens/widgets/location_message.dart';


import '../../utils/main_colors.dart';
import '../models/chat_geolocation_geolocation_dto.dart';

/// Main screen of chat app, containing messages.
class ChatScreen extends StatefulWidget {
  /// Repository for chat functionality.
  final IChatRepository chatRepository;

  /// Constructor for [ChatScreen].
  const ChatScreen({
    required this.chatRepository,
    Key? key,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}


class _ChatScreenState extends State<ChatScreen> {
  final _nameEditingController = TextEditingController();

  Iterable<ChatMessageDto> _currentMessages = [];

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: _ChatAppBar(
          controller: _nameEditingController,
          onUpdatePressed: _onUpdatePressed,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _ChatBody(
              messages: _currentMessages,
            ),
          ),
          _ChatTextField(
              onSendPressed: _onSendPressed, onMapPressed: _onMapPressed),
        ],
      ),
    );
  }

  Future<void> _onUpdatePressed() async {
    final messages = await widget.chatRepository.getMessages();
    setState(() {
      _currentMessages = messages;
    });
  }

  Future<void> _onSendPressed(String messageText) async {
    final messages = await widget.chatRepository.sendMessage(messageText);
    setState(() {
      _currentMessages = messages;
    });
  }

  Future<void> _onMapPressed(String messageText, double lon, double lat) async {
    final messages = await widget.chatRepository.sendGeolocationMessage(
        message: messageText,
        location: ChatGeolocationDto(longitude: lon, latitude: lat));
    setState(() {
      _currentMessages = messages;
    });
  }
}

class _ChatBody extends StatelessWidget {
  final Iterable<ChatMessageDto> messages;

  const _ChatBody({
    required this.messages,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: messages.length,
      itemBuilder: (_, index) {
        if (messages.elementAt(index) is ChatMessageGeolocationDto) {
          return LocationMessage(
              chatData: messages.elementAt(index) as ChatMessageGeolocationDto);
        } else {
          return ChatMessage(chatData: messages.elementAt(index));
        }
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 16);
      },
    );
  }
}

class _ChatTextField extends StatelessWidget {
  final ValueChanged<String> onSendPressed;
  final void Function(String, double, double) onMapPressed;

  final _textEditingController = TextEditingController();

  _ChatTextField({
    Key? key,
    required this.onSendPressed,
    required this.onMapPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.surface,
      elevation: 12,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: mediaQuery.padding.bottom + 8,
          left: 16,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _textEditingController,
                decoration: const InputDecoration(
                  hintText: 'Сообщение',
                ),
              ),
            ),
            IconButton(
              onPressed: () async {
                Position currentPosition = await _getCurrentLocation();
                onMapPressed(_textEditingController.text,
                    currentPosition.longitude, currentPosition.latitude);
              },
              icon: const Icon(Icons.map),
              color: colorScheme.onSurface,
            ),
            IconButton(
              onPressed: () => onSendPressed(_textEditingController.text),
              icon: const Icon(Icons.send),
              color: colorScheme.onSurface,
            ),
          ],
        ),
      ),
    );
  }

  Future<Position> _getCurrentLocation() async {
    await Permission.location.request();
    Position f = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    return f;
  }
}

class _ChatAppBar extends StatelessWidget {
  final VoidCallback onUpdatePressed;
  final TextEditingController controller;

  const _ChatAppBar({
    required this.onUpdatePressed,
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: MainColors.mainGreen,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: onUpdatePressed,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../map/screens/map_page.dart';
import '../../../utils/main_colors.dart';
import '../../models/chat_message_location_dto.dart';
import 'avatar_widget.dart';

class LocationMessage extends StatelessWidget {
  final ChatMessageGeolocationDto chatData;

  const LocationMessage({Key? key, required this.chatData}) : super(key: key);

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
                    RichText(
                      text: TextSpan(
                          text:
                          'Location is  longitude: ${chatData.location.longitude} latitude: ${chatData.location.latitude}\n',
                          style: const TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: 'Открыть на карте',
                              style: const TextStyle(
                                  color: MainColors.mainGreen),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => MapPage(
                                            location: chatData.location))),
                            )
                          ]),
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



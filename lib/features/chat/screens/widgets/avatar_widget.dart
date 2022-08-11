import 'package:flutter/material.dart';

import '../../../utils/main_colors.dart';
import '../../models/chat_user_dto.dart';

class ChatAvatar extends StatelessWidget {
  static const double _size = 42;

  final ChatUserDto userData;

  const ChatAvatar({
    required this.userData,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: _size,
      height: _size,
      child: Material(
        color: _selectColor(userData.name),
        shape: const CircleBorder(),
        child: Center(
          child: Text(
            userData.name != null
                ? userData.name!
                    .split(' ')
                    .first[0] //${userData.name!.split(' ').last[0]}'
                : '',
            style: TextStyle(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }

  Color _selectColor(String? name) {
    if (name == null) {
      return MainColors.mainGreen;
    } else {
      int sum = 0;
      for (int i = 1; i < userData.name!.length; i++) {
        sum += name.codeUnitAt(i);
        sum *= 13;
      }
      String sumString = sum.toString();
      return Color(int.parse("0xff${sumString.substring(0, 6)}"));
    }
  }
}

import 'package:flutter/material.dart';

import '../../utils/main_colors.dart';

/// Screen, that is used for creating new chat topics.
class CreateTopicScreen extends StatelessWidget {
  static final emailController = TextEditingController();
  static final passwordController = TextEditingController();

  /// Constructor for [CreateTopicScreen].
  const CreateTopicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MainColors.mainGreen,
        title: const Text('Создание нового топика'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
                labelText: 'Логин',
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide:
                        BorderSide(color: MainColors.mainGreen, width: 2.0)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.grey)),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: passwordController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock),
                labelText: 'Пароль',
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide:
                        BorderSide(color: MainColors.mainGreen, width: 2.0)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.grey)),
              ),
            ),
            const SizedBox(height: 16),
            _buildCreateChatButton()
          ],
        ),
      ),
    );
  }

  GestureDetector _buildCreateChatButton() {
    return GestureDetector(
      onTap: () {

      },
      child: Container(
        alignment: Alignment.center,
        height: 60,
        decoration: BoxDecoration(
          color: MainColors.mainGreen,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          'Создать чат',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_practice_chat_flutter/features/topics/domain/create_chat_bloc/create_chat_bloc.dart';

import '../../utils/main_colors.dart';

/// Screen, that is used for creating new chat topics.
class CreateTopicScreen extends StatelessWidget {
  static final chatNameController = TextEditingController();
  static final chatDescriptionController = TextEditingController();

  /// Constructor for [CreateTopicScreen].
  const CreateTopicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateChatBloc, CreateChatState>(
      listener: (context, state) {
        if (state is CreateChatSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Row(
                  children: const [
                    SizedBox(width: 16),
                    Text('Успешное создание топика'),
                  ],
                ),
                backgroundColor: Colors.green),
          );
          Navigator.of(context).pop();
        }

        if (state is CreateChatError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Row(
                  children: const [
                    SizedBox(width: 16),
                    Text('Топик не создан'),
                  ],
                ),
                backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
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
                _buildChatNameTextField(),
                const SizedBox(height: 16),
                _buildChatDescriptionTextField(),
                const SizedBox(height: 16),
                _buildCreateChatButton(context)
              ],
            ),
          ),
        );
      },
    );
  }

  TextField _buildChatDescriptionTextField() {
    return TextField(
      controller: chatDescriptionController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.description),
        labelText: 'Описание чата',
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: MainColors.mainGreen, width: 2.0)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Colors.grey)),
      ),
    );
  }

  TextField _buildChatNameTextField() {
    return TextField(
      controller: chatNameController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.chat_bubble),
        labelText: 'Название чата',
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: MainColors.mainGreen, width: 2.0)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Colors.grey)),
      ),
    );
  }

  GestureDetector _buildCreateChatButton(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<CreateChatBloc>().add(OnCreateChatTap(
          chatName: chatNameController.text.trim(),
          chatDescription: chatDescriptionController.text.trim())),
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

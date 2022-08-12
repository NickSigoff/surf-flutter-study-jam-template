import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_practice_chat_flutter/features/auth/domain/auth_bloc/auth_bloc.dart';
import 'package:surf_practice_chat_flutter/features/auth/repository/auth_repository.dart';
import 'package:surf_practice_chat_flutter/features/auth/screens/widgets/input_bloc_auth_screen.dart';
import 'package:surf_practice_chat_flutter/features/chat/screens/chat_screen.dart';
import 'package:surf_practice_chat_flutter/features/topics/screens/topics_screen.dart';

import '../../utils/main_colors.dart';

/// Screen for authorization process.
///
/// Contains [IAuthRepository] to do so.
class AuthScreen extends StatefulWidget {
  /// Repository for auth implementation.
  final IAuthRepository authRepository;

  /// Constructor for [AuthScreen].
  const AuthScreen({
    required this.authRepository,
    Key? key,
  }) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(OnPageCreated());
  }

  // TODO(task): Implement Auth screen.
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Row(
                  children: const [
                    Icon(Icons.warning, color: Colors.red),
                    SizedBox(width: 16),
                    Text('Error: Invalid login or password'),
                  ],
                ),
                backgroundColor: Colors.black),
          );
        }
        if (state is AuthSuccess) {
          Navigator.push<ChatScreen>(
            context,
            MaterialPageRoute(
              builder: (_) {
                return TopicsScreen(
                  chatTopicsRepository: state.topicRepository,
                );
              },
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const InputBlockAuthScreen(),
                const SizedBox(height: 16),
                _buildConfirmButton(state),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildConfirmButton(AuthState state) {
    return GestureDetector(
      onTap: () {
        context.read<AuthBloc>().add(OnTapConfirmButtonAuthEvent(
            repository: widget.authRepository,
            login: InputBlockAuthScreen.emailController.text.trim(),
            password: InputBlockAuthScreen.passwordController.text.trim()));
      },
      child: Container(
        alignment: Alignment.center,
        height: 60,
        decoration: BoxDecoration(
          color: MainColors.mainGreen,
          borderRadius: BorderRadius.circular(8),
        ),
        child: state is AuthLoading
            ? const Center(child: CircularProgressIndicator())
            : const Text(
                'Далее',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
      ),
    );
  }
}

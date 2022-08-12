import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_practice_chat_flutter/features/auth/domain/auth_bloc/auth_bloc.dart';
import 'package:surf_practice_chat_flutter/features/auth/repository/auth_repository.dart';
import 'package:surf_practice_chat_flutter/features/auth/screens/auth_screen.dart';
import 'package:surf_practice_chat_flutter/features/topics/domain/create_chat_bloc/create_chat_bloc.dart';
import 'package:surf_practice_chat_flutter/features/topics/domain/topic_bloc.dart';
import 'package:surf_study_jam/surf_study_jam.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

/// App,s main widget.
class MyApp extends StatelessWidget {
  /// Constructor for [MyApp].
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(create: (_) => TopicBloc()),
        BlocProvider(create: (_) => CreateChatBloc()),
      ],
      child: MaterialApp(
        home: AuthScreen(
          authRepository: AuthRepository(StudyJamClient()),
        ),
      ),
    );
  }
}

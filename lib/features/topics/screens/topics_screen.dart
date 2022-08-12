import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_practice_chat_flutter/features/chat/repository/chat_repository.dart';
import 'package:surf_practice_chat_flutter/features/topics/domain/topic_bloc.dart';
import 'package:surf_practice_chat_flutter/features/topics/screens/create_topic_screen.dart';
import 'package:surf_practice_chat_flutter/services/shared_preferences_service.dart';
import 'package:surf_study_jam/surf_study_jam.dart';

import '../../chat/screens/chat_screen.dart';
import '../../utils/main_colors.dart';
import '../repository/chart_topics_repository.dart';

/// Screen with different chat topics to go to.
class TopicsScreen extends StatefulWidget {
  final ChatTopicsRepository chatTopicsRepository;

  /// Constructor for [TopicsScreen].
  const TopicsScreen({Key? key, required this.chatTopicsRepository})
      : super(key: key);

  @override
  State<TopicsScreen> createState() => _TopicsScreenState();
}

class _TopicsScreenState extends State<TopicsScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<TopicBloc>()
        .add(OnPageCreated(chatTopicsRepository: widget.chatTopicsRepository));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TopicBloc, TopicState>(
      listener: (context, state) {
        if (state is TopicNavigateSuccess) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ChatScreen(
                    chatRepository: state.chatRepo,
                  )));
        }
        if (state is TopicInitial) {
          context.read<TopicBloc>().add(
              OnPageCreated(chatTopicsRepository: widget.chatTopicsRepository));
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: MainColors.mainGreen,
              title: Text(state is TopicSuccess ? state.userName ?? '' : ''),
              actions: [
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const CreateTopicScreen()));
                  },
                )
              ],
            ),
            body: state is TopicSuccess
                ? ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    itemCount: state.topicList.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        context.read<TopicBloc>().add(OnTapTopic(
                            chatId: state.topicList.elementAt(index).id));
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: MainColors.mainGreen.withAlpha(50),
                          child: Text(
                            '${state.topicList.elementAt(index).id}',
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                        title: Text('${state.topicList.elementAt(index).name}'),
                        subtitle: Text(
                            state.topicList.elementAt(index).description ?? ''),
                      ),
                    ),
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 8.0),
                  )
                : state is TopicLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : const Center(
                        child: Text('Error'),
                      ));
      },
    );
  }
}

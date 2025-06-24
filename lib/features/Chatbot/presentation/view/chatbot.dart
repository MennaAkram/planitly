import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/Chatbot/presentation/cubit/chatbot_cubit.dart';
import 'package:planitly/features/Chatbot/presentation/view/start_chat.dart';
import 'package:planitly/features/Chatbot/presentation/widgets/appbar.dart';
import 'package:planitly/features/Chatbot/presentation/widgets/chat_text_field.dart';
import 'package:planitly/features/Chatbot/presentation/widgets/message_component.dart';
import 'package:planitly/shared/assets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../app/di.dart';
import '../../../../shared/bases/base_state.dart';

class Chatbot extends StatefulWidget {
  const Chatbot({super.key});

  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  final ChatbotCubit _cubit = getIt.get<ChatbotCubit>();
  final TextEditingController massageController = TextEditingController();
  List<Map<String, dynamic>> _conversationTurns = [];
  GlobalKey<FormState> stateform = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  bool _startChat = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _cubit.getMessages().then((_) {
      final hasMessages = _cubit.conversation.isNotEmpty;
      setState(() {
        _startChat = hasMessages;
        _loading = false;
      });
      if (hasMessages) {
        _scrollToBottom();
      }
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
          0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _handleSend() async {
    final text = massageController.text.trim();
    if (text.isEmpty) return;

    _cubit.setUserMessage(text);
    massageController.clear();
    await _cubit.sendMessage(text);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        backgroundColor: Theme.of(context).appColors.white100,
        body: Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).appColors.primary,
          ),
        ),
      );
    }

    return _startChat
        ? _buildChatScreen()
        : StartChat(
            onStartChat: () {
              setState(() {
                _startChat = true;
              });
            },
          );
  }

  Widget _buildChatScreen() {
    return Scaffold(
      appBar: Appbar(),
      backgroundColor: Theme.of(context).appColors.white100,
      body: Column(
        children: [
          Expanded(
            flex: 10,
            child: BlocBuilder<ChatbotCubit, BaseState>(
              bloc: _cubit,
              builder: (context, state) {
                if (state is DoneState) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _scrollToBottom();
                  });
                }

                _conversationTurns = _cubit.conversation;
                return Stack(
                  children: [
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: Theme.of(context).appColors.white100,
                      child: FittedBox(
                          fit: BoxFit.cover,
                          child: SvgPicture.asset(Assets.background)),
                    ),
                    ListView.builder(
                      controller: _scrollController,
                      itemCount: _conversationTurns.length,
                      reverse: true,
                      itemBuilder: (context, index) {
                        final turn = _conversationTurns[index];
                        final userMessage = turn['user'];
                        final botMessage = turn['bot'];

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (userMessage != null)
                                MessageComponent(isUser: true, message: userMessage),
                              if (botMessage != null)
                                MessageComponent(isUser: false, message: botMessage),
                              if (botMessage == null && _cubit.lastFailedMessage != null && index == 0)
                                MessageComponent(
                                  isUser: false,
                                  isFailure: true,
                                  message: _cubit.lastFailedMessage!,
                                  onRetry: () {
                                    _cubit.sendMessage(_cubit.lastFailedMessage!);
                                  },
                                ),
                              if (index == 0 && _cubit.isBotTyping) ...[
                                MessageComponent(
                                  isUser: false,
                                  message: '', // Empty message to show only loading dots
                                  isLoading: true,
                                ),
                              ],
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
          ChatTextField(massageController: massageController, onSendMessage: _handleSend)
        ],
      ),
    );
  }
}
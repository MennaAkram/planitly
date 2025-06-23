import 'package:planitly/features/Chatbot/domain/repositories/chatbot_repo.dart';
import 'package:planitly/shared/bases/base_cubit.dart';
import 'package:planitly/shared/bases/base_state.dart';

class ChatbotCubit extends BaseCubit {
  final ChatbotRepository _chatRepo;

  ChatbotCubit(this._chatRepo) : super(const InitState());

  List<Map<String, String>> _conversationTurns = [];
  List<String> messages = [];
  String userMessage = '';
  String aiResponse = '';
  bool isLoading = false;
  List<Map<String, String>> get conversation => _conversationTurns;
  bool isBotTyping = false;

  void setUserMessage(String message) {
    _conversationTurns.insert(0, {'user': message});
    emit(DoneState());
  }

  String? _lastFailedMessage;

  String? get lastFailedMessage => _lastFailedMessage;

  Future<void> sendMessage(String message) async {
    isBotTyping = true;
    emit(DoneState());

    final userMessage = _conversationTurns.first['user'];
    final result = await _chatRepo.sendMessage(message: userMessage ?? "");

    result.fold(
          (failure) {
        _lastFailedMessage = userMessage;
        isBotTyping = false;
        emit(ErrorState(msg: failure.message));
      },
          (response) {
        _lastFailedMessage = null;
        _conversationTurns[0]['bot'] = response.message!;
        isBotTyping = false;
        emit(DoneState());
      },
    );
  }

  Future<void> getMessages() async {
    final result = await _chatRepo.getMessages();

    result.fold(
          (failure) => emit(ErrorState(msg:failure.message)),
          (messages) {
        _conversationTurns = messages
            .map((msg) => {
          'user': msg.messages?.last.userMessage ?? '',
          'bot': msg.messages?.last.aiResponse ?? '',
        })
            .toList();
        emit(DoneState());
      },
    );
  }

  clearMessages() {
    messages.clear();
    userMessage = '';
    aiResponse = '';
    emit(const DoneState());
  }

}

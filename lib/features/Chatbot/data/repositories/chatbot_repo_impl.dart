import 'package:dartz/dartz.dart';
import 'package:planitly/features/Chatbot/data/remote/user_messages_dto.dart';
import 'package:planitly/features/Chatbot/domain/entity/message_entity.dart';
import 'package:planitly/features/Chatbot/domain/entity/user_messages_entity.dart';
import 'package:planitly/shared/bases/base_repo.dart';
import 'package:planitly/shared/configs/endpoints.dart';
import 'package:planitly/shared/networking/failures.dart';
import '../../domain/repositories/chatbot_repo.dart';
import '../remote/message_dto.dart';

class ChatbotRepositoryImpl extends BaseRepository implements ChatbotRepository {

  ChatbotRepositoryImpl(super.dio);

  @override
  Future<Either<NetworkException, List<UserMessagesEntity>>> getMessages() async {
    return tryToExecute(
          () => dio.get(EndPoints.getUserMessages),
            (response) {
          final messagesList = response['messages'] as List;
          return messagesList
              .map((json) => UserMessagesDto().fromJson({'messages': [json]}).toEntity())
              .toList();
        }
    );
  }

  @override
  Future<Either<NetworkException, MessageEntity>> sendMessage({required String message}) {
    return tryToExecute(
      () => dio.post(EndPoints.chat, data: {'message': message}),
            (response) {
          return MessageDto().fromJson(response).toEntity();
        }
    );
  }

}

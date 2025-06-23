import 'package:dartz/dartz.dart';
import 'package:planitly/features/Chatbot/domain/entity/message_entity.dart';
import 'package:planitly/features/Chatbot/domain/entity/user_messages_entity.dart';
import '../../../../shared/networking/failures.dart';

abstract class ChatbotRepository {
  Future<Either<NetworkException, MessageEntity>> sendMessage(
      {required String message});

  Future<Either<NetworkException, List<UserMessagesEntity>>> getMessages();
}

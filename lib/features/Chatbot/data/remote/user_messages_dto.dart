import 'package:planitly/shared/bases/base_mapper.dart';
import '../../domain/entity/user_messages_entity.dart';

class UserMessagesDto extends BaseMapper<UserMessagesDto> {
    List<MessagesDto>? messages;

  UserMessagesDto({
     this.messages
  });

    @override
    UserMessagesDto fromJson(Map<String, dynamic> json) {
      final messagesList = json['messages'] as List<dynamic>? ?? [];
      messages = messagesList.map((e) => MessagesDto().fromJson(e)).toList();
      return this;
    }

  @override
  Map<String, dynamic> toJson(UserMessagesDto? object) {
    return {
      'messages': object?.messages?.map((e) => e.toJson(e)).toList(),
    };
  }

    UserMessagesEntity toEntity() {
      return UserMessagesEntity(
        messages: messages?.map((e) => e.toEntity()).toList() ?? [],
      );
    }
}

class MessagesDto extends BaseMapper<MessagesDto> {
  String? userMessage;
  String? aiResponse;
  String? createdAt;

  MessagesDto({this.userMessage, this.aiResponse, this.createdAt});

  @override
  MessagesDto fromJson(Map<String, dynamic> json) {
    return MessagesDto(
        userMessage: json['user_message'] as String,
        aiResponse: json['ai_response'] as String,
        createdAt: json['created_at'] as String
    );
  }

  @override
  Map<String, dynamic> toJson(MessagesDto object) {
    return {
      'user_message' : userMessage,
      'ai_response' : aiResponse,
      'created_at' : createdAt
    };
  }

  MessagesEntity toEntity() {
    return MessagesEntity(
        userMessage: userMessage,
        aiResponse: aiResponse,
        createdAt: createdAt
    );
  }
}


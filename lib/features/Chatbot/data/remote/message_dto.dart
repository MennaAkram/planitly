import 'package:planitly/features/Chatbot/domain/entity/message_entity.dart';
import 'package:planitly/shared/bases/base_mapper.dart';

class MessageDto extends BaseMapper<MessageDto> {
  String? message;

  MessageDto({
     this.message
  });

  @override
  MessageDto fromJson(Map<String, dynamic> json) {
    return MessageDto(
      message: json['message'] as String?
    );
  }

  @override
  Map<String, dynamic> toJson(MessageDto object) {
    return {
      'message' : message
    };
  }

  MessageEntity toEntity() {
    return MessageEntity(message: message);
  }
}


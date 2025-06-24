class UserMessagesEntity {
   List<MessagesEntity>? messages;

  UserMessagesEntity({this.messages});
}

class MessagesEntity {
   String? userMessage;
   String? aiResponse;
   String? createdAt;

  MessagesEntity({this.userMessage, this.aiResponse, this.createdAt});

}
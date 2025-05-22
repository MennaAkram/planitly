// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/shared/assets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Chatbot extends StatefulWidget {
  const Chatbot({super.key});

  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
 
  TextEditingController massagecontroler = TextEditingController();
   List<Map<String, dynamic>> _conversationTurns = [];
   GlobalKey<FormState> stateform = GlobalKey();
   ScrollController _scrollController = ScrollController(); 
   bool _isTyping = false;
  



void _sendMessage() {
  final text = massagecontroler.text.trim();
  if (text.isNotEmpty) {
    setState(() {
      _conversationTurns.add({'user': text, 'bot': '...'}); 
      massagecontroler.clear();
      _scrollToBottom();
    });

    // Simulate receiving a message after a short delay
    Future.delayed(const Duration(milliseconds: 1000), () {
      final botResponse = _getBotResponse(text);
      setState(() {
        if (_conversationTurns.isNotEmpty) {
          _conversationTurns.last['bot'] = botResponse; 
          _scrollToBottom();
        }
      });
    });
  }
}

  String _getBotResponse(String userMessage) {
    return "Hi how I can help you? ";
  }
  

    void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Wrap(children: [
          Container(height: 24,
          width: 24,
          margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: AssetImage(Assets.chatbot))),
            
          ),
          Text(
            "ChatBot",
            style: Theme.of(context).appTexts.bodyLarge,
          ),
        ]),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 10,
            child: Stack(
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
                  itemCount: _conversationTurns.length + (_isTyping ? 1 : 0),
                  itemBuilder: (context, index) {
                    final turn = _conversationTurns[index];
                    final userMessage = turn['user'];
                    final botMessage = turn['bot'];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (userMessage != null)
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              margin: const EdgeInsets.only(
                                  top: 4, bottom: 4, left: 50, right: 8),
                              decoration: BoxDecoration(
                                color: Theme.of(context).appColors.primary,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                    bottomLeft: Radius.circular(16)),
                              ),
                              child: Text(
                                userMessage,
                                style: TextStyle(
                                    color:
                                        Theme.of(context).appColors.white100),
                              ),
                            ),
                          ),
                        if (botMessage != null)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              margin: const EdgeInsets.only(
                                  top: 4, bottom: 4, left: 8, right: 50),
                              decoration: BoxDecoration(
                                color: Theme.of(context).appColors.black16,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                    bottomRight: Radius.circular(16)),
                              ),
                              child: Text(
                                botMessage,
                                style: TextStyle(
                                    color: Theme.of(context).appColors.black87),
                              ),
                            ),
                          ),
                        const SizedBox(height: 4),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    flex: 12,
                    child: Container(
                      height: 38,
                      width: double.maxFinite,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TextFormField(
                        minLines: 1,
                        controller: massagecontroler,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Theme.of(context).appColors.white100,
                          hintText: "send massage",
                          labelStyle: Theme.of(context)
                              .appTexts
                              .labelMedium
                              .copyWith(
                                  color: Theme.of(context).appColors.black37),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                                color: Theme.of(context).appColors.secondary,
                                width: 0.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                                color: Theme.of(context).appColors.secondary,
                                width: 0.5),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 6),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: IconButton(
                        onPressed: _sendMessage,
                        icon: SvgPicture.asset(Assets.sendicon)),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
    
  }
  
}
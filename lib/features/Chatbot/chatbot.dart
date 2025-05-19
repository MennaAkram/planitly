// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/shared/assests.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Chatbot extends StatefulWidget {
  const Chatbot({super.key});

  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  final ScrollController _scrollController = ScrollController();
  TextEditingController massagecontroler = TextEditingController();
  // ignore: prefer_final_fields
  List<Map<String, String>> _messages = [];
  GlobalKey<FormState> stateform = GlobalKey();

  void _sendMessage() {
    String text = massagecontroler.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _messages.add({"sender": "user", "text": text});
        _messages.add({"sender": "bot", "text": _getBotResponse(text)});
      });
      massagecontroler.clear();
    }
  }

  String _getBotResponse(String userMessage) {
    return "Hi how I can help you? ";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Wrap(children: [
                SvgPicture.asset(Assests.chatbot),
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
                              child: SvgPicture.asset(Assests.background)),
                        ),
                        ListView.builder(
                          controller: _scrollController,
                          itemCount: _messages.length,
                          itemBuilder: (context, index) {
                            var message = _messages[index];
                            return ListTile(
                              title: Align(
                                alignment: message['sender'] == 'user'
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: message['sender'] == 'user'
                                        ?Theme.of(context).appColors.primary
                                        : Theme.of(context).appColors.black16,
                                    borderRadius: message['sender'] == 'user'
                                        ? BorderRadius.only(
                                            topLeft: Radius.circular(16),
                                            topRight: Radius.circular(16),
                                            bottomLeft: Radius.circular(16))
                                        : BorderRadius.only(
                                            topLeft: Radius.circular(16),
                                            topRight: Radius.circular(16),
                                            bottomRight: Radius.circular(16)),
                                  ),
                                  child: Text(
                                    message['text']!,
                                    style: TextStyle(
                                      color: message['sender'] == 'user'
                                          ? Theme.of(context).appColors.white100
                                          : Theme.of(context).appColors.black87,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    )),

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
                                  margin:
                                       EdgeInsets.symmetric(vertical: 8),
                                  padding:
                                       EdgeInsets.symmetric(horizontal: 8),
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
                                            color: Theme.of(context)
                                                .appColors
                                                .black37,
                                          ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        borderSide: BorderSide(
                                            color: Theme.of(context)
                                                .appColors
                                                .secondary,
                                            width: 0.5),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        borderSide: BorderSide(
                                            color: Theme.of(context)
                                                .appColors
                                                .secondary,
                                            width: 0.5),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 6),
                                    ),
                                  ),),),
                          Expanded(
                            flex: 2,
                            child: IconButton(
                                onPressed: _sendMessage,
                                icon: SvgPicture.asset(Assests.sendicon)),
                          )
                        ],
                      )),
                )
              ],
            ));
  }
}

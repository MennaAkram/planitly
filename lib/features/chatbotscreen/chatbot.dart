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
    TextEditingController massagecontroler = TextEditingController();
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
    return  MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: 
             Wrap(children: [SvgPicture.asset(Assests.chatbot), Text("ChatBot",
            style: Theme.of(context).appTexts.bodyLarge,),]
          ),),
            body:  Column(
              children: [
                Expanded(flex: 10,child: Stack(children: [  Container(
            height: double.infinity,
            width: double.infinity,
            color: Theme.of(context).appColors.white100,
            child: FittedBox(
                fit: BoxFit.cover, child: SvgPicture.asset(Assests.background)),
          ),
          Container(child: ListView.builder(itemCount: _messages.length,
              itemBuilder: (context, index) {
                var message = _messages[index];
                return ListTile(
                  title: Align(
                    alignment: message['sender'] == 'user'
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                        color: message['sender'] == 'user'
                            ? Color(0xffFC5D00)
                            : Color(0xffD9D9D9),
                        borderRadius: message['sender'] == 'user'
                        ?BorderRadius.only(topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(16))
                        :BorderRadius.only(topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16)),
                      ),
                      child: Text(
                        message['text']!,
                        style: TextStyle(
                          color: message['sender'] == 'user'
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },),)],)),
                Expanded(flex: 1,child: Container(
        height: 50,
          child: Row(
        children: [
          Expanded(flex: 12,child: Container(
            height: 38,
              width: double.maxFinite,
               margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextFormField(
                minLines: 1,
                controller: massagecontroler,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xDDFFFFFF),
                  hintText: "send massage",
                  labelStyle: Theme.of(context).appTexts.bodyMedium.copyWith(
                        color: Theme.of(context).appColors.black37,
                      ),
                 
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  

 borderSide:
 
 
                        BorderSide(color: Theme.of(context).appColors.secondary, width: 0.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide:
                        BorderSide(color:Theme.of(context).appColors.secondary, width: 0.5),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 6),
                ),
              ))),
          Expanded(flex: 2,  child: IconButton(onPressed: _sendMessage, icon: SvgPicture.asset(Assests.sendicon)),)
        ],
      )),)
              ],
            )
    ));
  }
}

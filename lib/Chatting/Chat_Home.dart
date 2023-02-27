import 'package:everynue/Chatting/Chat_List.dart';
import 'package:flutter/material.dart';

class Chat_Home extends StatefulWidget {
  const Chat_Home({Key? key}) : super(key: key);

  @override
  State<Chat_Home> createState() => _Chat_HomeState();
}

class _Chat_HomeState extends State<Chat_Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.red[400],
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
                child: Center(
                  child: Text(
                    "채팅",
                    style: TextStyle(
                        color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(child: Chat_List()),
            ],
          ),
        ),
      ),
    );
  }
}

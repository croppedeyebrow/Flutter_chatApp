import "package:flutter/material.dart";

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const ChatBubble(
      {super.key, required this.isCurrentUser, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: isCurrentUser
              ? Color.fromARGB(255, 67, 37, 151)
              : Colors.greenAccent.shade400,
          borderRadius: BorderRadius.circular(18)),
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 24),
      child: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

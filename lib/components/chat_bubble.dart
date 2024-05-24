import "package:flutter/material.dart";
import "package:flutter_chapapp_firebase/themes/theme_provider.dart";
import "package:provider/provider.dart";

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const ChatBubble(
      {super.key, required this.isCurrentUser, required this.message});

  @override
  Widget build(BuildContext context) {
    //  라이트모드 vs 다크모드 색상 적용
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    return Container(
      decoration: BoxDecoration(
          color: isCurrentUser
              ? (isDarkMode
                  ? Colors.blueAccent.shade700
                  : Colors.blueAccent.shade400)
              : (isDarkMode
                  ? Colors.greenAccent.shade700
                  : Colors.greenAccent.shade200),
          borderRadius: BorderRadius.circular(18)),
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 24),
      child: Text(
        message,
        style: TextStyle(
            color: isCurrentUser
                ? Colors.white
                : (isDarkMode ? Colors.white : Colors.black)),
      ),
    );
  }
}

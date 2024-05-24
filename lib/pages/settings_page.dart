import "package:flutter/material.dart";
import "package:flutter_chapapp_firebase/themes/theme_provider.dart";
import "package:provider/provider.dart";

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text("설정"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.blueGrey,
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.all(26),
        padding: EdgeInsets.all(14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //dark mode
            Text("Dark Mode"),

            //전환 토글 버튼.
            Switch(
              value: Provider.of<ThemeProvider>(context).isDarkMode,
              onChanged: (bool value) {
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme();
                print("Switch toggled: $value"); // Switch 상태 변경 로그
              },
            )
          ],
        ),
      ),
    );
  }
}

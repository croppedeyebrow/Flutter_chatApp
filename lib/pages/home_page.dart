import "package:flutter/material.dart";
import "package:flutter_chapapp_firebase/auth/auth_service.dart";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void logout() {
    //로그아웃
    final _auth = AuthService();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Center(
          child: Text("Home"),
        ),
        actions: [IconButton(onPressed: logout, icon: Icon(Icons.logout))],
      ),
    );
  }
}

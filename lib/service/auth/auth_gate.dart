import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_chapapp_firebase/service/auth/login_or_register.dart";
import "package:flutter_chapapp_firebase/pages/home_page.dart";

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            //이미 로그인 된 상태.
            if (snapshot.hasData) {
              return HomePage();
            }

            //로그인 되어있지 않은 상태.
            else {
              return const LoginOrRegister();
            }
          },
        ));
  }
}

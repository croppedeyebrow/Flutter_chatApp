import "package:flutter/material.dart";
import "package:flutter_chapapp_firebase/pages/login_page.dart";
import "package:flutter_chapapp_firebase/pages/register_page.dart";

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  //처음, 로그인페이지
  bool showLoginPage = true;

  //로그인-회원가입 토글 페이지
  void togglePage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: togglePage);
    } else {
      return RegisterPage(onTap: togglePage);
    }
  }
}

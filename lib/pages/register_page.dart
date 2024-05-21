import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_chapapp_firebase/components/my_button.dart";
import "package:flutter_chapapp_firebase/components/my_textfield.dart";

class RegisterPage extends StatelessWidget {
  //이메일 및 패스워드 입력 컨트롤러
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _pwcomfirmController = TextEditingController();

  //회원가입 페이지 이동.
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  //회원가입메서드
  void register() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text('Register Page'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            // 여기에 햄버거 메뉴를 열기 위한 로직을 추가하세요.
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(Icons.message,
                size: 62, color: Theme.of(context).colorScheme.primary),

            SizedBox(
              height: 52,
            ),

            /// welcome back message
            Text(
              "Let's create an account for you",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w200,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            SizedBox(
              height: 52,
            ),

            /// email textfield
            MyTextField(
              hintText: "Email",
              obscureText: false,
              controller: _emailController,
            ),

            SizedBox(
              height: 12,
            ),

            /// pw textfield
            MyTextField(
              hintText: "password",
              obscureText: true,
              controller: _passwordController,
            ),

            SizedBox(
              height: 12,
            ),

            /// pw textfield
            MyTextField(
              hintText: "password 확인",
              obscureText: true,
              controller: _pwcomfirmController,
            ),

            SizedBox(
              height: 26,
            ),

            /// login button
            MyButton(text: "회원가입", onTap: register),

            SizedBox(
              height: 24,
            ),

            /// register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "이미 저희 가족이신가요?",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                SizedBox(
                  width: 4,
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "지금 로그인하세요",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

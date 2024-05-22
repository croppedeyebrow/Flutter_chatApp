import "dart:js";

import "package:flutter/material.dart";

import "package:flutter_chapapp_firebase/components/my_drawer.dart";
import "package:flutter_chapapp_firebase/components/user_tile.dart";
import "package:flutter_chapapp_firebase/service/auth/auth_service.dart";
import "package:flutter_chapapp_firebase/service/chat/chat_services.dart";

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // 채팅 & 인증 서비스
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      drawer: MyDrawer(),
      body: _buildUserLsit(),
    );
  }

  //build user list, 현재 로그인된 유저 빼고 리스트 만들기
  Widget _buildUserLsit() {
    return StreamBuilder(
      stream: _chatService.getUserStream(),
      builder: (context, snapshot) {
        //error
        if (snapshot.hasError) {
          return Text("Error");
        }

        //loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(
            color: Colors.blueAccent,
          );
        }

        //return list view
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserLsitItem)
              .toList(),
        );
      },
    );
  }

  //각 유저별 개별 리스트

  Widget _buildUserLsitItem(
      Map<String, dynamic> userData, BuildContext context) {
    //로그인한 유저 제외 전 유저
    return UserTile(
      text: userData["email"],
      onTap: () {
        //탭하면 채팅 페이지로.
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ChatPage()));
      },
    );
  }
}
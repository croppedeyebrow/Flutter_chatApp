import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:flutter_chapapp_firebase/components/chat_bubble.dart";
import "package:flutter_chapapp_firebase/components/my_textfield.dart";
import "package:flutter_chapapp_firebase/service/auth/auth_service.dart";
import "package:flutter_chapapp_firebase/service/chat/chat_services.dart";

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;

  ChatPage({super.key, required this.receiverEmail, required this.receiverID});

  //대화 컨트롤러
  final TextEditingController _messageConroller = TextEditingController();

  // 채팅 & 회원
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  // 메세지 보내기
  void sendMessage() async {
    //입력창 안에 내용이 있다면?
    if (_messageConroller.text.isNotEmpty) {
      //메세지를 보내기
      await _chatService.sendMessage(receiverID, _messageConroller.text);

      //채팅방 초기화.
      _messageConroller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverEmail),
      ),
      body: Column(
        children: [
          //메시지 출력하기.
          Expanded(
            child: _buildMessageList(),
          ),

          // 텍스트 입력
          _buildUserInput(),
        ],
      ),
    );
  }

  //메세지 리스트 만들기
  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(receiverID, senderID),
      builder: (context, snapshot) {
        //erros
        if (snapshot.hasError) {
          return const Text("에러");
        }

        //laoding
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("로딩중...");
        }
        //return list view
        return ListView(
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  //build messageitem
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    //현재 유저
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;
    //0523오류체크 : 변수명 조심. sender를 sneder라고 적어서 정렬 오류.

    //로그인한 유저의 메세지는 오른쪽, 아니면 왼쪽
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(isCurrentUser: isCurrentUser, message: data["message"])
        ],
      ),
    );
  }

  //메세지 입력
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 58.0),
      child: Row(
        children: [
          Expanded(
              child: MyTextField(
            controller: _messageConroller,
            hintText: "메세지 입력",
            obscureText: false,
          )),

          //전송 버튼
          Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 67, 37, 151),
                shape: BoxShape.circle),
            margin: EdgeInsets.only(right: 24),
            child: IconButton(
                onPressed: sendMessage,
                icon: const Icon(
                  Icons.arrow_upward_rounded,
                  color: Colors.white,
                )),
          )
        ],
      ),
    );
  }
}

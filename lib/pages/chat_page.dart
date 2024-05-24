import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:flutter_chapapp_firebase/components/chat_bubble.dart";
import "package:flutter_chapapp_firebase/components/my_textfield.dart";
import "package:flutter_chapapp_firebase/service/auth/auth_service.dart";
import "package:flutter_chapapp_firebase/service/chat/chat_services.dart";

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;

  ChatPage({super.key, required this.receiverEmail, required this.receiverID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  //대화 컨트롤러
  final TextEditingController _messageConroller = TextEditingController();

  // 채팅 & 회원
  final ChatService _chatService = ChatService();

  final AuthService _authService = AuthService();

  //메세지 입력창 고정.
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    //메세지 입력창이 따라가게 만들기.

    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
//      키보드가 표시될 시간을 갖도록 지연을 유발합니다
// 그러면 남은 공간의 양이 계산됩니다,
// 그 다음 스크롤을 아래로 내립니다
        Future.delayed(
          const Duration(microseconds: 500),
          () => scrollDown(),
        );
      }
    });

    // 목록 보기가 작성될 때까지 잠시 기다렸다가 아래로 스크롤합니다
    Future.delayed(
      const Duration(milliseconds: 500),
      () => scrollDown(),
    );
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _messageConroller.dispose();
    super.dispose();
  }

  //스크롤 컨트롤러
  final ScrollController _scrollController = ScrollController();
  void scrollDown() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  // 메세지 보내기
  void sendMessage() async {
    //입력창 안에 내용이 있다면?
    if (_messageConroller.text.isNotEmpty) {
      //메세지를 보내기
      await _chatService.sendMessage(widget.receiverID, _messageConroller.text);

      //채팅방 초기화.
      _messageConroller.clear();
    }

    //메세지 전송 후 스크롤 다운
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(widget.receiverEmail),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.blueGrey,
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
      stream: _chatService.getMessages(widget.receiverID, senderID),
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
          controller: _scrollController,
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
            focusNode: myFocusNode,
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

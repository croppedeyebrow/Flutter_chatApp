import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chapapp_firebase/models/message.dart';

class ChatService {
// 파이어스토어&회원 인스턴스 가져오기.
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

//유저 스트림 가져오기

  /* 

    List<Map<String, dynamic> = 
    [
       {
          'email; : test@gmail.com,
          'id' : ..
       },
       {
          'email; : eyelid@gmail.com,
          'id' : ..
       },
       ]
      
   

   */

  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        //각 개인별 유저
        final user = doc.data();

        //return user
        return user;
      }).toList();
    });
  }

//메세지 보내기
  Future<void> sendMessage(String receiverID, message) async {
    // 현재 유저 정보.
    final String currentUserID = _auth.currentUser!.uid;
    final String curreUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    //새로운 메세지
    Message newMessage = Message(
        senderID: currentUserID,
        senderEmail: curreUserEmail,
        receiverID: receiverID,
        message: message,
        timestamp: timestamp);

    //채팅방 개설[2명유저] 독립성 보장
    List<String> ids = [currentUserID, receiverID];
    ids.sort(); // ids를 분류(같은 채팅방의 2명의 유저 보장)
    String chatRoomID = ids.join('_');

    //새로운 메세지 DB에 저장.
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());
  }

//메세지 받기
  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    // 두 명의 유저를 위한 채팅방 ID 만들기

    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('-');

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}

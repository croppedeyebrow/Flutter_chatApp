import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
// 파이어스토어 인스턴스 가져오기.
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

//메세지 받기
}

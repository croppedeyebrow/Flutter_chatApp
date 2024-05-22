import "package:flutter/material.dart";
import "package:flutter_chapapp_firebase/service/auth/auth_service.dart";
import "package:flutter_chapapp_firebase/pages/settings_page.dart";

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    //로그아웃
    final _auth = AuthService();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //logo
          Column(
            children: [
              DrawerHeader(
                child: Center(
                    child: Icon(
                  Icons.message,
                  color: Theme.of(context).colorScheme.primary,
                  size: 40,
                )),
              ),

              //홈 리스트
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: Text("H O M E"),
                  leading: Icon(Icons.home),
                  onTap: () {
                    //사이드바 닫기
                    Navigator.pop(context);
                  },
                ),
              ),

              //설정
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: Text("설 정"),
                  leading: Icon(Icons.settings),
                  onTap: () {
                    //사이드바 닫기
                    Navigator.pop(context);

                    //설정 창 이동하기
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsPage()));
                  },
                ),
              ),
            ],
          ),

          //로그아웃
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              title: Text("로 그 아 웃"),
              leading: Icon(Icons.logout),
              onTap: logout,
            ),
          ),
        ],
      ),
    );
  }
}

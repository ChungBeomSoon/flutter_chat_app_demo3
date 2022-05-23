import 'package:chat_app_demo3/main.dart';
import 'package:chat_app_demo3/states/lib.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Chats extends StatefulWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chatState.refreshChatsForCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("chats").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Something went wrong"),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text("loading.."));
          }
          if (snapshot.hasData) {
            return CustomScrollView(
              slivers: [
                CupertinoSliverNavigationBar(
                  largeTitle: Text("Chats"),
                ),
                SliverList(
                    delegate: SliverChildListDelegate(
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return CupertinoListTile(
                    title: data['title'] == null
                        ? Text("대화를 시작해보세요")
                        : Text(data['title']),
                  );
                }).toList()))
              ],
            );
          }
          return Container();
        });
  }
}
//     return CustomScrollView(
//       slivers: [
//         CupertinoSliverNavigationBar(
//           largeTitle: Text("Chats"),
//         ),
//         SliverList(
//           delegate: SliverChildListDelegate(
//               chatState.messages.values.toList().map((data) {
//             return CupertinoListTile(
//               title: Text(data['friendName']),
//               subtitle: Text(data['msg']),
//               onTap: () => callChatDetailScreen(
//                 context, data['']
//               ),
//             );
//           }).toList()),
//         )
//       ],
//     );
//   }
// }

import 'package:chat_app_demo3/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Chats extends StatelessWidget {
  const Chats({Key? key}) : super(key: key);

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
//     CustomScrollView(
//       slivers: [
//         CupertinoSliverNavigationBar(
//           largeTitle: Text("Chats"),
//         ),
//         SliverList(
//             delegate: SliverChildListDelegate([
//           CupertinoListTile(
//             title: Text("Chat1"),
//           ),
//           CupertinoListTile(
//             title: Text("Chat2"),
//           ),
//           CupertinoListTile(
//             title: Text("Chat3"),
//           ),
//         ]))
//       ],
//     );
//   }
}

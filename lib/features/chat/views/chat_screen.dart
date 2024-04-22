import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ddnangcao_project/features/chat/views/chat_page.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String storeId;
  final String storeName;

  const ChatScreen({
    super.key,
    required this.storeId,
    required this.storeName,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Error"),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        return ListView(
          children:  snapshot.data?.docs
              .map<Widget>((e) => _buildUserListItem(e))
              .toList() ?? [],
        );
      },
    );
  }

  Widget _buildUserListItem(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic>? data = documentSnapshot.data() as Map<String, dynamic>?;


    //if (FirebaseAuth.instance.currentUser!.email != data['email']) {
    if (data?['uid'] == widget.storeId) {
      // print("Email la: ${FirebaseAuth.instance.currentUser!.email}");
      // print('data email: ${data?['email']}');
      return ListTile(
        title: Text("${data?['email']}"),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverUserEmail: data?['email'],
                receiverUserId: data?['uid'],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}

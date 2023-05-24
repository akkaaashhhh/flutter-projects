import 'package:chatapp/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    final authuser = FirebaseAuth.instance.currentUser!;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'time',
            descending: true,
          )
          .snapshots(),
      builder: (ctx, chatSnapshots) {
        if (chatSnapshots.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!chatSnapshots.hasData || chatSnapshots.data!.docs.isEmpty) {
          return const Center(
            child: Text('No messages found.'),
          );
        }
        if (chatSnapshots.hasError) {
          return const Center(
            child: Text('Something went wrong...'),
          );
        }
        final loadedmessage = chatSnapshots.data!.docs;
        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 40, left: 13, right: 13),
          reverse: true,
          itemCount: loadedmessage.length,
          itemBuilder: (ctx, index) {
            final chatmessage = loadedmessage[index].data();
            final nextchatmessage = index + 1 < loadedmessage.length
                ? loadedmessage[index + 1].data()
                : null;
            final currentuserid = chatmessage['userId'];
            final nextUserid =
                nextchatmessage != null ? nextchatmessage['userId'] : null;
            final sameUser = currentuserid == nextUserid;

            if (!sameUser) {
              return MessageBubble.next(
                  message: chatmessage['text'],
                  isMe: authuser.uid == currentuserid);
            } else {
              return MessageBubble.first(
                  userImage: chatmessage['userimage'],
                  username: chatmessage['username'],
                  message: chatmessage['text'],
                  isMe: authuser == currentuserid);
            }
          },
        );
      },
    );
  }
}

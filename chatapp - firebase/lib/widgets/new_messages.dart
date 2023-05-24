import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() {
    return _NewMessageState();
  }
}

class _NewMessageState extends State<NewMessage> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _submitmessage() async {
    final enteredMessage = _messageController.text;

    if (enteredMessage.trim().isEmpty) {
      return;
    }
    FocusScope.of(context).unfocus(); // closing keyboard
    _messageController.clear(); // clearing chatbox

    final user = FirebaseAuth.instance.currentUser!;

    final userfirestore =
        await FirebaseFirestore.instance.collection('user').doc(user.uid).get();

    FirebaseFirestore.instance.collection('chat').add({
      'text': enteredMessage,
      'time': Timestamp.now(),
      'userId': user.uid,
      'username': userfirestore.data()!['username'],
      'userimage': userfirestore.data()!['image_url'],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
      child: Row(children: [
        Expanded(
          child: TextField(
            controller: _messageController,
            textCapitalization: TextCapitalization.sentences,
            autocorrect: true,
            enableSuggestions: true,
            decoration: InputDecoration(label: Text('enter your message')),
          ),
        ),
        IconButton(
            color: Theme.of(context).colorScheme.primary,
            onPressed: _submitmessage,
            icon: const Icon(Icons.send))
      ]),
    );
  }
}

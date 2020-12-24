import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatBox extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('tinder chat'),
          actions: [
      DropdownButton(
      icon: Icon (
      Icons.more_vert,
          color: Colors.redAccent ),

      items: [
        DropdownMenuItem(
            child: Container(
                child: Row(
          children: <Widget>[
            Icon(Icons.exit_to_app),
            SizedBox(width: 8)
          ],
        ),
            ),
        ),
      ]),
    ],

    ),
    body: StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection('chat/dmGK9LYufKzcDE7WOWVQ/messages')
        .snapshots(),
    builder: (ctx, streamSnapshots){
    if(streamSnapshots.connectionState == ConnectionState.waiting){
    return Center(
    child: CircularProgressIndicator() ,
    );
    }
    final docs = streamSnapshots.data.docs;
    return ListView.builder(
    itemCount: docs.length,
    itemBuilder: (ctx, index)=> Container(
    padding: EdgeInsets.all(8),
    child: Text(docs[index]['text']),
    ),
    );
    },
    ),


    floatingActionButton: FloatingActionButton(
    child: Icon(Icons.add),
    onPressed:(){
    FirebaseFirestore.instance.
    collection('chat/dmGK9LYufKzcDE7WOWVQ/messages' )
        .add({'text': 'this was added by clicking the button!'});
    }),
    );
  }
}
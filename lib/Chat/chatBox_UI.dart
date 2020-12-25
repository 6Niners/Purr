import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ChatBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('tinder chat'),
        actions: [
          DropdownButton(
              icon: Icon(
                  Icons.more_vert,
                  color: Colors.redAccent),

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
        builder: (ctx, streamSnapshots) {
          if (streamSnapshots.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final docs = streamSnapshots.data.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (ctx, index) =>
                Container(
                  padding: EdgeInsets.all(8),
                  child: Text(docs[index]['text']),
                ),
          );
        },
      ),


      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            FirebaseFirestore.instance.
            collection('chat/dmGK9LYufKzcDE7WOWVQ/messages')
                .add({'text': 'this was added by clicking the button!'});
          }),
    );
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


class ChatBox1 extends StatelessWidget {
  buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white60,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.camera),
            iconSize: 25.0,
            color: Colors.redAccent,
            onPressed: () {},),
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: 25.0,
            color: Colors.redAccent,
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              onChanged: (Value) {},
              decoration: InputDecoration.collapsed(
                hintText: 'meow your message',
              ),

            ),),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: Colors.redAccent,
            onPressed: () {},
          ),
        ],
      ),
    );
  } //buildMessageComposer

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        backgroundColor: Colors.redAccent, //appBar color
        title: Text(
          'petName or userName',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: buildMessageComposer(),
      ),
    );
  } //widget
}//class ChatBox1

import 'package:flutter/material.dart';


class ChatBox1 extends StatelessWidget {
  buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white60,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: 25.0,
            color: Colors.redAccent,
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal, //appBar color
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
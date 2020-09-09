import 'package:flutter/material.dart';
import 'package:json_to_message/bottomAnimation.dart';
import 'package:json_to_message/photoView.dart';
import 'package:random_string/random_string.dart';

class Messages extends StatefulWidget {
  final String title;
  final List messages;
  final String userName;

  Messages({
    @required this.title,
    @required this.messages,
    @required this.userName,
  });
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        reverse: true,
        itemCount: widget.messages.length,
        itemBuilder: (context, index) {
          Map data = widget.messages[index];
          String messageId = randomAlphaNumeric(10);
          if (data["text"] != null) {
            return WidgetAnimator(
              MessageBubble(
                msgSender: data["sender"],
                msgText: data["text"],
                user: data["sender"] == widget.userName ? true : false,
              ),
            );
          } else if (data["media"] != null) {
            return WidgetAnimator(
              ImageBubble(
                msgSender: data["sender"],
                msgText: data["media"],
                user: data["sender"] == widget.userName ? true : false,
                messageId: messageId,
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String msgText;
  final String msgSender;
  final bool user;
  MessageBubble({this.msgText, this.msgSender, this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment:
            user ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              msgSender,
              style: TextStyle(
                  fontSize: 11, fontFamily: 'Poppins', color: Colors.black87),
            ),
          ),
          Material(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              topLeft: user ? Radius.circular(50) : Radius.circular(0),
              bottomRight: Radius.circular(50),
              topRight: user ? Radius.circular(0) : Radius.circular(50),
            ),
            color: user ? Colors.blue : Colors.white,
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                msgText,
                style: TextStyle(
                  color: user ? Colors.white : Colors.blue,
                  fontFamily: 'Poppins',
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ImageBubble extends StatelessWidget {
  final String msgText;
  final String msgSender;
  final bool user;
  final String messageId;
  ImageBubble({this.msgText, this.msgSender, this.user, this.messageId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment:
            user ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              msgSender,
              style: TextStyle(
                  fontSize: 11, fontFamily: 'Poppins', color: Colors.black87),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResimView(
                    msgText,
                    msgSender,
                    messageId,
                  ),
                ),
              );
            },
            child: Hero(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  topLeft: user ? Radius.circular(50) : Radius.circular(0),
                  bottomRight: Radius.circular(50),
                  topRight: user ? Radius.circular(0) : Radius.circular(50),
                ),
                child: Container(
                  color: user ? Colors.blue : Colors.white,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        topLeft:
                            user ? Radius.circular(50) : Radius.circular(0),
                        bottomRight: Radius.circular(50),
                        topRight:
                            user ? Radius.circular(0) : Radius.circular(50),
                      ),
                      child: FadeInImage.assetNetwork(
                        placeholder: "assets/loading.gif",
                        image: msgText,
                        fit: BoxFit.cover,
                        width: 200,
                        height: 200,
                      ),
                    ),
                  ),
                ),
              ),
              tag: messageId,
            ),
          ),
        ],
      ),
    );
  }
}

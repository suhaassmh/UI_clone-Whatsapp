import 'package:flutter/material.dart';

import '../model/chat.dart';

class ChatDetails extends StatefulWidget {
  final String name;
  final String profileImage;
  ChatDetails({this.name, this.profileImage});
  @override
  _ChatDetailsState createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails>
    with TickerProviderStateMixin {
  final TextEditingController _textController = new TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];
  bool isType = false;

  void _handleSubmit(String text) {
    ChatMessage message = new ChatMessage(
      text: text,
      animationController: new AnimationController(
          duration: new Duration(seconds: 0), vsync: this),
      name: widget.name,
    );
    setState(() {
      _messages.insert(0, message);
      var data = messageData.firstWhere((t) => t.name == widget.name);
      data.message = message.text;
    });
    message.animationController.forward();
  }

  Widget _buildText() {
    return new Container(
      child: new Row(
        children: <Widget>[
          new Container(
            child: new Flexible(
                child: new TextField(
              controller: _textController,
              decoration:
                  new InputDecoration.collapsed(hintText: "     message"),
            )),
          ),
          new Container(
            child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: () {
                  _handleSubmit(_textController.text);
                  _textController.clear();
                }),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.call),
            onPressed: () {},
          ),
          new IconButton(
            icon: new Icon(Icons.video_call),
            onPressed: () {},
          ),
          new IconButton(
            icon: new Icon(Icons.more_vert),
            onPressed: () {},
          )
        ],
        title: new Container(
            child: new Row(
          children: <Widget>[
            new Container(
              child: new Center(
                  child: CircleAvatar(
                backgroundImage: NetworkImage(widget.profileImage),
                maxRadius: 18,
              )),
            ),
            new Container(
              padding: const EdgeInsets.only(left: 5.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Center(
                    child: new Text(
                      widget.name,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  new Text(
                    "online",
                    style: new TextStyle(
                      fontSize: 13.0,
                      color: Colors.white,
                      // fontStyle: FontStyle.italic
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            new Flexible(
              child: new ListView.builder(
                reverse: true,
                itemBuilder: (context, int index) => _messages[index],
                itemCount: _messages.length,
              ),
            ),
            new Divider(
              height: 1.0,
            ),
            new Container(
              child: _buildText(),
            )
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String name;
  final AnimationController animationController;
  final String text;
  ChatMessage({this.name, this.animationController, this.text});

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: new CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOut,
      ),
      child: new Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: new CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbdx3J1USJR3F1zCYk6gE8kHaZY1HAXpfNkveKdTWCsqcC5YI&s"),
                maxRadius: 20.0,
              ),
            ),
            new Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text("Me",
                      style: new TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold)),
                  new Container(
                      margin: const EdgeInsets.only(top: 6.0),
                      child: new Text(text,
                          style: new TextStyle(
                              color: Colors.black, fontSize: 18.0)))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';


class InviteFriendPage extends StatefulWidget {
  @override
  _InviteFriendPageState createState() => _InviteFriendPageState();
}

class _InviteFriendPageState extends State<InviteFriendPage> {
  final _textController = TextEditingController();
  String defaultLink = "https://www.example.com/download";
  String _copyStatus = "";

  @override
  void initState() {
    super.initState();
    _textController.text = defaultLink;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(28, 27, 27, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(28, 27, 27, 1),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'images/binario1.png',
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 16),
            Container(
  child: Image.asset('images/invite.png',
  height: 50,
  
  )
),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Share the following link with your friends to download the app:", style: TextStyle(color: Colors.grey[300], fontSize: 18)),
            SizedBox(height: 8.0),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF993A84),
                borderRadius: BorderRadius.circular(8.0)
              ),
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: _textController,
                style: TextStyle(color: Colors.grey[300], fontSize: 18),
                decoration: const InputDecoration(
                  border: InputBorder.none,),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: defaultLink));
                    setState(() {
                      _copyStatus = "Link copied to clipboard";
                      });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(_copyStatus),
                        duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    child: Text("COPY", style: TextStyle(color: Color(0xFF993A84))),
                ),
              SizedBox(width: 8.0),
              TextButton(
                onPressed: () {
                  Share.share(defaultLink);
                  },
                child: Text("SHARE", style: TextStyle(color: Color(0xFF993A84))),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_media/screens/home_screen.dart';
import 'package:social_media/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AddPost extends StatefulWidget {
  AddPost({Key key}) : super(key: key);

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  TextEditingController textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(4)),
            TextField(
              controller: textController,
              maxLines: 5,
              decoration: InputDecoration(
                  labelText: "Text", border: OutlineInputBorder()),
            ),
            Padding(padding: EdgeInsets.all(4)),
            IconButton(
                onPressed: () {},
                icon: FaIcon(
                  Icons.image,
                  size: 45,
                )),
            Padding(padding: EdgeInsets.all(4)),
            Container(
                width: double.infinity,
                child: RaisedButton.icon(
                  icon: FaIcon(FontAwesomeIcons.cloudUploadAlt),
                  label: Text("Post"),
                  onPressed: () {
                    uploadPost();
                  },
                )),
          ],
        ),
      ),
    );
  }

  Future<void> uploadPost() async {
   // print(jsonData['verified']);
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
    var response = await http.post(
      "${baseURL}/post",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'text': textController.text,
        'username': jsonData['name'],
        'userId': jsonData['_id'],
        'date': formattedDate,
        'userVerified': jsonData['verified']
      }),
    );
    var jsonDataa = jsonDecode(response.body);
    print(jsonDataa);
    mycurrentIndex = 0;
    appTitle = "Home";
    setState(() {});
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}

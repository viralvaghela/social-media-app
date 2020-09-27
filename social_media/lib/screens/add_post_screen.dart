import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_media/utilities/constants.dart';

class AddPost extends StatefulWidget {
  AddPost({Key key}) : super(key: key);

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(4)),
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                  labelText: "Text", border: OutlineInputBorder()),
            ),
            Padding(padding: EdgeInsets.all(4)),
            jsonData['img'] == null
                ? Image.network("https://blog.hubspot.com/hubfs/image8-2.jpg")
                : CircularProgressIndicator(),
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
                  onPressed: () {},
                )),
          ],
        ),
      ),
    );
  }
}

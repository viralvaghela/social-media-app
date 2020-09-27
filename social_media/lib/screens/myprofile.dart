import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_media/utilities/constants.dart';

class MyProfile extends StatefulWidget {
  MyProfile({Key key}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(top: 5)),
          CircleAvatar(maxRadius: 50),
          Container(
            padding: EdgeInsets.all(5),
            height: MediaQuery.of(context).size.height * 0.25,
            child: Card(
              child: Column(
                children: [
                  jsonData['name'] == "coding boy"
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              jsonData['name'],
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Padding(padding: EdgeInsets.all(5)),
                            Icon(Icons.verified, color: Colors.blue, size: 20)
                          ],
                        )
                      : Text(jsonData['name']),

                  //Social Icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          icon: FaIcon(FontAwesomeIcons.githubAlt),
                          onPressed: () {}),
                      IconButton(
                          icon: FaIcon(FontAwesomeIcons.linkedinIn),
                          onPressed: () {}),
                      IconButton(
                          icon: FaIcon(FontAwesomeIcons.stackOverflow),
                          onPressed: () {}),
                      IconButton(
                          icon: FaIcon(FontAwesomeIcons.facebookF),
                          onPressed: () {}),
                      IconButton(
                          icon: FaIcon(FontAwesomeIcons.twitter),
                          onPressed: () {}),
                      IconButton(
                          icon: FaIcon(FontAwesomeIcons.blogger),
                          onPressed: () {}),
                    ],
                  ),
                  //website
                  InkWell(
                    child: Text("www.google.com"),
                    onTap: () {
                      print("Clicked");
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FlatButton.icon(
                        onPressed: () {},
                        icon: FaIcon(FontAwesomeIcons.solidEdit),
                        label: Text("Edit"),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/screens/edit_profile.dart';
import 'package:social_media/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:social_media/widgets/getUserName.dart';
import 'package:url_launcher/url_launcher.dart';

class MyProfile extends StatefulWidget {
  MyProfile({Key key}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var response = await http.get("${baseURL + "/user/" + jsonData['_id']}");

    setState(() {
      jsonData = jsonDecode(response.body);
      isLoading = false;
      print(jsonData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [GetUserName()]),
                        //Social Icons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            jsonData['github'] == ""
                                ? Container()
                                : IconButton(
                                    icon: FaIcon(FontAwesomeIcons.githubAlt),
                                    onPressed: () {
                                      launchWeb(jsonData['github']);
                                    }),
                            jsonData['linkedin'] == ""
                                ? Container()
                                : IconButton(
                                    icon: FaIcon(FontAwesomeIcons.linkedinIn),
                                    onPressed: () {
                                      launchWeb(jsonData['linkedin']);
                                    }),
                            jsonData['stackoverflow'] == ""
                                ? Container()
                                : IconButton(
                                    icon:
                                        FaIcon(FontAwesomeIcons.stackOverflow),
                                    onPressed: () {
                                      launchWeb(jsonData['stackoverflow']);
                                    }),
                            jsonData['facebook'] == ""
                                ? Container()
                                : IconButton(
                                    icon: FaIcon(FontAwesomeIcons.facebookF),
                                    onPressed: () {
                                      launchWeb(jsonData['facebook']);
                                    }),
                            jsonData['twitter'] == ""
                                ? Container()
                                : IconButton(
                                    icon: FaIcon(FontAwesomeIcons.twitter),
                                    onPressed: () {
                                      launchWeb(jsonData['twitter']);
                                    }),
                            jsonData['blog'] == ""
                                ? Container()
                                : IconButton(
                                    icon: FaIcon(FontAwesomeIcons.blogger),
                                    onPressed: () {
                                      launchWeb(jsonData['blog']);
                                    }),
                          ],
                        ),
                        //website
                        InkWell(
                          child: jsonData['website'] == ""
                              ? Container()
                              : Text(jsonData['website']),
                          onTap: () {
                            launchWeb(jsonData['blog']);
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FlatButton.icon(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => EditProfile()));
                              },
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

  launchWeb(var url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

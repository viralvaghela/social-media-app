import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_media/screens/edit_profile.dart';
import 'package:social_media/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class FriendProfile extends StatefulWidget {
  var userId;
  FriendProfile(this.userId, {Key key}) : super(key: key);
  @override
  _FriendProfileState createState() => _FriendProfileState();
}

class _FriendProfileState extends State<FriendProfile> {
  bool isLoading = true;
  var friendData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  void getUserData() async {
    var response = await http.get("${baseURL}/user/${widget.userId}");
    friendData = await jsonDecode(response.body);
    isLoading = false;
    setState(() {});
    print(friendData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: isLoading == false ? Text(friendData['name']) : Text(" ")),
      body: isLoading == false
          ? SingleChildScrollView(
              child: Container(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(top: 5)),
                  Hero(tag: "profile", child: CircleAvatar(maxRadius: 50)),
                  Container(
                    padding: EdgeInsets.all(5),
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: Card(
                      child: Column(
                        children: [
                          friendData['name'] == "coding boy"
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      friendData['name'],
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.all(5)),
                                    Icon(Icons.verified,
                                        color: Colors.blue, size: 20)
                                  ],
                                )
                              : Text(friendData['name']),

                          //Social Icons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              friendData['github'] == ""
                                  ? Container()
                                  : IconButton(
                                      icon: FaIcon(FontAwesomeIcons.githubAlt),
                                      onPressed: () {
                                        launchWeb(friendData['github']);
                                      }),
                              friendData['linkedin'] == ""
                                  ? Container()
                                  : IconButton(
                                      icon: FaIcon(FontAwesomeIcons.linkedinIn),
                                      onPressed: () {
                                        launchWeb(friendData['linkedin']);
                                      }),
                              friendData['stackoverflow'] == ""
                                  ? Container()
                                  : IconButton(
                                      icon: FaIcon(
                                          FontAwesomeIcons.stackOverflow),
                                      onPressed: () {
                                        launchWeb(friendData['stackoverflow']);
                                      }),
                              friendData['facebook'] == ""
                                  ? Container()
                                  : IconButton(
                                      icon: FaIcon(FontAwesomeIcons.facebookF),
                                      onPressed: () {
                                        launchWeb(friendData['facebook']);
                                      }),
                              friendData['twitter'] == ""
                                  ? Container()
                                  : IconButton(
                                      icon: FaIcon(FontAwesomeIcons.twitter),
                                      onPressed: () {
                                        launchWeb(friendData['twitter']);
                                      }),
                              friendData['blog'] == ""
                                  ? Container()
                                  : IconButton(
                                      icon: FaIcon(FontAwesomeIcons.blogger),
                                      onPressed: () {
                                        launchWeb(friendData['blog']);
                                      }),
                            ],
                          ),
                          //website
                          InkWell(
                            child: friendData['website'] == ""
                                ? Container()
                                : Text(friendData['website']),
                            onTap: () {
                              launchWeb(friendData['website']);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
            )
          : Center(child: CircularProgressIndicator()),
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

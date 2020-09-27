import 'package:flutter/material.dart';
import 'package:social_media/utilities/constants.dart';

class MyProfile extends StatefulWidget {
  MyProfile({Key key}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Profile")),
    );
  }
}

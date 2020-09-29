import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/screens/home_screen.dart';
import 'package:social_media/utilities/constants.dart';
import 'package:http/http.dart' as http;

class EditProfile extends StatefulWidget {
  EditProfile({Key key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController username =
      TextEditingController(text: jsonData['name']);
  TextEditingController github =
      TextEditingController(text: jsonData['github']);
  TextEditingController linkedin =
      TextEditingController(text: jsonData['linkedin']);
  TextEditingController stackoverflow =
      TextEditingController(text: jsonData['stackoverflow']);
  TextEditingController facebook =
      TextEditingController(text: jsonData['facebook']);
  TextEditingController twitter =
      TextEditingController(text: jsonData['twitter']);
  TextEditingController blog = TextEditingController(text: jsonData['blog']);
  TextEditingController website =
      TextEditingController(text: jsonData['website']);

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        actions: [
          IconButton(
              icon: Icon(FontAwesomeIcons.check),
              onPressed: () {
                updateUser();
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              InkWell(onTap: () {}, child: CircleAvatar(maxRadius: 50)),
              SizedBox(height: 5),
              TextField(
                controller: username,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    suffixIcon: Icon(FontAwesomeIcons.userCog),
                    labelText: "UserName"),
                keyboardType: TextInputType.url,
              ),
              SizedBox(height: 5),
              TextField(
                controller: github,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    suffixIcon: Icon(FontAwesomeIcons.github),
                    labelText: "Github"),
                keyboardType: TextInputType.url,
              ),
              SizedBox(height: 5),
              TextField(
                controller: linkedin,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    suffixIcon: Icon(FontAwesomeIcons.linkedinIn),
                    labelText: "LinkedIn"),
                keyboardType: TextInputType.url,
              ),
              SizedBox(height: 5),
              TextField(
                controller: stackoverflow,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    suffixIcon: Icon(FontAwesomeIcons.stackOverflow),
                    labelText: "Stackoverflow"),
                keyboardType: TextInputType.url,
              ),
              SizedBox(height: 5),
              TextField(
                controller: facebook,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    suffixIcon: Icon(FontAwesomeIcons.facebookF),
                    labelText: "Facebook"),
                keyboardType: TextInputType.url,
              ),
              SizedBox(height: 5),
              TextField(
                controller: twitter,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    suffixIcon: Icon(FontAwesomeIcons.twitter),
                    labelText: "Twitter"),
                keyboardType: TextInputType.url,
              ),
              SizedBox(height: 5),
              TextField(
                controller: blog,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    suffixIcon: Icon(FontAwesomeIcons.bloggerB),
                    labelText: "Blog"),
                keyboardType: TextInputType.url,
              ),
              SizedBox(height: 5),
              TextField(
                controller: website,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    suffixIcon: Icon(FontAwesomeIcons.userAlt),
                    labelText: "Portfolio"),
                keyboardType: TextInputType.url,
              ),
              SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }

  updateUser() async {
    var response = await http.patch(
      "${baseURL}/user/${jsonData['_id']}",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': username.text,
        'github': github.text,
        'linkedin': linkedin.text,
        'stackoverflow': stackoverflow.text,
        'facebook': facebook.text,
        'twitter': twitter.text,
        'blog': blog.text,
        'website': website.text
      }),
    );
    jsonData = jsonDecode(response.body);
    getUserData();
    mycurrentIndex = 2;
    setState(() {});
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => HomeScreen()));

    // print(jsonData['github']);
  }

  void getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var response = await http.get("${baseURL + "/user/" + jsonData['_id']}");
    //var response = await http.get("${baseURL}/user/${jsonData[]}");
    setState(() {
      jsonData = jsonDecode(response.body);
    });
  }
}

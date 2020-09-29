import 'dart:convert';

import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_media/screens/friend_profile.dart';
import 'package:social_media/screens/home_screen.dart';
import 'package:social_media/screens/myprofile.dart';
import 'package:social_media/utilities/constants.dart';
import 'package:http/http.dart' as http;

class MyHome extends StatefulWidget {
  MyHome({Key key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
} //dont click anywhere it will crash

//size after installation is 150MB are u there?
//wait 2 min

class _MyHomeState extends State<MyHome> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    getAllPosts();
  }

  Future<void> getAllPosts() async {
    var response = await http.get("${baseURL + "/" + "post"}");

    setState(() {
      postData = jsonDecode(response.body);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isLoading != true
          ? SingleChildScrollView(
              child: Column(
                children: postData.map((item) {
                  return InkWell(
                    onTap: () {
                      print(postData);
                    },
                    child: Wrap(children: [
                      Card(
                        child: Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                onTap: () {
                                  openFriendProfile(item['userId']);
                                },
                                leading: InkWell(
                                    onTap: () {
                                      openFriendProfile(item['userId']);
                                    },
                                    child: CircleAvatar()),
                                title: item['userVerified'] == "true"
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            item['userName'],
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                          Padding(padding: EdgeInsets.all(5)),
                                          Icon(Icons.verified,
                                              color: Colors.blue, size: 20)
                                        ],
                                      )
                                    : Text(
                                        item['userName'],
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                subtitle: Text(item['date']),
                                trailing: item['userId'] == jsonData['_id']
                                    ? IconButton(
                                        tooltip: "Delete Post",
                                        icon: Icon(
                                          FontAwesomeIcons.ellipsisV,
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          //   deletePost(item['userId']);
                                         _modalBottomSheetMenu();
                                        })
                                    : Text(""),
                              ),
                              Text(
                                "${item['text']}",
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  );
                }).toList(),
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  Future<void> deletePost(var id) async {
    var response = await http.delete(
      "${baseURL}/post/$id",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    var jsonDataa = jsonDecode(response.body);
    print(jsonDataa);

    mycurrentIndex = 0;
    appTitle = "Home";
    getAllPosts();

    setState(() {});
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  void openFriendProfile(var id) {
    if (id == jsonData['_id']) {
      //print(id);
      mycurrentIndex = 2;
      appTitle = "Profile";
      setState(() {});
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => FriendProfile(id)));
    }
  }

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            height: 50.0,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: new Container(
                decoration: new BoxDecoration(
                    color:Colors.transparent,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(20.0),
                        topRight: const Radius.circular(20.0))),
                child: new Center(
                  child: new Text("This is a modal sheet"),
                )),
          );
        });
  }
}

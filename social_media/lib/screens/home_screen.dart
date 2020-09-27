import 'dart:convert';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:social_media/utilities/constants.dart';
import 'package:social_media/widgets/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    print(isLoading);
    getUserData();
  }

  void getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var response =
        await http.get("${baseURL + "/" + pref.getString('userToken')}");

    setState(() {
      jsonData = jsonDecode(response.body);
      isLoading = false;
      print(jsonData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: isLoading == true
          ? Scaffold(body: Center(child: CircularProgressIndicator()))
          : Scaffold(
              appBar: AppBar(
                title: Text(appTitle),
                actions: [
                  Padding(
                      padding: EdgeInsets.all(2),
                      child: IconButton(
                          icon: Icon(
                            Icons.search,
                          ),
                          onPressed: () {})),
                  Padding(
                      padding: EdgeInsets.all(2),
                      child: IconButton(
                          icon: Icon(
                            Icons.notifications,
                          ),
                          onPressed: () {})),
                ],
              ),
              body: tabs[mycurrentIndex],
              drawer: MyDrawer(),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: mycurrentIndex,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      title: Text("Home"),
                      backgroundColor: Colors.black),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.add),
                      title: Text("Add"),
                      backgroundColor: Colors.black),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.account_circle_rounded),
                      title: Text("Profile"),
                      backgroundColor: Colors.black),
                ],
                onTap: (index) {
                  if (index == 0) appTitle = "Home";
                  if (index == 2) appTitle = "Profile";
                  mycurrentIndex = index;
                  setState(() {});
                  print("current index:$mycurrentIndex");
                },
              ),
              // floatingActionButton: FloatingActionButton(
              //   child: Icon(Icons.verified),
              //   onPressed: () async {
              //     changeTheme();
              //   },
              // ),
            ),
    );
  }

  void changeTheme() {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }
}

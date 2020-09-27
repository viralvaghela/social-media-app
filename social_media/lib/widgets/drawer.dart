import 'dart:ui';

import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:dynamic_theme/theme_switcher_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/screens/login_screen.dart';
import 'package:social_media/utilities/constants.dart';

class MyDrawer extends StatelessWidget {
  bool localbool;
  SharedPreferences pref;

  brightnessChanger() async {
    pref = await SharedPreferences.getInstance();

    pref.getBool("status") == true
        ? pref.setBool("status", false)
        : pref.setBool("status", true);
    localbool = pref.getBool("status");
  }

  @override
  Widget build(BuildContext context) {
    void showChooser() {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return BrightnessSwitcherDialog(
            onSelectedTheme: (Brightness brightness) {
              DynamicTheme.of(context).setBrightness(brightness);
            },
          );
        },
      );
    }

    brightnessChanger();
    return Drawer(
      // column holds all the widgets in the drawer
      child: Column(
        children: <Widget>[
          Expanded(
            // ListView contains a group of widgets that scroll inside the drawer
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                    accountName: jsonData['name'] != null
                        ? jsonData['name'] == "coding boy"
                            ? Row(
                                children: [
                                  Text(
                                    jsonData['name'],
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Padding(padding: EdgeInsets.all(5)),
                                  Icon(
                                    Icons.verified,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ],
                              )
                            : Text(jsonData['name'])
                        : Text(" "),
                    accountEmail: jsonData['email'] != null
                        ? Text(jsonData['email'])
                        : Text(" "),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text("C"),
                    )),
                ListTile(
                    leading: FaIcon(FontAwesomeIcons.adjust),
                    title: Text('Dark mode'),
                    onTap: () => showChooser()),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.comments),
                  title: Text('Help and Feedback'),
                  onTap: () {},
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.shareSquare),
                  title: Text('Share'),
                  onTap: () {},
                )
              ],
            ),
          ),
          // This container holds the align
          Container(
            // This align moves the children to the bottom
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              // This container holds all the children that will be aligned
              // on the bottom and should not scroll with the above ListView
              child: Container(
                child: Column(
                  children: <Widget>[
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.logout),
                      title: Text('Logout'),
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('userToken', null);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => LoginScreen()));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

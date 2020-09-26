import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:dynamic_theme/theme_switcher_widgets.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/screens/login_screen.dart';
import 'package:social_media/utilities/constants.dart';

class MyDrawer extends StatelessWidget {
  bool localbool;
  SharedPreferences pref;

  brightnessChanger() async {
    pref = await SharedPreferences.getInstance();

    // pref.getBool("status") == null ?? pref.setBool("status", true);

    pref.getBool("status") == true
        ? pref.setBool("status", false)
        : pref.setBool("status", true);
    localbool = pref.getBool("status");
    print(pref.getBool("status"));
  }

  @override
  Widget build(BuildContext context) {
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
                        ? Text(jsonData['name'])
                        : Text(" "),
                    accountEmail: jsonData['email'] != null
                        ? Text(jsonData['email'])
                        : Text(" "),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text("A"),
                    )),
                ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text("Profile"),
                ),
                ListTile(
                    leading: Icon(Icons.settings), title: Text('Settings')),
                ListTile(
                    leading: Icon(Icons.help),
                    title: Text('Help and Feedback')),
                Switch(
                  activeColor: Colors.pinkAccent,
                  value: pref.getBool("status"),
                  onChanged: (value) {
                    print("VALUE : $value");

                    DynamicTheme.of(context).setBrightness(
                        Theme.of(context).brightness == Brightness.dark
                            ? Brightness.light
                            : Brightness.dark);
                    brightnessChanger();
                  },
                ),
                // showChooser(),
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

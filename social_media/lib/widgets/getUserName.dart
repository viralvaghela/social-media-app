import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:social_media/utilities/constants.dart';

class GetUserName extends StatelessWidget {
  const GetUserName({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: jsonData['name'] != null
          ? jsonData['verified'] == "true"
              ? Row(
                  children: [
                    Text(
                      jsonData['name'],
                      style: TextStyle( //if name is codingboy then blue tick 
                        fontSize: 18,
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(5)),
                    Icon(
                      Icons.verified,
                      color:
                          DynamicTheme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.blue,
                      size: 20,
                    ),
                  ],
                )
              : Text(
                  jsonData['name'], //else no tick
                  style: TextStyle(
                    fontSize: 18,
                  ),
                )
          : Text(" "),
    );
  }
}

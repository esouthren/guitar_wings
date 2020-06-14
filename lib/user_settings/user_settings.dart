import 'package:flutter/material.dart';

class UserSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Settings'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          Text('Select your Instrument'),
          ListTile(
            title: Text('Bass Guitar - B0, E1, A1, D2, G2, C3'),
            onTap: () {
              // <save settings>
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Guitar E4, B3, G3, D3, A2, E2'),
            onTap: () {
              Navigator.pop(context);
              // ...
            },
          ),
        ],
      ),
    );
  }
}

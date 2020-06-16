import 'package:flutter/material.dart';

class UserSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
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

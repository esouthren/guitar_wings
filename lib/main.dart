import 'package:flutter/material.dart';
import 'package:guitar_wings/tuner/tuner.dart';
import 'package:guitar_wings/user_settings/user_settings.dart';

void main() => runApp(
      Application(),
    );

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Simple flutter fft example",
      theme: ThemeData.dark(),
      color: Colors.blue,
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text('Hello World!'),
          ),
          drawer: UserSettings(),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 200),
                _button(context, 'Guitar Tuner', Tuner()),
                const SizedBox(height: 30),
                _button(context, 'Second thingy', Tuner()),
                const SizedBox(height: 30),
                _button(context, 'Third Thingy', Tuner()),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _button(BuildContext context, String label, Widget page) => SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: RaisedButton(
          padding: const EdgeInsets.all(10.0),
          onPressed: () {
            Navigator.of(context).push(
              _routeToNewPage(
                page,
              ),
            );
          },
          child: Text(
            label,
            style: TextStyle(fontSize: 50),
          ),
        ),
      );

  _routeToNewPage(Widget newPage) => PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => Tuner(),
        transitionsBuilder: (
          context,
          animation,
          secondaryAnimation,
          child,
        ) {
          return child;
        },
      );
}

import 'package:flutter/material.dart';

class FretboardGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        const SizedBox(height: 25),
        _board,
        _fret,
        _board,
        _fret,
        _board,
        _fret,
        _board,
        _fret,
        _board,
        _fret,
        _board,
        _fret,
      ],
    );
  }
}

Widget get _fret => Container(
      height: 50.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 2,
              child: Container(color: Colors.blueGrey, child: Text(' '))),
          Expanded(
              flex: 1, child: Container(color: Colors.grey, child: Text(' '))),
          Expanded(
              flex: 2,
              child: Container(color: Colors.blueGrey, child: Text(' '))),
          Expanded(
              flex: 1, child: Container(color: Colors.grey, child: Text(' '))),
          Expanded(
              flex: 2,
              child: Container(color: Colors.blueGrey, child: Text(' '))),
          Expanded(
              flex: 1, child: Container(color: Colors.grey, child: Text(' '))),
          Expanded(
              flex: 2,
              child: Container(color: Colors.blueGrey, child: Text(' '))),
          Expanded(
              flex: 1, child: Container(color: Colors.grey, child: Text(' '))),
          Expanded(
              flex: 2,
              child: Container(color: Colors.blueGrey, child: Text(' '))),
        ],
      ),
    );

Widget get _board => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            flex: 2,
            child: Container(color: Colors.amberAccent, child: Text(' '))),
        Expanded(
            flex: 1, child: Container(color: Colors.grey, child: Text(' '))),
        Expanded(
            flex: 2,
            child: Container(color: Colors.amberAccent, child: Text(' '))),
        Expanded(
            flex: 1, child: Container(color: Colors.grey, child: Text(' '))),
        Expanded(
            flex: 2,
            child: Container(color: Colors.amberAccent, child: Text(' '))),
        Expanded(
            flex: 1, child: Container(color: Colors.grey, child: Text(' '))),
        Expanded(
            flex: 2,
            child: Container(color: Colors.amberAccent, child: Text(' '))),
        Expanded(
            flex: 1, child: Container(color: Colors.grey, child: Text(' '))),
        Expanded(
            flex: 2,
            child: Container(color: Colors.amberAccent, child: Text(' '))),
      ],
    );

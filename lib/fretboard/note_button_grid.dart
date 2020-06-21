import 'dart:math';

import 'package:flutter/material.dart';

class NoteButtonGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 25),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  _button(context, 'A', isNatural: true),
                  _button(context, 'B', isNatural: true),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  _button(context, 'A#/Bb', isNatural: false),
                ],
              ),
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  _button(context, 'C', isNatural: true),
                  _button(context, 'D', isNatural: true),
                  _button(context, 'E', isNatural: true),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  _button(context, 'C#/Db', isNatural: false),
                  _button(context, 'D#/Eb', isNatural: false),
                ],
              ),
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  _button(context, 'F', isNatural: true),
                  _button(context, 'G', isNatural: true),
                  _spacer,
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  _button(context, 'F#/Gb', isNatural: false),
                  _button(context, 'G#/Ab', isNatural: false),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}

_randomizeNote() {
  print('randomizing note!');
  return 1 + Random().nextInt(10 - 1);
}

_button(BuildContext context, String label, {bool isNatural = true}) => Padding(
      padding: EdgeInsets.all(2.0),
      child: SizedBox(
        child: RaisedButton(
          color: label == '' ? Colors.red : Colors.blue,
          padding: const EdgeInsets.all(10.0),
          onPressed: () {
            _randomizeNote();
          },
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              label,
            ),
          ),
        ),
      ),
    );

Widget get _spacer => Padding(
      padding: EdgeInsets.all(2.0),
      child: SizedBox(
        child: RaisedButton(
          color: Colors.blueGrey,
          padding: const EdgeInsets.all(10.0),
          onPressed: () {
            // a thing
          },
        ),
      ),
    );

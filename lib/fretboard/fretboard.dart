import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:guitar_wings/data/note.dart';

import 'fretboard_grid.dart';
import 'note_button_grid.dart';

class Fretboard extends StatefulWidget {
  @override
  FretboardState createState() => FretboardState();
}

class FretboardState extends State<Fretboard> {
  Note currentNote;
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(
          "Fretboard Trainer",
          style: new TextStyle(color: Colors.white),
        ),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            this.dispose();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 25.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Fretboard Trainer',
                style: TextStyle(
                  fontSize: 50,
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly, // first column split
                children: [
                  Expanded(
                    flex: 1,
                    child: NoteButtonGrid(),
                  ),
                  Expanded(
                    flex: 1,
                    child: FretboardGrid(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

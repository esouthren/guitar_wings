import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_fft/flutter_fft.dart';

class Tuner extends StatefulWidget {
  @override
  TunerState createState() => TunerState();
}

class TunerState extends State<Tuner> {
  double frequency;
  String note;
  bool isRecording;

  FlutterFft flutterFft = new FlutterFft();

  @override
  void initState() {
    super.initState();

    isRecording = flutterFft.getIsRecording;
    frequency = flutterFft.getFrequency;
    note = flutterFft.getNote;
    _startRecording();
  }

  @override
  void dispose() async {
    print('disposing again..');
    if (flutterFft.getIsRecording) {
      await flutterFft.stopRecorder();
    }
    print('stopped recording!');
    print('recording? ${flutterFft.getIsRecording}');

    super.dispose();
    Navigator.maybePop(context);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(
          "Tuner!",
          style: new TextStyle(color: Colors.white),
        ),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            print('tappa tapped');
            this.dispose();
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            isRecording
                ? Text(
                    "Current note: $note",
                    style: TextStyle(
                      fontSize: 35,
                    ),
                  )
                : Text(
                    "-",
                    style: TextStyle(
                      fontSize: 35,
                    ),
                  ),
            isRecording
                ? Text(
                    "Current frequency: ${frequency.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 35,
                    ),
                  )
                : Text(
                    "-",
                    style: TextStyle(
                      fontSize: 35,
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  _startRecording() async {
    print("starting...");
    print(flutterFft.getTuning);
    flutterFft.setTuning = ["B0", "E1", "A1", "D2", "G2", "C3"];
    print(flutterFft.getTuning);

    await flutterFft.startRecorder();
    if (mounted) {
      setState(() => isRecording = flutterFft.getIsRecording);
    }
    flutterFft.onRecorderStateChanged.listen(
      (data) => {
        {
          if (mounted && flutterFft.getIsRecording)
            {
              print('setting state data!'),
              setState(
                () => {
                  frequency = data[1],
                  note = data[2],
                },
              ),
              flutterFft.setNote = note,
              flutterFft.setFrequency = frequency,
            },
        },
      },
    );
  }
}

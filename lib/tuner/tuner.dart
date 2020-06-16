import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_fft/flutter_fft.dart';

class Tuner extends StatefulWidget {
  @override
  TunerState createState() => TunerState();
}

class TunerState extends State<Tuner> {
  double frequency;

  // e.g. A, A#, Bb
  String note;

  bool isRecording;

  bool isOnPitch;

  // Given a frequency, the frequency of the nearest, in-pitch note.
  double target;

  FlutterFft flutterFft = new FlutterFft();

  @override
  void initState() {
    super.initState();

    isRecording = flutterFft.getIsRecording;
    frequency = flutterFft.getFrequency;
    note = flutterFft.getNote;
    isOnPitch = flutterFft.getIsOnPitch;
    target = flutterFft.getTarget;
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
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 50),
            Text(
              'Tuner',
              style: TextStyle(
                fontSize: 80,
              ),
            ),
            const SizedBox(height: 50),
            _makeTunerRow(context),
            Text(
              isRecording ? note : '-',
              style: TextStyle(
                fontSize: 140,
                color: isOnPitch ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 10),
            _makeTunerRow(context),
            const SizedBox(height: 30),
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
            isRecording
                ? Text(
                    "On pitch?: ${isOnPitch}",
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
              setState(
                () => {
                  print(data),
                  frequency = data[1],
                  note = data[2],
                  isOnPitch = data[10],
                  target = data[7],
                },
              ),
              flutterFft.setNote = note,
              flutterFft.setFrequency = frequency,
              flutterFft.setIsOnPitch = isOnPitch,
              flutterFft.setTarget = target,
            },
        },
      },
    );
  }

  Widget _makeTunerRow(BuildContext context) {
    final width = (MediaQuery.of(context).size.width * 0.9) / 7;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: width,
          width: width,
          color: _getColor(minDistance: -50, maxDistance: -200),
        ),
        Container(
          height: width,
          width: width,
          color: _getColor(minDistance: -3, maxDistance: -5),
        ),
        Container(
          height: width,
          width: width,
          color: _getColor(minDistance: -1, maxDistance: -3),
        ),
        Container(
          height: width,
          width: width,
          color: _getColor(minDistance: -1, maxDistance: 1),
        ),
        Container(
          height: width,
          width: width,
          color: _getColor(minDistance: 1, maxDistance: 3),
        ),
        Container(
          height: width,
          width: width,
          color: _getColor(minDistance: 3, maxDistance: 5),
        ),
        Container(
          height: width,
          width: width,
          color: _getColor(minDistance: 5, maxDistance: 200),
        ),
      ],
    );
  }

  Color _getColor({int minDistance, int maxDistance}) {
    //final targetFrequency = target;
    final distanceFromOnPitchTarget = frequency - target;
    print('distance from on pitch: $distanceFromOnPitchTarget');
    // ^ can also extract distance from data[4]
    if (distanceFromOnPitchTarget > minDistance &&
        distanceFromOnPitchTarget < maxDistance) {
      return isOnPitch ? Colors.green : Colors.red;
    }
    return Colors.blueGrey;
  }
}

// [data] index
//returnData.add(tolerance);
//returnData.add(FlutterFftPlugin.frequency); // ADDS FREQUENCY TO THE RETURN ARRAY
//returnData.add(FlutterFftPlugin.note); // ADDS NOTE TO THE RETURN ARRAY
//returnData.add(FlutterFftPlugin.target); // what's the nearest in tune note?
//returnData.add(FlutterFftPlugin.distance); // distance between current frequency and Target frequency
//returnData.add(FlutterFftPlugin.octave); // ADDS OCTAVE TO THE RETURN ARRAY
//returnData.add(FlutterFftPlugin.nearestNote); // nearest note
//returnData.add(FlutterFftPlugin.nearestTarget); second smallest target
//returnData.add(FlutterFftPlugin.nearestDistance); distance from that ^
//returnData.add(FlutterFftPlugin.nearestOctave); // which octave we're in
//returnData.add(isOnPitch);

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
                fontSize: 100,
                color: isOnPitch ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 30),
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

    // bass
    //flutterFft.setTuning = ["B0", "E1", "A1", "D2", "G2", "C3"];

    // standard electric
    flutterFft.setTuning = ["E2", "A2", "D3", "G3", "B3", "E4"];
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
                  note = data[6],
                  isOnPitch = data[10],
                  target = data[3],
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
    final rowCount = 15;
    final width = (MediaQuery.of(context).size.width * 0.9) / rowCount;
    final centreIndex = ((rowCount - 1) / 2).toInt();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (var i = 0; i < rowCount; i++)
//            Container(
//              height: width,
//              width: width,
            Text(
              '${i - 7}',
              style: TextStyle(
                color: _getColor(i, centreIndex, rowCount),
              ),
            ),

//          Container(
//            height: width,
//            width: width,
//            color: _getColor(minDistance: -5, maxDistance: -200),
//          ),
//          Container(
//            height: width,
//            width: width,
//            color: _getColor(minDistance: -3, maxDistance: -5),
//          ),
//          Container(
//            height: width,
//            width: width,
//            color: _getColor(minDistance: -1, maxDistance: -3),
//          ),
//          Container(
//            height: width,
//            width: width,
//            color: _getColor(minDistance: -1, maxDistance: 1),
//          ),
//          Container(
//            height: width,
//            width: width,
//            color: _getColor(minDistance: 1, maxDistance: 3),
//          ),
//          Container(
//            height: width,
//            width: width,
//            color: _getColor(minDistance: 3, maxDistance: 5),
//          ),
//          Container(
//            height: width,
//            width: width,
//            color: _getColor(minDistance: 5, maxDistance: 200),
//          ),
        ],
      ),
    );
  }

  Color _getColor(int index, int centreIndex, int rowCount) {
    //final targetFrequency = target;
    final distanceFromOnPitchTarget = frequency - target;
    print('distance from on pitch: $distanceFromOnPitchTarget');
    final offCentreBy = (centreIndex - index);
    final iteratorCount = (rowCount - 1) / 2;
    final splits =
        14 / rowCount; // +/- 7 Hz on each side (not including centre)
//    switch (offCentreBy) {
//      case 0:
//        return isOnPitch ? Colors.green : Colors.red;
//      case 1:
//        return (frequency > 1 && frequency < (1 + splits * index))
//            ? Colors.red
//            : Colors.green;

    if (index == centreIndex) {
      return isOnPitch ? Colors.green : Colors.blueGrey;
    }
    if (index == 0 && distanceFromOnPitchTarget < -7) return Colors.red;
    if (index == rowCount && distanceFromOnPitchTarget > 7) return Colors.red;

    final maxDistance = 1 + (offCentreBy * splits);
    final minDistance = 1 + ((offCentreBy - 1) * splits);
    //for (var i = 1; i < rowCount-1; i++) {
    if (distanceFromOnPitchTarget > minDistance &&
        distanceFromOnPitchTarget <= maxDistance) {
      return Colors.red;
    } else
      return Colors.blueGrey;
  }
//
//    //for(var i = 0; i < )
//    // ^ can also extract distance from data[4]
//    if (distanceFromOnPitchTarget >= minDistance &&
//        distanceFromOnPitchTarget < maxDistance) {
//      return isOnPitch ? Colors.green : Colors.red;
//    }
//    return Colors.blueGrey;

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

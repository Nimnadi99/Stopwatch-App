import 'package:flutter/material.dart';
import 'dart:async';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  static const duration = const Duration(seconds: 1);
  int secondsPassed = 0;
  bool isActive = false;
  late Timer timer;

  void handleTick(Timer timer) {
    if (isActive) {
      setState(() {
        secondsPassed = secondsPassed + 1;
      });
    }
  }

  void startTimer() {
    timer = Timer.periodic(duration, handleTick);
  }

  void stopTimer() {
    timer.cancel();
  }

  void resetTimer() {
    setState(() {
      secondsPassed = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    int seconds = secondsPassed % 60;
    int minutes = (secondsPassed ~/ 60) % 60;
    int hours = secondsPassed ~/ 3600;
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('The Timer App'),
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomTextContainer(
                      label: 'Hours', value: hours.toString().padLeft(2, '0')),
                  CustomTextContainer(
                      label: 'Minutes', value: minutes.toString().padLeft(2, '0')),
                  CustomTextContainer(
                      label: 'Seconds', value: seconds.toString().padLeft(2, '0')),
                ],
              ),
              SizedBox(height: 20), // Add spacing between buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 10), // Add margin to separate buttons
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.red; // Color when pressed
                            }
                            return Colors.green; // Default color
                          },
                        ),
                      ),
                      child: Text(isActive ? 'PAUSE' : 'START', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      onPressed: () {
                        setState(() {
                          if (isActive) {
                            stopTimer();
                          } else {
                            if (secondsPassed == 0) {
                              startTimer();
                            } else {
                              startTimer();
                            }
                          }
                          isActive = !isActive;
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10), // Add margin to separate buttons
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.green; // Color when pressed
                            }
                            return Colors.red; // Default color
                          },
                        ),
                      ),
                      child: Text('RESET', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      onPressed: () {
                        setState(() {
                          resetTimer();
                          if (isActive) {
                            stopTimer();
                            isActive = false;
                          }
                        });
                      },
                    ),
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

class CustomTextContainer extends StatelessWidget {
  CustomTextContainer({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.all(20),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(10),
        color: Colors.black,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '$value',
            style: TextStyle(
              color: Colors.white,
              fontSize: 54,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '$label',
            style: TextStyle(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}

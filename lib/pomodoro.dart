// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Pomodoro extends StatefulWidget {
  const Pomodoro({super.key});

  @override
  State<StatefulWidget> createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  double percent = 0;
  static int TimeInMinut = 25;
  int TimeInSec = TimeInMinut * 60;
  late Timer timer;
  String buttonText = 'Kodlamaya Başla';
  bool isRunning = false;
  bool isResting = false;
  int restTime = 5;

  _StartTimer() {
    TimeInMinut = 25;
    int Time = TimeInMinut * 60;
    double SecPercent = (Time / 100);
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (Time > 0) {
          Time--;
          if (Time % 60 == 0) {
            TimeInMinut--;
          }
          if (Time % SecPercent == 0) {
            if (percent < 1) {
              percent += 0.01;
            } else {
              percent = 1;
            }
          }
        } else {
          percent = 0;
          TimeInMinut = isResting ? restTime : 25; // yeni değişiklik
          isResting = !isResting; // yeni değişiklik
          timer.cancel();
          _StartTimer();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF088395),
                Color(0xFF00FFCA),
              ],
              begin: FractionalOffset(0.4, 0.1),
            ),
          ),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 25.0),
                child: Text(
                  'Pomodoro Saat',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                  ),
                ),
              ),
              Expanded(
                child: CircularPercentIndicator(
                  circularStrokeCap: CircularStrokeCap.round,
                  percent: percent,
                  animation: true,
                  animateFromLastPercent: true,
                  radius: 150,
                  lineWidth: 20,
                  progressColor: const Color.fromARGB(255, 84, 167, 190),
                  center: Text(
                    '$TimeInMinut',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 80,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 20, right: 20),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: const <Widget>[
                                    Text(
                                      'Kod Zamanı',
                                      style: TextStyle(
                                        fontSize: 30,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '25',
                                      style: TextStyle(
                                        fontSize: 80,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: const <Widget>[
                                    Text(
                                      'Mola',
                                      style: TextStyle(
                                        fontSize: 30,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '5',
                                      style: TextStyle(
                                        fontSize: 80,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 28),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (!isRunning) {
                                  isRunning = true;
                                  buttonText = 'Durdur';
                                  _StartTimer();
                                } else {
                                  isRunning = false;
                                  buttonText = 'Kodlamaya Başla';
                                  timer.cancel();
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 43, 182, 221),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            child: Text(
                              buttonText,
                              style:
                                  const TextStyle(color: Colors.white, fontSize: 22),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

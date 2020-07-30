import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef TimeUpdatedCallback = void Function(Time time);

enum TimerState { RUNNING, PAUSED, STOPPED }

class Time {
  final int hour;
  final int minute;
  final int second;

  Time(this.hour, this.minute, this.second);
}

class DigitalTimer {
  final bool countDown;
  final int time;
  final TimeUpdatedCallback timeUpdatedCallback;
  final VoidCallback countDownCompleted;
  int _durationInSeconds;
  Timer _timer;
  TimerState _timerState;

  DigitalTimer(
      {Key key,
      @required this.timeUpdatedCallback,
      this.countDown = true,
      this.time = 0,
      this.countDownCompleted})
      : assert(timeUpdatedCallback != null);

  void startTimer() {
    if (_timerState != TimerState.PAUSED) {
      this.timeUpdatedCallback(
          Time(time ~/ 3600, (time ~/ 60) % 60, time % 60));
      _durationInSeconds = time;
      if (_timer == null) {
        _timer =
            Timer.periodic(Duration(seconds: 1), (Timer t) => _onTimerTick(t));
      }
    }
    _timerState = TimerState.RUNNING;
  }

  void stopTimer() {
    _timerState = TimerState.STOPPED;
    _timer?.cancel();
    _timer = null;
  }

  void pauseTimer() {
    _timerState = TimerState.PAUSED;
  }

  void _onTimerTick(Timer timer) {
    if (_timerState != TimerState.PAUSED) {
      this.countDown ? max(0, --_durationInSeconds) : ++_durationInSeconds;
      if (_durationInSeconds < 0) {
        stopTimer();
        if (this.countDownCompleted != null) {
          this.countDownCompleted();
        }
      } else {
        this.timeUpdatedCallback(Time(_durationInSeconds ~/ 3600,
            (_durationInSeconds ~/ 60) % 60, _durationInSeconds % 60));
      }
    }
  }

  int getDurationInSeconds() {
    return _durationInSeconds;
  }
}

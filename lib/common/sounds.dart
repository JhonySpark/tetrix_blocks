import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';

class Sound extends StatefulWidget {
  final Widget child;

  const Sound({Key key, this.child}) : super(key: key);

  @override
  SoundState createState() => SoundState();

  static SoundState of(BuildContext context) {
    final state = context.ancestorStateOfType(const TypeMatcher<SoundState>());
    assert(state != null, 'can not find Sound widget');
    return state;
  }
}

const _SOUNDS = [
  'put.mp3',
  'star.mp3',
  'loose1.mp3',
  'loose2.mp3',
];

class SoundState extends State<Sound> {
  Soundpool _pool;

  Map<String, int> _soundIds;

  bool mute = false;

  void _play(String name) {
    final soundId = _soundIds[name];
    if (soundId != null && !mute) {
      _pool.play(soundId);
    }
  }

  @override
  void initState() {
    super.initState();
    _pool = Soundpool(streamType: StreamType.music, maxStreams: 4);
    _soundIds = Map();
    for (var value in _SOUNDS) {
      scheduleMicrotask(() async {
        final data = await rootBundle.load('assets/sounds/$value');
        _soundIds[value] = await _pool.load(data);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _pool.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void putBlock() {
    _play('put.mp3');
  }

  void star() {
    _play('star.mp3');
  }

  void loose1() {
    _play('loose1.mp3');
  }

  void loose2() {
    _play('loose2.mp3');
  }
}

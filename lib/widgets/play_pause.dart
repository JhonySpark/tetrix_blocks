import 'package:blocks_puzzle/common/utils.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PlayPause extends StatefulWidget {
  final GameStateCallback gameStateCallback;
  _PlayPauseState _playPauseState;

  PlayPause(this.gameStateCallback);

  @override
  _PlayPauseState createState() {
    _playPauseState = _PlayPauseState();
    return _playPauseState;
  }

  void play() {
    _playPauseState?.play();
  }
}

class _PlayPauseState extends State<PlayPause> {
  String _animationState = "Idle_pause";
  String _playAnimationState = "Play";
  String _pauseAnimationState = "Pause";

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shadowColor: Colors.grey[100],
      child: InkWell(
          onTap: toggleState,
          child: FlareActor("assets/PlayPauseWithStates.flr",
              alignment: Alignment.center,
              fit: BoxFit.contain,
              animation: _animationState)),
    );
  }

  void toggleState() {
    setState(() {
      _animationState = _animationState == _pauseAnimationState
          ? _playAnimationState
          : _pauseAnimationState;
      _animationState == _pauseAnimationState
          ? widget.gameStateCallback(context, GameState.PAUSE)
          : widget.gameStateCallback(context, GameState.PLAY);
    });
  }

  void play() {
    setState(() {
      _animationState = _playAnimationState;
    });
  }
}

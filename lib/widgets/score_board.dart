import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ScoreBoard extends StatefulWidget {
  _ScoreBoardState _scoreBoardState;

  @override
  State<StatefulWidget> createState() {
    _scoreBoardState = _ScoreBoardState();
    return _scoreBoardState;
  }

  void updateScoreboard(int score) {
    _scoreBoardState?.updateScoreboard(score);
  }
}

class _ScoreBoardState extends State<ScoreBoard> {
  int _currentScore = 0;

  @override
  Widget build(BuildContext context) {
    return _buildScoreBoard();
  }

  //Top section includes timer, scoreboard
  Widget _buildScoreBoard() {
    return Material(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Column(
            children: [
       /*        SvgPicture.asset(
                'assets/images/ic_award_cup.svg',
                width: 48.0,
                height: 48.0,
              ), */
              Text(
                '$_currentScore',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35.0,
                    /* fontFamily: 'HPunk' */),
              )
            ],
          ),
        ));
  }

  void updateScoreboard(int score) {
    setState(() {
      _currentScore = score;
    });
  }
}

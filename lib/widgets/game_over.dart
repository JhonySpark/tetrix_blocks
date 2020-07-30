import 'package:blocks_puzzle/common/shared_prefs.dart';
import 'package:blocks_puzzle/model/game_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GameOverPopup extends StatefulWidget {
  @override
  _GameOverPopupState createState() => _GameOverPopupState();
}

class _GameOverPopupState extends State<GameOverPopup> {
  GameSession _gameSessionStats;

  @override
  void initState() {
    super.initState();

    _loadGameSession();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              // Where the linear gradient begins and ends
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              // Add one stop for each color. Stops should increase from 0 to 1
              stops: [0.1, 0.5, 0.9],
              colors: [
                // Colors are easy thanks to Flutter's Colors class.
                Colors.orange[50],
                Colors.orange[100],
                Colors.orange[200],
              ],
            ),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(color: Colors.redAccent)),
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Game Over!!',
              style: TextStyle(
                  color: Colors.teal, fontSize: 30.0, fontFamily: 'HPunk'),
            ),
            Padding(
                padding: EdgeInsets.all(5.0),
                child: SvgPicture.asset(
                  'assets/images/ic_award_cup.svg',
                  width: 64.0,
                  height: 64.0,
                )),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Score = ${_gameSessionStats?.score}',
                  style: TextStyle(
                      color: Colors.red, fontSize: 24.0, fontFamily: 'Cherl'),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.only(right: 5.0),
                    child: SvgPicture.asset(
                      'assets/images/ic_star_light.svg',
                      width: 28.0,
                      height: 28.0,
                    )),
                Text(
                  ' X ${_gameSessionStats?.starsCollected}',
                  style: TextStyle(
                      color: Colors.red, fontSize: 20.0, fontFamily: 'Cheri'),
                )
              ],
            ),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Time taken : ${_getFormattedTime(
                      _gameSessionStats?.timeInSeconds)}',
                  style: TextStyle(
                      color: Colors.pinkAccent,
                      fontSize: 20.0,
                      fontFamily: 'Cherl'),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0, right: 5.0),
                  child: InkWell(
                    child: Container(
                      width: 80.0,
                      height: 80.0,
                      child: SvgPicture.asset('assets/images/ic_replay.svg'),
                    ),
                    onTap: _restartGame,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.0, top: 20.0, bottom: 20.0),
                  child: InkWell(
                    child: Container(
                      width: 80.0,
                      height: 80.0,
                      child: SvgPicture.asset('assets/images/ic_cart.svg'),
                    ),
                    onTap: _buyStars,
                  ),
                )
              ],
            ),
          ],
        ));
  }

  _loadGameSession() async {
    GameSession stats = await BlockzSharedPrefs.getInstance().getSessionStats();
    setState(() {
      _gameSessionStats = stats;
    });
  }

  void _buyStars() {}

  void _restartGame() {
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, '/home');
  }

  String _getFormattedTime(int _timeInSeconds) {
    if (_timeInSeconds == null) {
      return "";
    } else {
      String formattedText = "";
      int hours = _timeInSeconds ~/ 3600;
      int minutes = (_timeInSeconds ~/ 60) % 60;
      int seconds = _timeInSeconds % 60;
      return hours > 0
          ? "$hours h $minutes m $seconds s"
          : minutes > 0 ? "$minutes m $seconds s" : "$seconds s";
    }
  }
}

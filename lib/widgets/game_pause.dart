import 'package:blocks_puzzle/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GamePausePopup extends StatefulWidget {
  final PlayCallback playCallback;

  GamePausePopup({this.playCallback});

  @override
  _GamePausePopupState createState() => _GamePausePopupState();
}

class _GamePausePopupState extends State<GamePausePopup> {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0, right: 5.0),
                  child: InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.yellow[600],
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          border: Border.all(color: Colors.lightBlue)),
                      width: 70.0,
                      height: 70.0,
                      child: SvgPicture.asset('assets/images/ic_play.svg'),
                    ),
                    onTap: _play,
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

  void _play() {
    Navigator.pop(context);
    if (widget.playCallback != null) {
      widget.playCallback();
    }
  }

  void _buyStars() {}
}

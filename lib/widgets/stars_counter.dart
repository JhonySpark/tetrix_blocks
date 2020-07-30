import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StarsCounter extends StatefulWidget {
  _StarsCounterState _starsCounterState;

  @override
  State<StatefulWidget> createState() {
    _starsCounterState = _StarsCounterState();
    return _starsCounterState;
  }

  void updateStars(int starsCount) {
    _starsCounterState?.updateStars(starsCount);
  }

  Offset getPosition() {
    return _starsCounterState?.getPosition();
  }
}

class _StarsCounterState extends State<StarsCounter> {
  int _starsCount = 0;
  double _startIconSize = 35.0;

  @override
  Widget build(BuildContext context) {
    return _buildStarsCounter();
  }

  Widget _buildStarsCounter() {
    return Material(
        color: Colors.transparent,
        child: Container(
            margin: EdgeInsets.only(right: 20.0),
            /*   decoration: BoxDecoration(
                border: Border.all(color: Colors.orangeAccent),
                borderRadius: BorderRadius.all(Radius.circular(5.0))), */
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Row(
                children: [
                  AnimatedContainer(
                      duration: Duration(microseconds: 500),
                      curve: Curves.fastOutSlowIn,
                      padding: EdgeInsets.only(right: 5.0),
                      child: SvgPicture.asset(
                        'assets/images/ic_star.svg',
                        width: this._startIconSize,
                        height: this._startIconSize,
                      )),
                  Text(
                    '$_starsCount',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35.0,
                      /*  fontFamily: 'Fighting Spirit'), */
                    ),
                  ),
                ],
              ),
            )));
  }

  void updateStars(int starsCount) {
    setState(() {   
      _starsCount = starsCount;
    });
    print(_starsCount);
  }

  Offset getPosition() {
    RenderBox renderbox = context.findRenderObject();
    return renderbox.localToGlobal(Offset.zero);
  }
}

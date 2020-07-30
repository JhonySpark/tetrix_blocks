import 'package:blocks_puzzle/common/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _score = 0;
  int _starsCount = 0;

  @override
  void initState() {
    super.initState();

    _loadScore();
    _loadStarsCount();
  }

  @override
  Widget build(BuildContext context) {
    return _createSplashLayout(context);
  }

  Widget _createSplashLayout(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _getHeaderView(),
          _getCenterView(context),
          _getFooterView(),
        ],
      ),
    );
  }

  Widget _getHeaderView() {
    return Expanded(
      flex: 2,
      child: Container(
          margin: EdgeInsets.only(top: 50.0),
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/images/ic_award_cup.svg',
                width: 48.0,
                height: 48.0,
              ),
              Text(
                _score > 0 ? '$_score' : '',
                style:
                    TextStyle(color: Colors.deepPurpleAccent, fontSize: 28.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(10.0),
                      child: SvgPicture.asset(
                        'assets/images/ic_star.svg',
                        width: 32.0,
                        height: 32.0,
                      )),
                  Text(
                    _starsCount > 0 ? '$_starsCount' : '',
                    style: TextStyle(color: Colors.redAccent, fontSize: 20.0),
                  ),
                ],
              ),
            ],
          )),
    );
  }

  Widget _getFooterView() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(20.0),
        child: Text(
          '\u{1F171}\u{1F17B}\u{1F17E}\u{1F172}\u{1F17A}\u{1F189}',
          style: TextStyle(color: Colors.white, fontSize: 32.0),
        ),
      ),
    );
  }

  Widget _getCenterView(BuildContext context) {
    return Expanded(
        flex: 2,
        child: Container(
          child: Column(
            children: [
              InkWell(
                  highlightColor: Colors.green,
                  splashColor: Colors.white70,
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  child: Container(
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        color: Colors.lime[100],
                      ),
                      child: SvgPicture.asset(
                        'assets/images/ic_play.svg',
                      ))),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      width: 80.0,
                      height: 80.0,
                      child: SvgPicture.asset('assets/images/ic_like.svg'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Container(
                        width: 80.0,
                        height: 80.0,
                        decoration: BoxDecoration(
                            color: Colors.green[100],
                            borderRadius:
                            BorderRadius.all(Radius.circular(5.0))),
                        child:
                        SvgPicture.asset('assets/images/ic_facebook.svg'),
                      ),
                    ),
                  ],
                ),
              ), //),
            ],
          ),
        ));
  }

  _loadScore() async {
    int score = await BlockzSharedPrefs.getInstance().getHighestScore();
    setState(() {
      _score = score;
    });
  }

  _loadStarsCount() async {
    int starsCount = await BlockzSharedPrefs.getInstance().getTotalStars();
    setState(() {
      _starsCount = starsCount;
    });
  }
}

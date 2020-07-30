import 'package:blocks_puzzle/common/utils.dart';
import 'package:blocks_puzzle/routes/game_home.dart';
import 'package:blocks_puzzle/routes/splash.dart';
import 'package:blocks_puzzle/widgets/game_over.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'common/sounds.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(BlocksPuzzleApp());
  });
}

class BlocksPuzzleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: Scaffold(
        backgroundColor: screenBgColor,
        body: SplashScreen(),
      ),
      routes: <String, WidgetBuilder>{
        '/splash': (BuildContext context) => SplashScreen(),
        '/home': (BuildContext context) => Sound(child: GameScreen()),
        '/game_over': (BuildContext context) => GameOverPopup(),
      },
    );
  }
}

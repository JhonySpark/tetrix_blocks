import 'package:blocks_puzzle/model/game_session.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Conversion from GameSession to Json', () {
    GameSession gameSession = GameSession(453, 30, 34, 2377927944);
    expect({
      'score': 453,
      'starsCollected': 30,
      'timeInSeconds': 34,
      'timestampCreated': 2377927944
    }, gameSession.toJson());
  });

  test('Conversion from Json to GameSession', () {
    Map<String, dynamic> json = {
      'score': 709,
      'starsCollected': 20,
      'timeInSeconds': 54,
      'timestampCreated': 948504583
    };

    GameSession gameSession = GameSession.fromJson(json);
    expect(709, gameSession.score);
    expect(20, gameSession.starsCollected);
    expect(54, gameSession.timeInSeconds);
    expect(948504583, gameSession.timestampCreated);
  });
}

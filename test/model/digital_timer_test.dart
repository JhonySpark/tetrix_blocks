import 'package:blocks_puzzle/model/digital_timer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('DigitalTimer object construction', () {
    DigitalTimer digitalTimer =
        DigitalTimer(timeUpdatedCallback: (Time time) {});

    expect(true, digitalTimer.timeUpdatedCallback != null);
    expect(null, digitalTimer.countDownCompleted);
    expect(true, digitalTimer.countDown);
    expect(0, digitalTimer.time);
  });
}
